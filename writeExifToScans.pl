#!/usr/bin/perl -wT

# This script reads data from the analogue photography database and
# writes EXIF tags back to the JPGs that have been scanned from negatives
#
# TODO
# - Write out some film info in freeform field
# - log list of missing/corrupt files
# - write lat/long

use strict;
use Image::ExifTool;
use Image::ExifTool::Location;
use DBI;
use DBD::mysql;
use Getopt::Long;

# Read in cmdline args
my $film_id = '%';
my $dry_run = 0;
my $to_be_edited = 0;
my $result = GetOptions ("film_id=i" => \$film_id,    # numeric
#                    "file=s"   => \$data,      # string
                    "dry_run"  => \$dry_run,   # flag
                    "to_be_edited"  => \$to_be_edited);  # flag

# Make sure basepath is valid
my $basepath;
if ($to_be_edited) {
	$basepath = '/home/jonathan/Pictures/Negatives/To be edited';
} else {
	$basepath = '/home/jonathan/Pictures/Negatives';
}
if (substr($basepath, -1, 1) ne '/') {
	$basepath .= '/';
}

# Crank up an instance of ExifTool
my $exifTool = new Image::ExifTool;

# Specify which attributes we want to write
# If any are specified here but not available, they will be ignored
my @attributes = (
	'Make',
	'Model',
	'Lens',
	'LensModel',
	'ExposureTime',
	'MaxApertureValue',
	'FNumber',
	'ApertureValue',
	'FocalLength',
	'ISO',
	'Author',
	'ImageDescription',
	'DateTimeOriginal',
#	'GPSLatitude',
#	'GPSLongitude',
);

# Connect to the database
my $dsn = "DBI:mysql:database=photography;host=192.168.0.2";
my $dbh = DBI->connect($dsn, 'photography','photography') or die "Couldn't connect to database: " . DBI->errstr;

# This is the query that fetches (and calculates) values from the DB that we want to write as EXIF tags
my $sql = q{SELECT
	cm.manufacturer AS Make,
	concat (cm.manufacturer, ' ', c.model) AS Model,
	p.name AS Author,
	concat(lm.manufacturer, ' ', l.model) AS LensModel,
	concat(lm.manufacturer, ' ', l.model) AS Lens,
	concat(f.directory, '/', n.filename) AS path,
	l.max_aperture as MaxApertureValue,
	f.directory,
	n.filename,
	n.shutter_speed AS ExposureTime,
	n.aperture AS FNumber,
	n.aperture AS ApertureValue,
	if(l.min_focal_length=l.max_focal_length, concat(l.min_focal_length, '.0 mm'), concat(n.focal_length, '.0mm')) as FocalLength,
	if(f.exposed_at is not null, f.exposed_at, fs.iso) as ISO,
	n.description as ImageDescription,
	concat (date_format(n.date, '%Y:%m:%d'), ' 00:00:00') as DateTimeOriginal,
	n.latitude as GPSLatitude,
	n.longitude as GPSLongitude
FROM
	FILMSTOCK as fs,
	PHOTOGRAPHER as p,
	NEGATIVE AS n
	INNER JOIN FILM AS f ON n.film_id = f.film_id 
	INNER JOIN CAMERA AS c ON f.camera_id = c.camera_id  
	INNER JOIN MANUFACTURER AS cm ON c.manufacturer_id = cm.manufacturer_id  
	LEFT JOIN LENS AS l ON n.lens_id = l.lens_id  
	LEFT JOIN MANUFACTURER AS lm ON l.manufacturer_id = lm.manufacturer_id
WHERE
	f.photographer_id=p.photographer_id
	and n.filename is not null
	and f.filmstock_id=fs.filmstock_id
};

# Do we filter by film_id or not?
if ($film_id =~ m/\d+/) {
	$sql .= " and f.film_id = '$film_id';";
} else {
	$sql .= ';';
}

# Prepare and execute the SQL
my $sth = $dbh->prepare($sql) or die "Couldn't prepare statement: " . $dbh->errstr;
my $rows = $sth->execute();

# Set some globals
my $foundcount=0;
my $changedcount=0;
my @missingfiles;

# Loop through our result set
while (my $ref = $sth->fetchrow_hashref()) {
	# First check the path is defined in MySQL
	if (defined($ref->{'path'})) {
		# Now make sure the path actually exists on the system
		if (-e "$basepath$ref->{'path'}") {
			# File exists, so we go on and do stuff to it.
			# Grab the existing EXIF tags for comparison
			my $exif = $exifTool->ImageInfo("$basepath$ref->{'path'}");
			my $changeflag = 0;
			$foundcount++;

			# For each of the attributes on our list...
			foreach my $var (@attributes) {
				#  Test if it exists in the DB
				if (defined($ref->{$var})) {
					# Test if it already exists in the file AND has the correct value
					if (defined($exif->{$var}) && ($exif->{$var} eq $ref->{$var})) {
						# Tag already has correct value, skip
					} else {
						# Set the value of the tag and flag that a change was made
						print "    Setting $var: $ref->{$var}\n";
						$exifTool->SetNewValue($var => $ref->{$var});
						$changeflag = 1;
					}
				}
			}

			# Handle the geotags separately
			# If the data exists in the DB...
			if (defined($ref->{'GPSLatitude'}) && defined($ref->{'GPSLongitude'})) {
				# And the image doesn't already have the same geotag
				if (!$exifTool->HasLocation()) {
					# image doesn't have any geotag, write one
					print "    Setting GPSLatitude: $ref->{'GPSLatitude'}\n";
					print "    Setting GPSLongitude: $ref->{'GPSLongitude'}\n";
					$exifTool->SetLocation($ref->{'GPSLatitude'}, $ref->{'GPSLongitude'});
					$changeflag = 1;
				} else {
					my ($imglat, $imglon) = $exifTool->GetLocation();
					if ($imglat == $ref->{'GPSLatitude'} && $imglon == $ref->{'GPSLongitude'}) {
					# image is already tagged with correct tag, skip
					} else {
						# Image has wrong geotag, write the correct geotag
						print "    Setting GPSLatitude: $ref->{'GPSLatitude'}\n";
						print "    Setting GPSLongitude: $ref->{'GPSLongitude'}\n";
						$exifTool->SetLocation($ref->{'GPSLatitude'}, $ref->{'GPSLongitude'});
						$changeflag = 1;
					}
				}
			}

			# If a change has been made to the EXIF data AND we're
			# not doing a dry run, write out the data
			if ($changeflag == 1) {
				if ($dry_run != 1) {
					$exifTool->WriteInfo("$basepath$ref->{'path'}");
				}
				print "Wrote tags to $basepath$ref->{'path'}\n\n";
				$changedcount++;
			}
		} else {
			print "$basepath$ref->{'path'} not found - skipping\n";
			push (@missingfiles, "$basepath$ref->{'path'}");
		}
	}
}

# Print some stats
print "Found $foundcount images\n";
print "Changed EXIF data in $changedcount images\n";
print 'Found ' . ($#missingfiles + 1) . " missing files\n";
