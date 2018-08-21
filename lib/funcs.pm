package funcs;

# This package provides reusable functions to be consumed by the rest of the application

use strict;
use warnings;

use Exporter qw(import);
use Data::Dumper;
use Config::IniHash;

$Data::Dumper::Terse = 1;
$Data::Dumper::Useqq = 1;
$Data::Dumper::Deparse = 1;
$Data::Dumper::Quotekeys = 0;
$Data::Dumper::Sortkeys = 1;

our @EXPORT = qw(prompt db updaterecord newrecord notimplemented nocommand nosubcommand listchoices lookupval updatedata today validate ini printlist round pad lookupcol thin resolvenegid chooseneg annotatefilm);

# Prompt for an arbitrary value
sub prompt {
	my $default = shift || "";
	my $prompt = shift;
	my $type = shift || 'text';

	my $rv;
	# Repeatedly prompt until we get a response of the correct type
	do {
		print "$prompt ($type) [$default]: ";
		my $input = <STDIN>;
		chomp($input);
		$rv = ($input eq "") ? $default:$input;
	} while (!&validate($rv, $type));

	# Rewrite friendly bools
	if ($type eq 'boolean') {
		return friendlybool($rv);
	} else {
		return $rv;
	}
}

# Validate that a value is a certain type
sub validate {
	my $val = shift;
	my $type = shift || 'text';

	if ($val eq '') {
		return 1;
	}
	elsif ($type eq 'boolean') {
		if ($val =~ m/^(y(es)?|no?|false|true|1|0)$/i) {
			return 1;
		} else {
			return 0;
		}
	} elsif ($type eq 'integer') {
		if ($val =~ m/^\d+$/) {
			return 1;
		} else {
			return 0;
		}
	} elsif ($type eq 'text') {
		if ($val =~ m/^.+$/) {
			return 1;
		} else {
			return 0;
		}
	} elsif ($type eq 'date') {
		if ($val =~ m/^\d{4}-\d{2}-\d{2}$/) {
			return 1;
		} else {
			return 0;
		}

	} elsif ($type eq 'decimal') {
		if ($val =~ m/^\d+(\.\d+)?$/) {
			return 1;
		} else {
			return 0;
		}
	} elsif ($type eq 'hh:mm:ss') {
		if ($val =~ m/^\d\d?:\d\d?:\d\d?$/) {
			return 1;
		} else {
			return 0;
		}
	} else {
		die "$type is not a valid data type\n";
	}
}

# Find ini file
sub ini {
	# Look for ini file
	my $path = "$ENV{HOME}/.photodb.ini";
	if (-f $path) {
		return glob('~/.photodb.ini');
	} else {
		if (prompt('yes', 'Could not find config file. Generate one now?', 'boolean')) {
			&writeconfig($path);
			return $path;
		} else {
			exit;
		}
	}
}

# Connect to the database
sub db {
	my $connect = ReadINI(&ini);

	# host, schema, user, pass
	if (!defined($$connect{'database'}{'host'}) || !defined($$connect{'database'}{'schema'}) || !defined($$connect{'database'}{'user'}) || !defined($$connect{'database'}{'pass'})) {
		print "Config file did not contain correct values";
		exit;
	}

	my $dbh = DBI->connect("DBI:mysql:database=$$connect{'database'}{'schema'};host=$$connect{'database'}{'host'}",
		$$connect{'database'}{'user'},
		$$connect{'database'}{'pass'},
		{
			mysql_client_found_rows => 0,
			mysql_enable_utf8mb4 => 1,
		}
	) or die "Couldn't connect to database: " . DBI->errstr;
	return $dbh;
}

# Update an existing record in any table
sub updaterecord {
	my $db = shift;

	# Read in hash new values
	my $data = shift;

	# Read in table name
	my $table = shift;

	# Read in where condition
	my $where = shift;

	# Quit if where is null
	if (!defined($where)) {
		print "No valid where clause, not going to do a risky UPDATE\n";
		exit;
	}

	# Delete empty strings from data hash
	$data = &thin($data);

	# Dump data for debugging
	print "\n\nThis is what I will update into $table where $where:\n";
	print Dumper(\$data);

	# Build query
	my $sql = SQL::Abstract->new;
	my($stmt, @bind) = $sql->update($table, $data, $where);

	# Final confirmation
	prompt('yes', 'Proceed?', 'boolean') or die "Aborted!\n";

	# Execute query
	my $sth = $db->prepare($stmt);
	my $rows = $sth->execute(@bind);
	$rows = 0 if ($rows eq  '0E0');
	print "Updated $rows rows\n";
}

