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
my $query = "show full tables where table_type = 'base table';";
my $dbh = DBI->connect("DBI:mysql:$database:$hostname", $username, $password);
my $sqlQuery  = $dbh->prepare($query) or die "Can't prepare $query: $dbh->errstr\n";
$sqlQuery->execute or die "can't execute the query: $sqlQuery->errstr";

# Delete all existing *.sql files in the schema subdir
unlink <SCHEMA.md>;

# Print headers
`echo "# PhotoDB schema documentation\n" >> SCHEMA.md`;

# Dump each table to its own file
while (my @row= $sqlQuery->fetchrow_array()) {
  my $table = $row[0];
  
  print "Dumping $table\n";
  `echo "\n## $table\n" >> SCHEMA.md`;
  `mysql -h$hostname -u$username -p$password -t -e "SELECT COLUMN_NAME, COLUMN_TYPE, COLUMN_COMMENT FROM information_schema.columns WHERE table_name = '$table';" $database >> SCHEMA.md`;
}

# Disconnect from the database 
$sqlQuery->finish;
