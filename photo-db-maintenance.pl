#!/usr/bin/perl -wT

# Script to be run by cron which performs routine maintenance on
# the photo db. Authoritative copies of queries at
# http://wiki.jonathangazeley.com/doku.php?id=photography_inventory

use strict;
use warnings;
use DBI;
use DBD::mysql;

# CONFIG VARIABLES
my $database = "photography";
my $host = "zeus.jonathangazeley.com";
my $user = "photography";
my $pw = "photography";

#DATA SOURCE NAME
my $dsn = "dbi:mysql:$database:$host:3306";

# PERL DBI CONNECT
my $dbh = DBI->connect($dsn, $user, $pw) || die "Could not connect to database: $DBI::errstr";

my @sql;
push @sql, ['Set right lens_id for all negatives taken with fixed-lens cameras',
	'update
		NEGATIVE,
		LENS,
		CAMERA,
		FILM
	set
		NEGATIVE.lens_id=LENS.lens_id
	where
		NEGATIVE.film_id=FILM.film_id
		and FILM.camera_id=CAMERA.camera_id
		and CAMERA.fixed_mount=1
		and CAMERA.lens_id=LENS.lens_id'
	];


push @sql, ['Update focal_length in the NEGATIVE table for prime lenses',
	'update
		NEGATIVE, LENS
	set
		NEGATIVE.focal_length=LENS.min_focal_length
	where
		NEGATIVE.lens_id=LENS.lens_id
		and NEGATIVE.focal_length is null
		and NEGATIVE.teleconverter_id is null
		and LENS.zoom = 0'
	];


push @sql, ['Update focal_length in the NEGATIVE table for prime lenses with a teleconverter',
	'update
		NEGATIVE, LENS, TELECONVERTER
	set
		NEGATIVE.focal_length=LENS.min_focal_length * TELECONVERTER.factor
	where
		NEGATIVE.lens_id=LENS.lens_id
		and NEGATIVE.teleconverter_id = TELECONVERTER.teleconverter_id
		and NEGATIVE.focal_length is null
		and NEGATIVE.teleconverter_id is not null
		and LENS.zoom = 0'
	];

foreach (@sql) {
	my $rows = $dbh->do($$_[1]) || die "Query failed: $dbh->{'errstr'}";
	if ($rows > 0) {
		print "$rows rows updated: $$_[0]\n";
	}
}







$dbh->disconnect();
