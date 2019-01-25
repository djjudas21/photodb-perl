package funcs;

# This package provides reusable functions to be consumed by the rest of the application

use strict;
use warnings;
use experimental 'smartmatch';

use DBI;
use DBD::mysql;
use SQL::Abstract;
use Exporter qw(import);
use Config::IniHash;
use YAML;
use Image::ExifTool;

our @EXPORT_OK = qw(prompt db updaterecord newrecord notimplemented nocommand nosubcommand listchoices lookupval lookuplist updatedata today validate ini printlist round pad lookupcol thin resolvenegid chooseneg annotatefilm keyword parselensmodel unsetdisplaylens welcome duration tag printbool hashdiff);

# Prompt the user for an arbitrary value
sub prompt {
	# Pass in a hashref of arguments
	my $href = shift;
	# Unpack the hashref and set default values
	my $default = $href->{default} // '';		# Default value that will be used if no input from user
	my $prompt = $href->{prompt};			# Prompt message for the user
	my $type = $href->{type} || 'text';		# Data type that this input expects, out of text, integer, boolean, date, decimal, time
	my $required = $href->{required} // 0;		# Whether this input is required, or whether it can return an empty value
	my $showtype = $href->{showtype} // 1;		# Whether to show the user what data type is expected
	my $showdefault = $href->{showdefault} // 1;	# Whether to show the user what the default value is
	my $char = $href->{char} // ':';		# Character to print at the end of the prompt

	die "Must provide value for \$prompt\n" if !($prompt);

	# Rewrite binary bools as strings
	if ($type eq 'boolean' && $default ne '') {
		$default = &printbool($default);
	}

	my $rv;
	# Repeatedly prompt user until we get a response of the correct type
	do {
		# Assemble prompt text and print it
		print $prompt;
		print " ($type)" if $showtype;
		print " [$default]" if $showdefault;
		print "$char ";
		my $input = <STDIN>; ## no critic
		chomp($input);

		# Use default value if user gave blank input
		$rv = ($input eq "") ? $default:$input;
	# Prompt again if the input doesn't pass validation, or if it's a required field that was blank
	} while (!&validate({val => $rv, type => $type}) || ($rv eq '' && $required == 1));

	# Rewrite friendly bools and then return the value
	if ($type eq 'boolean') {
		return friendlybool($rv);
	} else {
		return $rv;
	}
}

# Validate that a value is a certain data type
sub validate {
	# Pass in a hashref of arguments
	my $href = shift;
	# Unpack the hashref and set default values
	my $val = $href->{val};			# The value to be validated
	my $type = $href->{type} || 'text';	# Data type to validate as, out of text, integer, boolean, date, decimal, time

	die "Must provide value for \$val\n" if !defined($val);

	# Empty string always passes validation
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
	} elsif ($type eq 'time') {
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
	if (-r $path) {
		return glob('~/.photodb.ini');
	} elsif (-r '/etc/photodb.ini') {
		return '/etc/photodb.ini';
	} elsif (-r '/photodb.ini') {
		return '/photodb.ini';
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
			# Required for updates to work properly
			mysql_client_found_rows => 0,
			# Required to print symbols
			mysql_enable_utf8mb4 => 1,
		}
	) or die "Couldn't connect to database: " . DBI->errstr;
	return $dbh;
}

# Update an existing record in any table
sub updaterecord {
	# Pass in a hashref of arguments
	my $href = shift;

	# Unpack the hashref and set default values
	my $db = $href->{db};			# DB handle
	my $data = $href->{data};		# Hash of new values to update
	my $table = $href->{table};		# Name of table to update
	my $where = $href->{where};		# Where clause, formatted for SQL::Abstract
	my $silent = $href->{silent} // 0;	# Suppress output

	# Quit if we didn't get params
	die 'Must pass in $db' if !($db);
	die 'Must pass in $data' if !($data);
	die 'Must pass in $table' if !($table);
	die 'Must pass in $where' if !($where);

	# Delete empty strings from data hash
	$data = &thin($data);

	if (scalar(keys %$data) == 0) {
		print "Nothing to update\n";
		return 0;
	}

	# Dump data for debugging
	print "\n\nThis is what I will update into $table where $where:\n" unless $silent;
	print Dump($data) unless $silent;
	print "\n" unless $silent;

	# Build query
	my $sql = SQL::Abstract->new;
	my($stmt, @bind) = $sql->update($table, $data, $where);

	# Final confirmation
	unless ($silent) {
		if (!&prompt({default=>'yes', prompt=>'Proceed?', type=>'boolean'})) {
		       print "Aborted!\n";
		       return;
	       }
	}

	# Execute query
	my $sth = $db->prepare($stmt);
	my $rows = $sth->execute(@bind);
	$rows = 0 if ($rows eq  '0E0');
	print "Updated $rows rows\n" unless $silent;
	return $rows;
}

