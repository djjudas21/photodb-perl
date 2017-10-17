#!/usr/bin/perl -wT
# Update the photography database with the resolutions
# and colour info of scanned images

use strict;
use DBI;
use DBD::mysql;
use Image::Info qw(image_info dim image_type);

# Grab the Film ID
my $filmid = $ARGV[0];
if (defined($filmid)) {
	# If we have it, sanitise it
	$filmid =~ s/[^0-9]//;
} else {
	# If we don't, use a wildcard for SQL
	$filmid = '%';
}

# CONFIG VARIABLES
my $database = 'photography';
my $host = '192.168.0.2';
my $user = 'photography';
my $pw = 'photography';

# PERL DBI CONNECT
my $dsn = "dbi:mysql:$database:$host:3306";
my $db = DBI->connect($dsn, $user, $pw);

# Base path where all scans are stored
my $basepath = '/home/jonathan/Pictures/Negatives/';

# SQL query to fetch list of scans
my $select_sql = qq{
select
	scan_id, concat(directory, '/', filename) as filepath
from
	FILM,
	NEGATIVE,
	SCAN
where
	FILM.film_id=NEGATIVE.film_id
	and NEGATIVE.negative_id=SCAN.negative_id
	and SCAN.filename is not null
	and FILM.directory is not null
	and FILM.film_id = '$filmid';
};

my $select_sth = $db->prepare($select_sql);
$select_sth->execute();

while(my @row = $select_sth->fetchrow_array) {
	my $info = image_info("$basepath$row[1]");
	if (my $error = $info->{error}) {
		print "CANNOT FIND FILE $basepath$row[1]\n";
		next;
	}
	my $colour = $info->{color_type};
	my($w, $h) = dim($info);
	print "$row[0]     $basepath$row[1]   $w x $h    $colour\n";
	&updateDB($row[0], $w, $h, $colour, $db);
} 

$db->disconnect();


sub updateDB {
	my $scan_id = shift;
	my $w = shift;
	my $h = shift;
	my $colour = shift;
	my $db = shift;

	my $colourbool;
	if ($colour =~ m/^Gray/) {
		$colourbool = 0;
	} else {
		$colourbool = 1;
	}

	my $update_sql = qq{update SCAN set width = ?, height = ?, colour = ? where scan_id = ?;};
	my $update_sth = $db->prepare($update_sql);
	if (defined($w) && defined($h) && defined($colourbool)) {
		print "Updating image $scan_id\n";
		$update_sth->execute($w, $h, $colourbool, $scan_id);
	}
}
