#!/usr/bin/perl -wT
# Check that the database can find each film's dir 

use strict;
use DBI;
use DBD::mysql;

# Grab the Film ID
#my $filmid = $ARGV[0];
#if (defined($filmid)) {
#	# If we have it, sanitise it
#	$filmid =~ s/[^0-9]//;
#} else {
#	# If we don't, use a wildcard for SQL
#	$filmid = '%';
#}

# CONFIG VARIABLES
my $database = 'photography';
my $host = '192.168.0.2';
my $user = 'jonathan';
my $pw = 'network80486';

# PERL DBI CONNECT
my $dsn = "dbi:mysql:$database:$host:3306";
my $db = DBI->connect($dsn, $user, $pw);

# Base path where all scans are stored
my $basepath = '/home/jonathan/Pictures/Negatives/';

# SQL query to fetch list of scans
my $select_sql = qq{
select
	film_id,
	directory
from
	FILM
};

my $select_sth = $db->prepare($select_sql);
$select_sth->execute();

my $errors=0;
while(my @row = $select_sth->fetchrow_array) {
	if (-d "$basepath$row[1]") {
		# directory exists
	} else {
		print "Cannot find directory for film $row[0]\n";
		$errors=1;
	}
}

if ($errors == 0) {
	print "All film directories are OK\n"
}

$db->disconnect();
