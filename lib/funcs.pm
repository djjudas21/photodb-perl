package funcs;

# This package provides reusable functions to be consumed by the rest of the application

use strict;
use warnings;

use DBI;
use DBD::mysql;
use SQL::Abstract;
use Exporter qw(import);
use Config::IniHash;
use YAML;

our @EXPORT = qw(prompt db updaterecord newrecord notimplemented nocommand nosubcommand listchoices lookupval updatedata today validate ini printlist round pad lookupcol thin resolvenegid chooseneg annotatefilm keyword parselensmodel guessminfl guessmaxfl guessaperture guesszoom);

# Prompt for an arbitrary value
sub prompt {
	my $href = $_[0];
	my $default = $href->{default} // '';
	my $prompt = $href->{prompt};
	my $type = $href->{type} || 'text';

	die "Must provide value for \$prompt\n" if !($prompt);

	my $rv;
	# Repeatedly prompt until we get a response of the correct type
	do {
		print "$prompt ($type) [$default]: ";
		my $input = <STDIN>;
		chomp($input);
		$rv = ($input eq "") ? $default:$input;
	} while (!&validate({val => $rv, type => $type}));

	# Rewrite friendly bools
	if ($type eq 'boolean') {
		return friendlybool($rv);
	} else {
		return $rv;
	}
}

