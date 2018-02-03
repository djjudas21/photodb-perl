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

# Set up array to write file into
my @output;

# Print headers
push(@output, "# PhotoDB schema documentation\n");

# Generate docs for each table in turn
while (my @row= $sqlQuery->fetchrow_array()) {
  my $table = $row[0];
  
  print "Generating docs for $table\n";
  push(@output, "\n## $table\n\n");
  my @tableoutput =  `mysql -h$hostname -u$username -p$password -t -e "SELECT COLUMN_NAME, COLUMN_TYPE, COLUMN_COMMENT FROM information_schema.columns WHERE table_name = '$table';" $database`;

  # Delete first and last elements (table borders)
  shift(@tableoutput);
  pop(@tableoutput);

  # Substitute some table chars
  foreach (@tableoutput) {
	  $_ =~ s/\+/\|/g;
  }
  push(@output, @tableoutput);
}

# Disconnect from the database 
$sqlQuery->finish;

# Open a file and dump compiled array into it
open my $fh, '>', "SCHEMA.md" or die "Cannot open SCHEMA.md: $!";
foreach (@output) {
    print $fh $_;
}
close $fh;