# Insert a record into any table
sub newrecord {
	# Pass in a hashref of arguments
	my $href = shift;

	# Unpack the hashref and set default values
	my $db = $href->{db};			# DB handle
	my $data = $href->{data};		# Hash of new values to insert
	my $table = $href->{table};		# Table to insert into
	my $silent = $href->{silent} // 0;	# Suppress output

	# Quit if we didn't get params
	die 'Must pass in $db' if !($db);
	die 'Must pass in $data' if !($data);
	die 'Must pass in $table' if !($table);

	# Delete empty strings from data hash
	$data = &thin($data);

	# Dump data for debugging
	print "\n\nThis is what I will insert into $table:\n" unless $silent;
	print Dump($data) unless $silent;
	print "\n" unless $silent;

	# Build query
	my $sql = SQL::Abstract->new;
	my($stmt, @bind) = $sql->insert($table, $data);

	# Final confirmation
	unless ($silent) {
		if (!&prompt({default=>'yes', prompt=>'Proceed?', type=>'boolean'})) {
		       print "Aborted!\n";
		       return;
	       }
	}

	# Execute query
	my $sth = $db->prepare($stmt);
	$sth->execute(@bind);

	# Display inserted row
	my $insertedrow = $sth->{mysql_insertid};
	print "Inserted $table $insertedrow\n" unless $silent;

	return $insertedrow;
}

# Print a warning that this command/subcommand is not yet implemented
sub notimplemented {
	print "This command or subcommand is not yet implemented.\n";
	return;
}

# Print list of commands
sub nocommand {
	my $handlers = shift;
	print "photodb <command> <subcommand>\n\n";
	print "Please enter a valid command. Valid commands are:\n";
	print "\t$_\n" for sort keys %$handlers;
	return;
}

# Print list of subcommands for a given command
sub nosubcommand {
	my $handlers = shift;
	my $command = shift;
	print "photodb $command <subcommand>\n\n";
	print "Please enter a valid subcommand. Valid subcommands for '$command' are:\n";
	print "\t" . &pad($_) . $$handlers{$_}{'desc'} . "\n" for sort keys %$handlers;
	return;
}

