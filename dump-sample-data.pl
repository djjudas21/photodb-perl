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

# List of tables that contain useful sample data
my @tables = (
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

foreach my $table (@tables) {
  print "Dumping data from $table\n";
  &dumptable($table);
}

# Function to do the dump
sub dumptable {
	my $table = shift;
	`mysqldump --max_allowed_packet=1G --host=$hostname --protocol=tcp --user=$username --password=$password --default-character-set=utf8 --skip-comments --no-create-info --compact "$database" "$table" > sample-data/${database}_${table}_data.sql`
}
