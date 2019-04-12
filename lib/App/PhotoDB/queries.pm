package App::PhotoDB::queries;

# This package contains reusable SQL queries as single variables
# This keeps the rest of the project clean

use strict;
use warnings;

our @reports = (
	{
		desc => 'Report on how many cameras in the collection are from each decade',
		view => 'report_cameras_by_decade',
	},
	{
		desc => 'Report on which lenses have been used to take most frames',
		view => 'report_most_popular_lenses_relative',
	},
	{
		desc => 'Report on cameras that have never been to used to take a frame',
		view => 'report_never_used_cameras',
	},
	{
		desc => 'Report on lenses that have never been used to take a frame',
		view => 'report_never_used_lenses',
	},
	{
		desc => 'Report on the cameras that have taken most frames',
		view => 'report_total_negatives_per_camera',
	},
	{
		desc => 'Report on the lenses that have taken most frames',
		view => 'report_total_negatives_per_lens',
	},
	{
		desc => 'Report on negatives that have not been scanned',
		view => 'report_unscanned_negs',
	}
);

# This ensures the lib loads smoothly
1;
