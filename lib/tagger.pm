package tagger;


# This script reads data from the analogue photography database and
# writes EXIF tags back to the JPGs that have been scanned from negatives
#
# TODO
# - Write out some film info in freeform field
# - log list of missing/corrupt files
# - use inifile for basepath
# - use pm for sql connector

use strict;
use warnings;
use Image::ExifTool;
use Image::ExifTool::Location;
use DBI;
use DBD::mysql;
use Config::IniHash;
use Exporter qw(import);

my $path;
BEGIN {
	if ($FindBin::Bin =~ /(.*)/) {
		$path = $1;
	}
}
use lib "$path/lib";
use funcs qw(/./);

our @EXPORT_OK = qw(tag);

sub tag {

# Read in cmdline args
my $db = shift;
my $film_id = shift // '%';

# Make sure basepath is valid
my $connect = ReadINI(&ini);
if (!defined($$connect{'filesystem'}{'basepath'})) {
	print "Config file did not contain basepath";
	return;
}
my $basepath = $$connect{'filesystem'}{'basepath'};
if (substr($basepath, -1, 1) ne '/') {
	$basepath .= '/';
}

# Crank up an instance of ExifTool
my $exifTool = Image::ExifTool->new;

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
	'ExposureProgram',
	'MeteringMode',
	'Flash',
);

# This is the query that fetches (and calculates) values from the DB that we want to write as EXIF tags
my $sql = 'SELECT * from exifdata where film_id = ?';

# Prepare and execute the SQL
my $sth = $db->prepare($sql) or die "Couldn't prepare statement: " . $db->errstr;
my $rows = $sth->execute($film_id);

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

			# If a change has been made to the EXIF data, write out the data
			if ($changeflag == 1) {
				$exifTool->WriteInfo("$basepath$ref->{'path'}");
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
return;
}

# This ensures the lib loads smoothly
1;