# List arbitrary choices from the DB and return ID of the selected one
sub listchoices {
	# Pass in a hashref of arguments
	my $href = shift;

	my $db = $href->{db};								# DB handle
	my $query = $href->{query};							# (legacy) the SQL to generate the list of choices
	my $type = $href->{type} || 'text';						# Data type of choice to be made. Often but not always integer
	my $inserthandler = $href->{inserthandler};					# ref to handler that can be used to insert a new row
	my $default = $href->{default} // '';						# id of default choice
	my $autodefault = $href->{autodefault} // 1;					# if default not set, count number of allowed options and if there's just 1, make it the default
	my $skipok = $href->{skipok} || 0;						# whether it is ok to return null if there are no options to choose from
	my $table = $href->{table};							# Part of the SQL::Abstract tuple
	my $cols = $href->{cols} // ('id, opt');					# Part of the SQL::Abstract tuple
	my $where = $href->{where} // {};						# Part of the SQL::Abstract tuple
	my $keyword = $href->{keyword} || &keyword($table) || &keyword($query);		# keyword to describe the thing being chosen
	my $required = $href->{required} // 0;						# whether we allow the user to enter an empty input
	my $char = $href->{char} // '+';						# character to use to signal that you want to enter a new row

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

	# No point in proceeding if there are no valid options to choose from
	if ($rows == 0) {
		print "No valid $keyword options to choose from\n";
		if ($inserthandler && &prompt({prompt=>"Add a new $keyword?", type=>'boolean', default=>'no'})) {
			# add a new entry
			my $id = $inserthandler->($db);
			return $id;
		} elsif ($skipok) {
			return;
		} else {
			die;
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
		print "\t$char\tAdd a new $keyword\n";
		push(@allowedvals, $char);
	}

	if ($default eq '' && $autodefault) {
		# If no default is given, count number of allowed options
		# and if there's just one, make it the default
		if ($rows == 1) {
			$default = $allowedvals[0];
		}
	} else {
		# Check that the provided default is an allowed value
		# Otherwise silently unset it
		if ($default && !($default ~~ @allowedvals)) {
			$default = '';
		}
	}

	# Loop until we get valid input
	my $input;
	my $msg = "Please select a $keyword from the list";
	$msg .= ', or leave blank to skip' if ($required == 0);

	do {
		$input = &prompt({default=>$default, prompt=>$msg, type=>$type, required=>$required});
	} while ($input && !($input ~~ [ map {"$_"} @allowedvals ] || $input eq ''));

	# Spawn a new handler if that's what the user chose
	# Otherwise return what we got
	if ($input eq $char && $inserthandler) {
		my $id = $inserthandler->($db);
		return $id;
	} else {
		# Return input
		return $input;
	}
}

# List arbitrary rows
sub printlist {
	# Pass in a hashref of arguments
	my $href = shift;

	my $db = $href->{db};				# DB handle
	my $msg = $href->{msg};				# Message to display to user
	my $query = $href->{query};			# (legacy) SQL query to run
	my $table = $href->{table};			# Part of the SQL::Abstract tuple
	my $cols = $href->{cols} // ('id, opt');	# Part of the SQL::Abstract tuple
	my $where = $href->{where} // {};		# Part of the SQL::Abstract tuple
	my $order = $href->{order};			# Part of the SQL::Abstract tuple

	print "Now showing $msg\n";

	my ($sth, $rows);
	if ($query) {
		$sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
		$rows = $sth->execute();
	} elsif ($table && $cols && $where) {
		# Use SQL::Abstract
		my $sql = SQL::Abstract->new;
		my($stmt, @bind) = $sql->select($table, $cols, $where, $order);
		$sth = $db->prepare($stmt);
		$rows = $sth->execute(@bind);
	} else {
		print "Must pass in either query OR table, cols, where\n";
		return;
	}

	while (my $ref = $sth->fetchrow_hashref) {
		print "\t$ref->{id}\t$ref->{opt}\n";
	}
	return;
}

# Return values from an arbitrary column from database as an arrayref
sub lookupcol {
	# Pass in a hashref of arguments
	my $href = shift;

	my $db = $href->{db};			# DB handle
	my $query = $href->{query};		# (legacy) SQL query to run
	my $table = $href->{table};		# Part of the SQL::Abstract tuple
	my $cols = $href->{cols} // '*';	# Part of the SQL::Abstract tuple
	my $where = $href->{where} // {};	# Part of the SQL::Abstract tuple

	my ($sth, $rows);
	if ($query) {
		$sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
		$rows = $sth->execute();
	} elsif ($table && $cols && $where) {
		# Use SQL::Abstract
		my $sql = SQL::Abstract->new;
		my($stmt, @bind) = $sql->select($table, $cols, $where);
		$sth = $db->prepare($stmt);
		$rows = $sth->execute(@bind);
	} else {
		print "Must pass in either query OR table, cols, where\n";
		return;
	}

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
	# Pass in a hashref of arguments
	my $href = shift;

	my $db = $href->{db};			# DB handle
	my $query = $href->{query};		# (legacy) SQL query to run
	my $table = $href->{table};		# Part of the SQL::Abstract tuple
	my $col = $href->{col};			# Part of the SQL::Abstract tuple
	my $where = $href->{where} // {};	# Part of the SQL::Abstract tuple

	my ($sth, $rows);
	if ($query) {
		# Use the manual query
		$sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
		$rows = $sth->execute();
	} elsif ($table && $col && $where) {
		# Use SQL::Abstract
		my $sql = SQL::Abstract->new;
		my($stmt, @bind) = $sql->select($table, $col, $where);
		$sth = $db->prepare($stmt);
		$rows = $sth->execute(@bind);
	} else {
		print "Must pass in either query OR table, col, where\n";
		return;
	}

	my $row = $sth->fetchrow_array();
	return $row;
}

# Return arbitrary lists from database
sub lookuplist {
	# Pass in a hashref of arguments
	my $href = shift;

	my $db = $href->{db};		   # DB handle
	my $table = $href->{table};	     # Part of the SQL::Abstract tuple
	my $col = $href->{col};		 # Part of the SQL::Abstract tuple
	my $where = $href->{where} // {};       # Part of the SQL::Abstract tuple

	my ($sth, $rows);
	if ($table && $col && $where) {
		# Use SQL::Abstract
		my $sql = SQL::Abstract->new;
		my($stmt, @bind) = $sql->select($table, $col, $where);
		$sth = $db->prepare($stmt);
		$rows = $sth->execute(@bind);
	} else {
		print "Must pass in table, col, where\n";
		return;
	}

	my @list;
	while (my $row = $sth->fetchrow_array()) {
		push(@list, $row);
	}
	return \@list;
}

# Update data using a bare UPDATE statement
# Avoid using if possible
sub updatedata {
	my $db = shift;		# DB handle
	my $query = shift;	# Plain SQL query
	my $sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
	my $rows = $sth->execute();
	# DBD returns scientific 0E0 instead of 0
	$rows = 0 if ($rows eq '0E0');
	return $rows;
}

# Return today's date according to the DB
sub today {
	my $db = shift;		# DB handle
	return &lookupval({db=>$db, query=>'select curdate()'});
}

# Translate "friendly" bools to integers
# y/yes/true/1
# n/no/false/0
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

# Translate numeric bools to strings
sub printbool {
	my $val = shift;
	if ($val =~ m/^y(es)?$/i || $val =~ m/^true$/i || $val eq 1) {
		return 'yes';
	} elsif ($val =~ m/^n(o)?$/i || $val =~ m/^false$/i || $val eq 0) {
		return 'no';
	} else {
		return '';
	}
}

# Write out a config file
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
	return;
}