# Insert a record into any table
sub newrecord {
	my $db = shift;

	# Read in hash of values
	my $data = shift;

	# Read in table name
	my $table = shift;

	# Delete empty strings from data hash
	$data = &thin($data);

	# Dump data for debugging
	print "\n\nThis is what I will insert into $table:\n";
	print Dumper(\$data);

	# Build query
	my $sql = SQL::Abstract->new;
	my($stmt, @bind) = $sql->insert($table, $data);

	# Final confirmation
	prompt('yes', 'Proceed?', 'boolean') or die "Aborted!\n";

	# Execute query
	my $sth = $db->prepare($stmt);
	$sth->execute(@bind);

	# Display inserted row
	my $insertedrow = $sth->{mysql_insertid};
	print "Inserted $table $insertedrow\n";

	return $insertedrow;
}

# Print a warning that this command/subcommand is not yet implemented
sub notimplemented {
	die "This command or subcommand is not yet implemented.\n";
}

# Quit if no valid command is given
sub nocommand {
	my $handlers = shift;
	print "Photography Database UI\n\n";
	print "$0 <command> <subcommand>\n\n";
	print "Please enter a valid command. Valid commands are:\n";
	print "\t$_\n" for sort keys %$handlers;
	exit;
}

# Quit if no valid subcommand is given
sub nosubcommand {
	my $handlers = shift;
	my $command = shift;
	print "Photography Database UI\n\n";
	print "$0 $command <subcommand>\n\n";
	print "Please enter a valid subcommand. Valid subcommands for '$command' are:\n";
	print "\t" . &pad($_) . $$handlers{$_}{'desc'} . "\n" for sort keys %$handlers;
	exit;
}

# List arbitrary choices and return ID of the selected one
sub listchoices {
	my $db = shift;
	my $keyword = shift;
	my $query = shift;
	my $type = shift || 'integer';
	my $inserthandler = shift;

	my $sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
	my $rows = $sth->execute();

	$sth->execute();
	my @allowedvals;

	while (my $ref = $sth->fetchrow_hashref) {
		print "\t$ref->{id}\t$ref->{opt}\n";
		# Make a note of what allowed options are
		push(@allowedvals, $ref->{id});
	}

	# Add option to insert a new row, if applicable
	if ($inserthandler) {
		print "\t0\tAdd a new $keyword\n";
	}

	# Count number of allowed options and if there's just one, make it the default
	my $default;
	if ($rows == 1) {
		$default = $allowedvals[0];
	} elsif ($rows == 0) {
		print "No valid $keyword options to choose from\n";
		exit;
	} else {
		$default = '';
	}

	# Wait for input
	my $input = prompt($default, "Please select a $keyword from the list, or leave blank to skip", $type);

	# Make sure a valid option was chosen
	if ($input eq '0') {
		# Spawn a new handler if that's what the user chose
		my $id = $inserthandler->($db);
		return $id;
	}
	elsif (grep(/^$input$/, @allowedvals) || $input eq '') {
		# Return input
		return $input;
	} else {
		die("Must choose valid option\n");
	}
}

# List arbitrary rows
sub printlist {
	my $db = shift;
	my $msg = shift;
	my $query = shift;

	print "Now showing $msg\n\n";

	my $sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
	my $rows = $sth->execute();

	$sth->execute();

	while (my $ref = $sth->fetchrow_hashref) {
		print "\t$ref->{id}\t$ref->{opt}\n";
	}
}

# Return values from an arbitrary column from database as an arrayref
sub lookupcol {
	my $db = shift;
	my $query = shift;

	my $sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
	my $rows = $sth->execute();

	$sth->execute();
	my @array;
	while (my $ref = $sth->fetchrow_hashref) {
		$ref = &thin($ref);
		push(@array, $ref);
	}
	return \@array;
}

# Thin out keys will null values from a sparse hash
sub thin {
	my $data = shift;
	foreach (keys %$data) {
		delete $$data{$_} unless (defined $$data{$_} and $$data{$_} ne '');
	}
	return \%$data;
}

# Return arbitrary value from database
sub lookupval {
	my $db = shift;
	my $query = shift;

	my $sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
	my $rows = $sth->execute();

	$sth->execute();
	my $row = $sth->fetchrow_array();

	return $row;
}

# Update data
sub updatedata {
	my $db = shift;
	my $query = shift;
	my $sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
	my $rows = $sth->execute();
	$rows = 0 if ($rows eq '0E0');
	return $rows;
}

# Return today's date
sub today {
	my $db = shift;
	return &lookupval($db, 'select curdate()');
}

# Translate "friendly" bools to integers
sub friendlybool {
	my $val = shift;
	if ($val =~ m/^y(es)?$/i || $val =~ m/^true$/i || $val eq 1) {
		return 1;
	} elsif ($val =~ m/^n(o)?$/i || $val =~ m/^false$/i || $val eq 0) {
		return 0;
	} else {
		return '';
	}
}

