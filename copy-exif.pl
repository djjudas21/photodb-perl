#!/usr/bin/perl -w
# Find derivative images and copy exif data to them from their parents

use strict;
use warnings;
use File::Basename;

my $path = '/home/jonathan/Pictures/Photos/';

# Make a list of all JPGs
print "Searching for all JPGs in path $path...\n";
my $t1 = time;
my @all = `find $path -iname *.jpg`;
my $countall = scalar(@all);
my $t2 = time;
my $td = $t2-$t1;
print "Found $countall images in ${td}s\n";

# Make new array of all of these that do NOT have exif tags
print "Scanning these files for ones with missing date...\n";

$t1=time;
my @notags;
foreach my $file (@all) {
	chomp $file;
	# Skip things that look like they came from a DSLR
	next if ($file =~ m/.*\/IMG_\d{4}\.jpg$/i);

	`exiftool -q -q -if '\$datetimeoriginal' -dummy "$file"`;
	if ($?) {
		push(@notags, $file)
	} else {
	}

}
$t2=time;
$td = $t2-$t1;
my $countnotags = scalar(@notags);
print "Found $countnotags images without EXIF date stamp in ${td}s\n";
print "Looking for parent files for these using guesswork...\n";

my $parentcount = 0;
my $parentexifcount = 0;

foreach my $file (@notags) {
	chomp $file;
	# Eliminate obvious no-exif cases e.g. Nokia 6230
	#next if (`exiftool -if '\$model eq "Nokia 6230"' -dummy "$file"`);

	my $fname = basename($file);
	my $dir = dirname($file);

	# File that this file is derived from
	my $parent;

	# Of these, guess the original filename
# 	e.g. XXXXXXXb.jpg => XXXXXXX.jpg (edited)
	if ($fname =~ m/^(.+\d+)[bcd](\.jpg)$/i) {
		if (-e "$dir/$1.jpg") {
			$parent = "$1.jpg";
		} elsif (-e "$dir/$1.JPG") {
			$parent = "$1.JPG";
		}
		print "Found parent $parent for $fname\n";
		$parentcount++;
# 	XXXXXX.resized.jpg => XXXXXXX.jpg (resized)
	} elsif ($fname =~ m/^(.+)\.resized(\.jpg)$/i) {
		if (-e "$dir/$1.jpg") {
                        $parent = "$1.jpg";
		} elsif (-e "$dir/$1.JPG") {
                        $parent = "$1.JPG";
                }
		print "Found parent $parent for $fname\n";
		$parentcount++;
# 	IMG_1111-2222XXXXXX.jpg => IMG_1111.jpg (HDR/pano)
	} elsif ($fname =~ m/^(IMG_\d{3,5})-\d{3,5}.*(\.jpg)$/i) {
		if (-e "$dir/$1.jpg") {
                        $parent = "$1.jpg";
		} elsif (-e "$dir/$1.JPG") {
                        $parent = "$1.JPG";
                }
		print "Found parent $parent for $fname\n";
		$parentcount++;
# 	XXXXXX-(blue|red|green).jpg => XXXXXX.jpg
	} elsif ($fname =~ m/^(.+)-(blue|red|green)(\.jpg)$/i) {
		if (-e "$dir/$1.jpg") {
                        $parent = "$1.jpg";
		} elsif (-e "$dir/$1.JPG") {
                        $parent = "$1.JPG";
                }
		print "Found parent $parent for $fname\n";
		$parentcount++;
	} else {
		next;
	}

	# Now we've identified a parent photo, does it have EXIF?
	`exiftool -q -q -if '\$datetimeoriginal' -dummy "$dir/$parent"`;
	if ($?) {
	} else {
		print "  $parent DOES have metadata, copying it now\n";
		$parentexifcount++;

		# Copy metadata from parent to child
		`exiftool -TagsFromFile "$dir/$parent" --orientation "$dir/$fname" -overwrite_original`
	}
}

print "Found $parentcount parent files, of which $parentexifcount had EXIF data that we copied\n";