# Round numbers to any precision
sub round {
	my $x = shift;		# Number to round
	my $pow10 = shift || 0;	# Number of decimal places to round to
	my $a = 10 ** $pow10;
	return int(($x * $a) + 0.5) / $a
}

# Pad a string with spaces up to a fixed length
sub pad {
	my $string = shift;		# Text to pad
	my $totallength = shift || 18;	# Total number of characters to pad to

	# Work out required pad
	my $pad = $totallength - length($string);

	if ($pad > 0) {
		# Return the padded string
		return $string . ' ' x $pad;
	} elsif ($pad = 0) {
		# No pad required, just return the original
		return $string;
	} else {
		# If the input is longer than the target, truncate it
		return substr($string, 0, $totallength);
	}
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
		my $neg_id = &lookupval({db=>$db, query=>"select lookupneg($film_id, $frame)"});
		return $neg_id;
	} else {
		# Could not resolve
		die "Could not resolve $string to a negative ID\n";
	}
}

# Select a negative by drilling down
sub chooseneg {
	my $href = shift;
	my $db = $href->{db};
	my $oktoreturnundef = $href->{oktoreturnundef} || 0;

	# Choose a film
	my $film_id = &prompt({default=>'', prompt=>'Enter Film ID', type=>'integer'});

	#  Choose a negative from this film
	my $frame = &listchoices({db=>$db, table=>'NEGATIVE', cols=>'frame as id, description as opt', where=>{film_id=>$film_id}, type=>'text'});
	my $neg_id = &lookupval({db=>$db, query=>"select lookupneg('$film_id', '$frame')"});
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
		my $filmdir = &lookupval({db=>$db, query=>"select directory from FILM where film_id=$film_id"});
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
			my $sth2 = $db->prepare('SELECT * FROM photography.negative_info where `Film ID`=?') or die "Couldn't prepare statement: " . $db->errstr;
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
			print "Film directory $path/$filmdir not found\n";
			return;
		}
	} else {
		print "Path $path not found\n";
		return;
	}
	return;
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
		print "Could not deduce valid keyword from SQL\n";
		return;
	}
}

# Parse lens model name to figure out some data
sub parselensmodel {
	my $model = shift;
	my $param = shift;

	# Define hash to hold results
	my %results;

	if ($model =~ m/(\d+)-?(\d+)?mm/) {
		$results{minfocal} = $1;
		$results{maxfocal} = $2;
	}
	if ($results{minfocal} && $results{maxfocal}) {
		$results{zoom} = 'yes';
	} else {
		$results{zoom} = 'no';
	}
	if ($model =~ m/(f\/|1:)([\d\.]+)/) {
		$results{aperture} = $2;
	}

	if ($param) {
		# If a specific param was requested, return it
		return $results{$param};
	} else {
		# Else return a hashref of all params
		return \%results;
	}
}

# Unset display lens
sub unsetdisplaylens {
	my $href = shift;
	my $db = $href->{db};
	my %where;
	$where{camera_id} = $href->{camera_id};
	$where{display_lens} = $href->{lens_id};
	my $thinwhere = &thin(\%where);

	# Build query
	my $sql = SQL::Abstract->new;
	my($stmt, @bind) = $sql->update('CAMERA', {display_lens => undef}, $thinwhere);

	# Execute query
	my $sth = $db->prepare($stmt);
	return $sth->execute(@bind);
}

# Print welcome message
sub welcome {
       my $ascii = <<'END_ASCII';
 ____  _           _        ____  ____
|  _ \| |__   ___ | |_ ___ |  _ \| __ )
| |_) | '_ \ / _ \| __/ _ \| | | |  _ \
|  __/| | | | (_) | || (_) | |_| | |_) |
|_|   |_| |_|\___/ \__\___/|____/|____/
END_ASCII
	print "$ascii\n\n";
	return;
}

