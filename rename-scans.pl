#!/usr/bin/perl -wT
# Ensure all scans are named in the format:
# <filmID>-<frame>-<originalfilename>.jpg
# e.g. 182-13-img3023.jpg

use strict;
use DBI;
use DBD::mysql;

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
	scan_id, concat(directory, '/', filename) as filepath,
	directory,
	filename,
	FILM.film_id,
	frame
from
	FILM,
	NEGATIVE,
	SCAN
where
	FILM.film_id=NEGATIVE.film_id
	and NEGATIVE.negative_id=SCAN.negative_id
	and SCAN.filename is not null
	and FILM.directory is not null;
};

my $update_sql = qq{
update
	SCAN
set
	filename = ?
where
	scan_id = ?;
};

# Prepare and execute the select SQL
my $select_sth = $db->prepare($select_sql);
$select_sth->execute();

# Prepare the update SQL - it will be executed later
my $update_sth = $db->prepare($update_sql);

# Now loop round, one scan at a time
while(my $row = $select_sth->fetchrow_hashref) {
	# First make sure the file is available
	if (-f "$basepath$row->{filepath}") {
		# Does existing filename start with filmID-frame-?
		if ($row->{filename} =~ m/^$row->{film_id}-$row->{frame}-/) {
			# Existing filename already complies, skipping
		} else {
			# Filename needs updating
			# Beware that some files already have a frame prefix. This needs stripping
			my $truncatedfilename = &truncateFilename($row->{filename});

			# Generate ideal new name
			my $idealfilename = "$row->{film_id}-$row->{frame}-$truncatedfilename";

			# Some final sanity checks before comitting anything
			# <filmid>-<frame>-<filename>.<extension>
			if ($idealfilename =~ m/^\d+-[0-9a-z]+-\w+\.\w+/i) {
				#print "Will rename scan $row->{scan_id} from $row->{filename} to $idealfilename\n";
				# Rename the file on the fs
				my $path = "$basepath$row->{directory}";
				if (&renameFile($path, $row->{filename}, $idealfilename)) {
					# if rename was successful, update the scan record in the db
					if ($update_sth->execute($idealfilename, $row->{scan_id})) {
						# Success updating db
						print "Successfully renamed scan $row->{scan_id}\n";
					} else {
						# Failure updating db
						print "Successfully renamed scan $row->{scan_id} but failed to update DB\n";
					}
				} else {
					# failure renaming file
					print "Could not rename scan $row->{scan_id}, skipping\n";
				}
			}
		}
	} else {
		# File not available
		print "Could not find scan $row->{scan_id}, skipping\n";
	}
}  

$db->disconnect();

sub truncateFilename {
# Removes any hyphenated prefixes
	my $filename = shift;
	if ($filename =~ m/^\d+-.+/) {
		# We have the prefix, split at hyphens and return last part
		my @split = split('-', $filename);
		return $split[$#split];
	} else {
		# Do not have the prefix, just return the original
		return $filename;
	}
}

sub renameFile {
# Renames a file on the fs
	my $basepath = shift;
	my $oldname = shift;
	my $newname = shift;
	my $returncode = rename "$basepath/$oldname", "$basepath/$newname";
	return $returncode;
}