# Validate that a value is a certain type
sub validate {
	my $href = $_[0];
	my $val = $href->{val};
	my $type = $href->{type} || 'text';

	die "Must provide value for \$val\n" if !defined($val);

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
		if ($val =~ m/^-?\d+$/) {
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
		if (&prompt({default=>'yes', prompt=>'Could not find config file. Generate one now?', type=>'boolean'})) {
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
	my $href = $_[0];

	# Read in db handle
	my $db = $href->{db};

	# Read in hash new values
	my $data = $href->{data};

	# Read in table name
	my $table = $href->{table};

	# Read in where condition
	my $where = $href->{where};

	# Quit if we didn't get params
	die 'Must pass in $db' if !($db);
	die 'Must pass in $data' if !($data);
	die 'Must pass in $table' if !($table);
	die 'Must pass in $where' if !($where);

	# Delete empty strings from data hash
	$data = &thin($data);

	if (scalar(keys %$data) == 0) {
		die "Nothing to update\n";
	}

	# Dump data for debugging
	print "\n\nThis is what I will update into $table where $where:\n";
	print Dump($data);
	print "\n";

	# Build query
	my $sql = SQL::Abstract->new;
	my($stmt, @bind) = $sql->update($table, $data, $where);

	# Final confirmation
	&prompt({default=>'yes', prompt=>'Proceed?', type=>'boolean'}) or die "Aborted!\n";

	# Execute query
	my $sth = $db->prepare($stmt);
	my $rows = $sth->execute(@bind);
	$rows = 0 if ($rows eq  '0E0');
	print "Updated $rows rows\n";
}

# Insert a record into any table
sub newrecord {
	my $href = $_[0];

	# Read in db handle
	my $db = $href->{db};

	# Read in hash new values
	my $data = $href->{data};

	# Read in table name
	my $table = $href->{table};

	# Quit if we didn't get params
	die 'Must pass in $db' if !($db);
	die 'Must pass in $data' if !($data);
	die 'Must pass in $table' if !($table);

	# Delete empty strings from data hash
	$data = &thin($data);

	# Dump data for debugging
	print "\n\nThis is what I will insert into $table:\n";
	print Dump($data);
	print "\n";

	# Build query
	my $sql = SQL::Abstract->new;
	my($stmt, @bind) = $sql->insert($table, $data);

	# Final confirmation
	&prompt({default=>'yes', prompt=>'Proceed?', type=>'boolean'}) or die "Aborted!\n";

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
	my $href = $_[0];
	my $db = $href->{db};
	my $query = $href->{query};
	my $type = $href->{type} || 'integer';
	my $inserthandler = $href->{inserthandler};
	my $default = $href->{default} // '';
	my $skipok = $href->{skipok} || 0;
	my $table = $href->{table};
	my $cols = $href->{cols} // 'id, opt';
	my $where = $href->{where} // {};
	my $keyword = $href->{keyword} || &keyword($table) || &keyword($query);

	my ($sth, $rows);
	if ($query) {
		# Use the manual query
		$sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
		$rows = $sth->execute();
	} elsif ($table && $cols && $where) {
		# Use SQL::Abstract
		my $sql = SQL::Abstract->new;
		my($stmt, @bind) = $sql->select($table, $cols, $where);
		$sth = $db->prepare($stmt);
		$rows = $sth->execute(@bind);
	} else {
		die "Must pass in either query OR table, cols, where\n";
	}

	# No point in proveeding if there are no valid options to choose from
	if ($rows == 0) {
		if ($skipok) {
			return;
		} else {
			die "No valid $keyword options to choose from\n";
		}
	}

	my @allowedvals;

	while (my $ref = $sth->fetchrow_hashref) {
		print "\t$ref->{id}\t$ref->{opt}\n";
		# Make a note of what allowed options are
		push(@allowedvals, $ref->{id});
	}

	# Add option to insert a new row, if applicable
	if ($inserthandler) {
		print "\t0\tAdd a new $keyword\n";
		push(@allowedvals, '0');
	}

	if ($default eq '') {
		# If no default is given, count number of allowed options
		# and if there's just one, make it the default
		if ($rows == 1) {
			$default = $allowedvals[0];
		}
	} else {
		# Check that the provided default is an allowed value
		# Otherwise silently unset it
		if (!grep(/^$default$/, @allowedvals)) {
			$default = '';
		}
	}

	# Loop until we get valid input
	my $input;
	do {
		$input = &prompt({default=>$default, prompt=>"Please select a $keyword from the list, or leave blank to skip", type=>$type});
	} while (!(grep(/^$input$/, @allowedvals) || $input eq ''));

	# Spawn a new handler if that's what the user chose
	# Otherwise return what we got
	if ($input eq '0') {
		my $id = $inserthandler->($db);
		return $id;
	} else {
		# Return input
		return $input;
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
	$inidata{'database'}{'host'} = &prompt({default=>'localhost', prompt=>'Database hostname or IP address', type=>'text'});
	$inidata{'database'}{'schema'} = &prompt({default=>'photography', prompt=>'Schema name of photography database', type=>'text'});
	$inidata{'database'}{'user'} = &prompt({default=>'photography', prompt=>'Username with access to the schema', type=>'text'});
	$inidata{'database'}{'pass'} = &prompt({default=>'', prompt=>'Password for this user', type=>'text'});
	$inidata{'filesystem'}{'basepath'} = &prompt({default=>'', prompt=>'Path to your scanned images', type=>'text'});
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
	my $href = $_[0];
	my $db = $href->{db};
	my $oktoreturnundef = $href->{oktoreturnundef} || 0;

	my $film_id = &prompt({default=>'', prompt=>'Enter Film ID', type=>'integer'});
	my $frame = &listchoices({db=>$db, table=>'NEGATIVE', cols=>'frame as id, description as opt', where=>{film_id=>$film_id}, type=>'text'});
	my $neg_id = &lookupval($db, "select lookupneg('$film_id', '$frame')");
	if (defined($neg_id) && $neg_id =~ m/^\d+$/) {
		return $neg_id;
	} elsif ($oktoreturnundef == 1) {
		return;
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

# Figure out the keyword of an SQL statement, e.g. statements that select FROM
# CAMERA or choose_camera would return "camera"
# CAMERA_MOUNT or choose_camera_mount would return "camera mount"
sub keyword {
	my $query = shift;
	# This matches either a full SQL query, or just the table name
	if ($query =~ m/^.+ from (\w+).*$/i || $query =~ m/^(\w+)$/i) {
		my $text = $1;
		$text = lc($text);
		$text =~ s/^choose_//;
		$text =~ s/_/ /g;
		return $text;
	} else {
		die "Could not deduce valid keyword from SQL\n";
	}
}

# Parse lens model name to figure out some data
sub parselensmodel {
	my $model = shift;
	my ($minfocal, $maxfocal, $aperture, $zoom);
	if ($model =~ m/(\d+)-?(\d+)?mm/) {
		$minfocal = $1;
		$maxfocal = $2;
	}
	if ($minfocal && $maxfocal) {
		$zoom = 'yes';
	} else {
		$zoom = 'no';
	}
	if ($model =~ m/(f\/|1:)([\d\.]+)/) {
		$aperture = $2;
	}
	return {minfocal=>$minfocal, maxfocal=>$maxfocal, aperture=>$aperture, zoom=>$zoom};
}

# Guess minimum focal length
sub guessminfl {
	my $model = shift;
	my $rv = &parselensmodel($model);
	return $rv->{'minfocal'};
}

# Guess maximum focal length
sub guessmaxfl {
	my $model = shift;
	my $rv = &parselensmodel($model);
	return $rv->{'maxfocal'};
}

# Guess maximum aperture
sub guessaperture {
	my $model = shift;
	my $rv = &parselensmodel($model);
	return $rv->{'aperture'};
}

# Guess whether it is a zoom lens
sub guesszoom {
	my $model = shift;
	my $rv = &parselensmodel($model);
	return $rv->{'zoom'};
}

# This ensures the lib loads smoothly
1;