# Calculate duration of a shutter speed from its string representation
sub duration {
	my $shutter_speed = shift;
	my $duration = 0;
	# Expressed like 1/125
	if ($shutter_speed =~ m/1\/(\d+)/) {
		$duration = 1 / $1;
	# Expressed like 0.3 or 1
	} elsif ($shutter_speed =~ m/((0\.)?\d+)/) {
		$duration = $1;
	}
	return $duration;
}

# This func reads data from PhotoDB and writes EXIF tags
# to the JPGs that have been scanned from negatives
sub tag {

	# Read in cmdline args
	my $db = shift;
	my $film_id = shift // '%';

	# Make sure basepath is valid
	my $connect = ReadINI(&ini);
	if (!defined($$connect{'filesystem'}{'basepath'})) {
		print "Config file did not contain basepath";
		return;
	}
	my $basepath = $$connect{'filesystem'}{'basepath'};
	if (substr($basepath, -1, 1) ne '/') {
		$basepath .= '/';
	}

	# Crank up an instance of ExifTool
	my $exifTool = Image::ExifTool->new;
	$exifTool->Options(CoordFormat => q{%+.6f});

	# Specify which attributes we want to write
	# If any are specified here but not available, they will be ignored
	my @attributes = (
		'Make',
		'Model',
		'Lens',
		'LensModel',
		'ExposureTime',
		'MaxApertureValue',
		'FNumber',
		'ApertureValue',
		'FocalLength',
		'ISO',
		'Author',
		'ImageDescription',
		'DateTimeOriginal',
		'ExposureProgram',
		'MeteringMode',
		'Flash',
		'GPSLatitude',
		'GPSLongitude',
	);

	# This is the query that fetches (and calculates) values from the DB that we want to write as EXIF tags
	my $sql = 'SELECT * from exifdata where film_id = ?';

	# Prepare and execute the SQL
	my $sth = $db->prepare($sql) or die "Couldn't prepare statement: " . $db->errstr;
	my $rows = $sth->execute($film_id);

	# Set some globals
	my $foundcount=0;
	my $changedcount=0;
	my @missingfiles;

	# Loop through our result set
	while (my $ref = $sth->fetchrow_hashref()) {
		# First check the path is defined in MySQL
		if (defined($ref->{'path'})) {
			# Now make sure the path actually exists on the system
			if (-e "$basepath$ref->{'path'}") {
				# File exists, so we go on and do stuff to it.
				# Grab the existing EXIF tags for comparison
				my $exif = $exifTool->ImageInfo("$basepath$ref->{'path'}");
				my $changeflag = 0;
				$foundcount++;

				# For each of the attributes on our list...
				foreach my $var (@attributes) {
					#  Test if it exists in the DB
					if (defined($ref->{$var})) {
						# Test if it already exists in the file AND has the correct value, either string OR numeric format
						if (defined($exif->{$var}) && ($exif->{$var} ~~ $ref->{$var})) {
							# Tag already has correct value, skip
							next;
						} else {
							# Set the value of the tag and flag that a change was made
							if (defined($exif->{$var})) {
								# Already defined, update it
								print "\tChanging $var: $exif->{$var} => $ref->{$var}\n";
							} else {
								# Not defined, set it
								print "\tSetting $var: $ref->{$var}\n";
							}
							$exifTool->SetNewValue($var => $ref->{$var});
							$changeflag = 1;
						}
					}
				}

				# If a change has been made to the EXIF data, write out the data
				if ($changeflag == 1) {
					$exifTool->WriteInfo("$basepath$ref->{'path'}");
					print "Wrote tags to $basepath$ref->{'path'}\n\n";
					$changedcount++;
				}
			} else {
				print "$basepath$ref->{'path'} not found - skipping\n";
				push (@missingfiles, "$basepath$ref->{'path'}");
			}
		}
	}

	# Print some stats
	print "Found $foundcount images\n";
	print "Changed EXIF data in $changedcount images\n";
	print 'Found ' . ($#missingfiles + 1) . " missing files\n";
	return;
}

# Compare new and old data to find changed fields
sub hashdiff {
	my $old = shift;
	my $new = shift;

	# Strip out empty keys
	$old = &thin($old);
	$new = &thin($new);

	# Save new or changed keys
	my %diff;
	foreach my $key (keys %$new) {
		if (!defined($$old{$key}) || $$new{$key} ne $$old{$key}) {
			$diff{$key} = $$new{$key};
		}
	}
	return \%diff;
}

# This ensures the lib loads smoothly
1;
