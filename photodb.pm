package photodb;

use strict;
use warnings;

use Exporter qw(import);
use Data::Dumper;
use Config::IniHash;

our @EXPORT_OK = qw(prompt db updaterecord newrecord notimplemented nocommand nosubcommand help listchoices);

# Prompt for an arbitrary value
sub prompt {
	my $default = shift || "";
	my $prompt = shift;

	print "$prompt [$default]: ";
	my $input = <STDIN>;
	chomp($input);

	my $rv = ($input eq "") ? $default:$input;
	return $rv;
}

# Connect to the database
sub db {
	my $connect;

	# Look for ini file
	if (-e '~/.photodb.ini') {
		$connect = ReadINI('~/.photodb.ini');
	}
	elsif (-e 'photodb.ini') {
		$connect = ReadINI('photodb.ini');
	}
	elsif (-e '/etc/photodb.ini') {
		$connect = ReadINI('/etc/photodb.ini');
	}
	else {
		print "Could not find config file";
		exit;
	}

	# host, schema, user, pass
	if (!defined($$connect{'photodb'}{'host'}) || !defined($$connect{'photodb'}{'schema'}) || !defined($$connect{'photodb'}{'user'}) || !defined($$connect{'photodb'}{'pass'})) {
		print "Config file did not contain correct values";
		exit;
	}

	my $dbh = DBI->connect("DBI:mysql:database=$$connect{'photodb'}{'schema'};host=$$connect{'photodb'}{'host'}", $$connect{'photodb'}{'user'}, $$connect{'photodb'}{'pass'})
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
	print "\n\nThis is what I would have updated into $table where $where:\n";
	print Dumper(\$data);

	# Build query
	my $sql = SQL::Abstract->new;
	my($stmt, @bind) = $sql->update($table, $data, $where);
	print "And here's the SQL I've generated:\n$stmt\n";
	local $" = ',';
	print "@bind\n";

	# Execute query
	# my $sth = $db->prepare($stmt);
	# $sth->execute(@bind);
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
	print "\n\nThis is what I would have inserted into $table:\n";
	print Dumper(\$data);

	# Build query
	my $sql = SQL::Abstract->new;
	my($stmt, @bind) = $sql->insert($table, $data);
	print "And here's the SQL I've generated:\n$stmt\n";

	# Execute query
	my $sth = $db->prepare($stmt);
	$sth->execute(@bind);

	# Display inserted row
	my $insertedrow = $sth->{mysql_insertid};
	print "Inserted $table $insertedrow\n";

}

# Print a warning that this command/subcommand is not yet implemented
sub notimplemented {
	die "This command or subcommand is not yet implemented.\n";
}

# Quit if no command is given
sub nocommand {
	die "Please enter a valid command. Use '$0 help' for list of commands.\n";
}

# Quit if no subcommand is given
sub nosubcommand {
	my $command = shift;
	die "Please enter a valid subcommand. Use '$0 $command help' for list of subcommands.\n";
}

# Print help message
sub help {
	my $command = shift;
	my $subcommand = shift;

	print "Photography Database UI\n";
	print "\n";
	print "$0 <command> <subcommand>\n";
	print "e.g. $0 film add\n";
	print "\n";
	print "Valid commands: film, camera, negative, lens, print, help\n";
	exit;
}

# List arbitrary choices and return ID of the selected one
sub listchoices {
	my $db = shift;
	my $keyword = shift;
	my $query = shift;

	print "Please select a $keyword from the list:\n";

	my $sth = $db->prepare($query) or die "Couldn't prepare statement: " . $db->errstr;
	my $rows = $sth->execute();

	$sth->execute();
	my $ref;

	while ($ref = $sth->fetchrow_hashref) {
		print "\t$ref->{id}\t$ref->{opt}\n";
	}

	# Wait for input
	my $input = prompt('', "Please select a $keyword");

	# Validate input
	$input =~ s/[^0-9]//g;

	# Return input
	return $input;
}




# This ensures the lib loads smoothly
1;
