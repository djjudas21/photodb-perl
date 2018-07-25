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

our @EXPORT = qw(prompt db updaterecord newrecord notimplemented nocommand nosubcommand listchoices lookupval updatedata today validate ini printlist round pad);

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

	my $dbh = DBI->connect("DBI:mysql:database=$$connect{'database'}{'schema'};host=$$connect{'database'}{'host'};mysql_client_found_rows=0", $$connect{'database'}{'user'}, $$connect{'database'}{'pass'})
		or die "Couldn't connect to database: " . DBI->errstr;
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
	foreach (keys %$data) {
		delete $$data{$_} unless (defined $$data{$_} and $$data{$_} ne '');
	}

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
	foreach (keys %$data) {
		delete $$data{$_} unless (defined $$data{$_} and $$data{$_} ne '');
	}

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
	print "\t$_\n" for keys %$handlers;
	exit;
}

# Quit if no valid subcommand is given
sub nosubcommand {
	my $handlers = shift;
	my $command = shift;
	print "Photography Database UI\n\n";
	print "$0 $command <subcommand>\n\n";
	print "Please enter a valid subcommand. Valid subcommands for '$command' are:\n";
	print "\t" . &pad($_) . $$handlers{$_}{'desc'} . "\n" for keys %$handlers;
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
	my $ref;
	my @allowedvals;

	while ($ref = $sth->fetchrow_hashref) {
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

# List arbitrary choices and return ID of the selected one
sub printlist {
	my $db = shift;
	my $msg = shift;
	my $query = shift;

	print "Now showing $msg\n\n";

	my $sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
	my $rows = $sth->execute();

	$sth->execute();
	my $ref;

	while ($ref = $sth->fetchrow_hashref) {
		print "\t$ref->{id}\t$ref->{opt}\n";
	}
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
	my $pow10 = shift;
	my $a = 10 ** $pow10;
	return int(($x * $a) + 0.5) / $a
}

# Pad a string with spaces up to a fixed length
sub pad {
	my $string = shift;
	my $totallength = shift || 16;
	my $lengthofstring = length($string);
	my $pad = $totallength - $lengthofstring;
	my $newstring = $string . ' ' x $pad;
}

# This ensures the lib loads smoothly
1;
