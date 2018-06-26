package queries;

# This package contains reusable SQL queries as single variables
# This keeps the rest of the project clean

use strict;
use warnings;

# Set right lens_id for all negatives taken with fixed-lens cameras
our $set_lens_id = q{update
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
	and CAMERA.lens_id=LENS.lens_id};


# This ensures the lib loads smoothly
1;
