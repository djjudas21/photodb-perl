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

# Dump each table to its own file
while (my @row= $sqlQuery->fetchrow_array()) {
  my $table = $row[0];
  print "Dumping $table\n";
  &dumptable($table);
}

# Disconnect from the database 
$sqlQuery->finish;

# Dump functions too
&dumpfuncs;

# Function to do the dump
sub dumptable {
	my $table = shift;
	`mysqldump --max_allowed_packet=1G --host=$hostname --protocol=tcp --user=$username --password=$password --default-character-set=utf8 --skip-comments --compact --no-data "$database" "$table" | sed 's/ AUTO_INCREMENT=[0-9]*//g' > schema/${database}_${table}.sql`
}

# Dump functions
sub dumpfuncs {
	`mysqldump --host=$hostname --user=$username --password=$password --routines --no-create-info --no-data --no-create-db --skip-comments --compact --skip-opt "$database" > schema/${database}_functions.sql`;
}
