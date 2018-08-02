#!/usr/bin/perl -w

use strict;
use warnings;
use Getopt::Long;
use Term::ReadKey;
use DBI;

# Set some sane defaults
my $hostname = 'localhost';
my $database = 'photography';
my $username = getlogin;

# Read in our command line options
GetOptions ("hostname=s" => \$hostname,
            "database=s" => \$database,
            "username=s" => \$username)
  or die("Error in command line arguments\n");

# Prompt for password
print "Password: ";
ReadMode 'noecho';
my $password = ReadLine 0;
chomp $password;
ReadMode 'normal';
print "\n";

# Find out the list of table and view names
my $query = "show full tables";
my $dbh = DBI->connect("DBI:mysql:$database:$hostname", $username, $password);
my $sqlQuery  = $dbh->prepare($query) or die "Can't prepare $query: $dbh->errstr\n";
my $rv = $sqlQuery->execute or die "can't execute the query: $sqlQuery->errstr";

# Delete all existing *.sql files in the schema subdir
unlink <schema/*.sql>;

# Dump each table schema to its own file
while (my @row= $sqlQuery->fetchrow_array()) {
  my $table = $row[0];
  print "Dumping schema for $table\n";
  &dumptable($table);
}

# Disconnect from the database 
$sqlQuery->finish;

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
foreach my $table (@tables) {
  print "Dumping data from $table\n";
  &dumpdata($table);
}

# Dump functions too
&dumpfuncs;

# Dump schema only
sub dumptable {
	my $table = shift;
	`mysqldump --max_allowed_packet=1G --host=$hostname --protocol=tcp --user=$username --password=$password --default-character-set=utf8 --skip-comments --compact --no-data "$database" "$table" | sed 's/ AUTO_INCREMENT=[0-9]*//g' > schema/${database}_${table}.sql`
}

# Dump functions
sub dumpfuncs {
	`mysqldump --host=$hostname --user=$username --password=$password --routines --no-create-info --no-data --no-create-db --skip-comments --compact --skip-opt "$database" > schema/${database}_functions.sql`;
}

# Dump table data
sub dumpdata {
        my $table = shift;
        `mysqldump --max_allowed_packet=1G --host=$hostname --protocol=tcp --user=$username --password=$password --default-character-set=utf8 --skip-comments --no-create-info --compact "$database" "$table" > sample-data/${database}_${table}_data.sql`
}
