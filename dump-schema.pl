#!/usr/bin/perl -w

use strict;
use warnings;
use Getopt::Long;
use Term::ReadKey;
use DBI;

# Set some sane defaults
my $hostname = '127.0.0.1';
my $database = 'photography';
my $username = getlogin;
my $dumptables = 1;
my $dumpfuncs = 1;
my $dumpdata = 1;
my $dumpdocs = 1;

# Read in our command line options
GetOptions (
	"hostname=s" => \$hostname,
	"database=s" => \$database,
	"username=s" => \$username,
	"tables!" => \$dumptables,
	"funcs!" => \$dumpfuncs,
	"data!" => \$dumpdata,
	"docs!" => \$dumpdocs,
) or die("Error in command line arguments\n");

# Prompt for password
my $password = &password($username, $hostname);

if ($dumptables) {
	# Find out the list of table and view names
	my $query = "show full tables";
	my $dbh = DBI->connect("DBI:mysql:$database:$hostname", $username, $password);
	my $sqlQuery  = $dbh->prepare($query) or die "Can't prepare $query: $dbh->errstr\n";
	my $rv = $sqlQuery->execute or die "can't execute the query: $sqlQuery->errstr";

	# Delete all existing *.sql files in the schema subdir
	unlink <schema/*.sql>;

	# Dump each table schema to its own file
	print "\nDumping table schemas and views...\n";
	while (my @row= $sqlQuery->fetchrow_array()) {
		my $table = $row[0];
		&dumptable($table);
	}

	# Disconnect from the database
	$sqlQuery->finish;
}

if ($dumpdata) {
	# List of tables that contain useful sample data
	my @tables = (
	        'ACCESSORY_TYPE',
	        'ARCHIVE_TYPE',
	        'BODY_TYPE',
	        'EXPOSURE_PROGRAM',
	        'FILMSTOCK',
	        'FORMAT',
	        'LENS_TYPE',
	        'MANUFACTURER',
	        'METERING_MODE',
	        'METERING_TYPE',
	        'MOUNT',
	        'NEGATIVE_SIZE',
	        'PROCESS',
	        'SHUTTER_SPEED',
	        'SHUTTER_TYPE'
	);

	# Dump sample data from specific tables
	print "\nDumping sample data...\n";
	foreach my $table (@tables) {
		&dumpdata($table);
	}
}

if ($dumpfuncs) {
	# Dump functions too
	&dumpfuncs;
}

# Dump schema only
sub dumptable {
	my $table = shift;
	print "\tDumping schema for $table\n";
	`mysqldump --max_allowed_packet=1G --host=$hostname --protocol=tcp --user=$username --password=$password --default-character-set=utf8 --skip-comments --compact --no-data "$database" "$table" | sed 's/ AUTO_INCREMENT=[0-9]*//g' > schema/${database}_${table}.sql`;
	return;
}

# Dump functions
sub dumpfuncs {
	print "\nDumping functions...\n";
	`mysqldump --host=$hostname --user=$username --password=$password --routines --no-create-info --no-data --no-create-db --skip-comments --compact --skip-opt "$database" > schema/${database}_functions.sql`;
	return;
}

# Dump table data
sub dumpdata {
        my $table = shift;
	print "\tDumping data from $table\n";
        `mysqldump --max_allowed_packet=1G --host=$hostname --protocol=tcp --user=$username --password=$password --default-character-set=utf8 --skip-comments --no-create-info --compact "$database" "$table" > sample-data/${database}_${table}_data.sql`;
	return;
}

# Prompt for password
sub password {
	my $username = shift;
	my $hostname = shift;
	print "Password for database user $username". '@' . "$hostname: ";
	ReadMode 'noecho';
	my $password = ReadLine 0;
	chomp $password;
	ReadMode 'normal';
	print "\n";
	return $password;
}
