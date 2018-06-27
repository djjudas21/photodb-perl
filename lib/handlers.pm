package handlers;

# This package provides reusable handlers to be interact with the user

use strict;
use warnings;

use Exporter qw(import);
use Data::Dumper;
use Config::IniHash;

use lib 'lib';
use funcs;
use queries;

our @EXPORT = qw(film_add film_load film_develop);

sub film_add {
	# Add a newly-purchased film
	my $db = shift;
	my %data;
	$data{'filmstock_id'} = &listchoices($db, 'filmstock', "select filmstock_id as id, name as opt from FILMSTOCK");
	$data{'format_id'} = &listchoices($db, 'format', "select format_id as id, format as opt from FORMAT");
	$data{'frames'} = prompt('', 'How many frames?', 'integer');
	if (prompt('no', 'Is this film bulk-loaded?', 'boolean') == 1) {
		$data{'film_bulk_id'} = &listchoices($db, 'bulk film', "select * from choose_bulk_id");
		$data{'film_bulk_loaded'} = prompt(&today($db), 'When was the film bulk-loaded?');
	} else {
		$data{'film_batch'} = prompt('', 'Film batch number', 'text');
		$data{'film_expiry'} = prompt('', 'Film expiry date', 'date');
	}
	$data{'purchase_date'} = prompt(&today($db), 'Purchase date', 'date');
	$data{'price'} = prompt('', 'Purchase price', 'decimal');
	&newrecord($db, \%data, 'FILM');
}

sub film_load {
	# Load a film into a camera
	my $db = shift;
	my %data;
	my $film_id = &listchoices($db, 'film', "select * from choose_film_to_load");
	$data{'exposed_at'} = prompt(&lookupval($db, "select iso from FILM, FILMSTOCK where FILM.filmstock_id=FILMSTOCK.filmstock_id and film_id=$film_id"), 'What ISO?', 'integer');
	$data{'date_loaded'} = prompt(&today($db), 'What date was this film loaded?', 'date');
	$data{'camera_id'} = &listchoices($db, 'camera', "select C.camera_id as id, concat(M.manufacturer, ' ', C.model) as opt from CAMERA as C, FILM as F, MANUFACTURER as M where F.format_id=C.format_id and C.manufacturer_id=M.manufacturer_id and film_id=$film_id and own=1");
	$data{'notes'} = prompt('', 'Notes', 'text');
	&updaterecord($db, \%data, 'FILM', "film_id=$film_id");
}

sub film_develop {
	# Develop a film
	my $db = shift;
	my %data;
	my $film_id = &listchoices($db, 'film', "select * from choose_film_to_develop");
	$data{'date'} = prompt(&today($db), 'What date was this film processed?', 'date');
	$data{'developer_id'} = &listchoices($db, 'developer', "select developer_id as id, name as opt from DEVELOPER where for_film=1");
	$data{'directory'} = prompt('', 'What directory are these scans in?', 'text');
	$data{'photographer_id'} = &listchoices($db, 'photographer', "select photographer_id as id, name as opt from PHOTOGRAPHER");
	$data{'dev_uses'} = prompt('', 'How many previous uses has the developer had?', 'integer');
	$data{'dev_time'} = prompt('', 'How long was the film developed for?', 'hh:mm:ss');
	$data{'dev_temp'} = prompt('', 'What temperature was the developer?', 'decimal');
	$data{'dev_n'} = prompt(0, 'What push/pull was used?', 'integer');
	$data{'development_notes'} = prompt('', 'Any other development notes', 'text');
	$data{'processed_by'} = prompt('', 'Who developed the film?', 'text');
	&updaterecord($db, \%data, 'FILM', "film_id=$film_id");
}