sub writeconfig {
	my $inifile = shift;

	# Untaint
	unless ($inifile =~ m#^([\w.-\/]+)$#) {
		die "filename '$inifile' has invalid characters.\n";
	}
	$inifile = $1;

	my %inidata;
	$inidata{'database'}{'host'} = prompt('localhost', 'Database hostname or IP address', 'text');
	$inidata{'database'}{'schema'} = prompt('photography', 'Schema name of photography database', 'text');
	$inidata{'database'}{'user'} = prompt('photography', 'Username with access to the schema', 'text');
	$inidata{'database'}{'pass'} = prompt('', 'Password for this user', 'text');
	$inidata{'filesystem'}{'basepath'} = prompt('', 'Path to your scanned images', 'text');
	WriteINI($inifile, \%inidata);
}

# Round numbers to any precision
sub round {
	my $x = shift;
	my $pow10 = shift || 0;
	my $a = 10 ** $pow10;
	return int(($x * $a) + 0.5) / $a
}

# Pad a string with spaces up to a fixed length
sub pad {
	my $string = shift;
	my $totallength = shift || 18;
	my $lengthofstring = length($string);
	my $pad = $totallength - $lengthofstring;
	my $newstring = $string . ' ' x $pad;
}

# Get a negative ID either from the neg ID or the film/frame ID
sub resolvenegid {
	my $db = shift;
	my $string = shift;
	if ($string =~ m/^\d+$/) {
		# All digits - already a NegID
		return $string;
	} elsif ($string =~ m/^(\d+)\/([a-z0-9]+)$/i) {
		# 999/99A - a film/frame ID
		my $film_id = $1;
		my $frame = $2;
		my $neg_id = &lookupval($db, "select lookupneg($film_id, $frame)");
		return $neg_id;
	} else {
		# Could not resolve
		die "Could not resolve $string to a negative ID\n";
	}
}

sub chooseneg {
	my $db = shift;
	my $film_id = prompt('', 'Enter Film ID', 'integer');
	my $frame = &listchoices($db, 'frame', "select frame as id, description as opt from NEGATIVE where film_id=$film_id", 'text');
	my $neg_id = &lookupval($db, "select lookupneg('$film_id', '$frame')");
	if ($neg_id =~ m/^\d+$/) {
		return $neg_id;
	} else {
		die "Could not find a negative ID for film $film_id and frame $frame\n";
	}
}

# Write out a text file in the film directory
sub annotatefilm {
	my $db = shift;
	my $film_id = shift;

	my $inidata = ReadINI(&ini);
	my $path = $$inidata{'filesystem'}{'basepath'};
	if (defined($path) && $path ne '' && -d $path) {
		my $filmdir = &lookupval($db, "select directory from FILM where film_id=$film_id");
		if (defined($filmdir) && $filmdir ne '' && -d "$path/$filmdir") {
			# proceed
			my $filename = "$path/$filmdir/details.txt";

			my $sth = $db->prepare('SELECT * FROM photography.film_info where `Film ID`=?') or die "Couldn't prepare statement: " . $db->errstr;
			my $rows = $sth->execute($film_id);
			my @output;

			while (my $ref = $sth->fetchrow_hashref) {
				$ref = &thin($ref);
				# Print the film header and remove it from the hash
				push(@output, "Film #$ref->{'Film ID'} \"$ref->{'Title'}\"\n\n");
				delete $ref->{'Film ID'};
				delete $ref->{'Title'};

				# Print remaining key-value pairs for the film
				foreach (sort keys %$ref) {
					push(@output, "$_: $ref->{$_}\n");
				}
			}

			# Now work out the negative details
			my $sth2 = $db->prepare('SELECT * FROM photography.negative_info where film_id=?') or die "Couldn't prepare statement: " . $db->errstr;
			my $rows2 = $sth2->execute($film_id);

			# Print a block for each negative
			while (my $ref = $sth2->fetchrow_hashref) {
				$ref = &thin($ref);
				delete $ref->{'film_id'};
				# Print the negative header and remove it from the hash
				push(@output, "\n");
				push(@output, "Frame $ref->{'Frame'} \"$ref->{'Caption'}\"\n");
				delete $ref->{'Frame'};
				delete $ref->{'Caption'};

				# Print remaining key-value pairs for the negative
				foreach (sort keys %$ref) {
					push(@output, "\t$_: $ref->{$_}\n");
				}
			}
			# Write the compiled array out to a file
			open my $fh, '>', $filename or die "Cannot open $filename: $!";
			foreach (@output) {
				print $fh $_;
			}
			close $fh;
		} else {
			die "Film directory $path/$filmdir not found\n";
		}
	} else {
		die "Path $path not found\n";
	}
}

# This ensures the lib loads smoothly
1;
