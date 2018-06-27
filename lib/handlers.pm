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

our @EXPORT = qw(film_add film_load film_develop camera_add);

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

sub camera_add {
	# Add a new camera
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER");
	$data{'model'} = prompt('', 'What model is the camera?', 'text');
	$data{'mount_id'} = &listchoices($db, 'mount', "select mount_id as id, mount as opt from MOUNT where purpose='Camera'");
	$data{'format_id'} = &listchoices($db, 'format', "select format_id as id, format as opt from FORMAT");
	$data{'focus_type_id'} = &listchoices($db, 'focus type', "select focus_type_id as id, focus_type as opt from FOCUS_TYPE");
	$data{'metering'} = prompt('', 'Does this camera have metering?', 'boolean');
	if ($data{'metering'} == 1) {
		$data{'coupled_metering'} = prompt('', 'Is the metering coupled?', 'boolean');
		$data{'metering_mode_id'} = &listchoices($db, 'metering mode', "select metering_mode_id as id, metering_mode as opt from METERING_MODE");
		$data{'metering_type_id'} = &listchoices($db, 'metering type', "select metering_type_id as id, metering as opt from METERING_TYPE");
		$data{'meter_min_ev'} = prompt('', 'What\'s the lowest EV the meter can handle?', 'integer');
		$data{'meter_max_ev'} = prompt('', 'What\'s the highest EV the meter can handle?', 'integer');
	}
	$data{'body_type_id'} = &listchoices($db, 'body type', "select body_type_id as id, body_type as opt from BODY_TYPE");
	$data{'weight'} = prompt('', 'What does it weigh? (g)', 'integer');
	$data{'acquired'} = prompt(&today($db), 'When was it acquired?', 'date');
	$data{'cost'} = prompt('', 'What did the camera cost?', 'decimal');
	$data{'introduced'} = prompt('', 'What year was the camera introduced?', 'integer');
	$data{'discontinued'} = prompt('', 'What year was the camera discontinued?', 'integer');
	$data{'serial'} = prompt('', 'What is the camera\'s serial number?', 'text');
	$data{'datecode'} = prompt('', 'What is the camera\'s datecode?', 'text');
	$data{'manufactured'} = prompt('', 'When was the camera manufactured?', 'integer');
	$data{'own'} = prompt('yes', 'Do you own this camera?', 'boolean');
	$data{'negative_size_id'} = &listchoices($db, 'negative size', "select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE");
	$data{'shutter_type_id'} = &listchoices($db, 'shutter type', "select shutter_type_id as id, shutter_type as opt from SHUTTER_TYPE");
	$data{'shutter_model'} = prompt('', 'What is the shutter model?', 'text');
	$data{'cable_release'} = prompt('', 'Does this camera have a cable release?', 'boolean');
	$data{'viewfinder_coverage'} = prompt('', 'What is the viewfinder coverage?', 'integer');
	$data{'power_drive'} = prompt('', 'Does this camera have power drive?', 'boolean');
	if ($data{'power_drive'} == 1) {
		$data{'continuous_fps'} = prompt('How many frames per second can this camera manage?', 'decimal');
	}
	$data{'video'} = prompt('no', 'Does this camera have a video/movie function?', 'boolean');
	$data{'digital'} = prompt('no', 'Is this a digital camera?', 'boolean');
	$data{'fixed_mount'} = prompt('', 'Does this camera have a fixed lens?', 'boolean');
	if ($data{'fixed_mount'} == 1) {
		#$data{'lens_id'} = &listchoices
	}
	$data{'battery_qty'} = prompt('', 'How many batteries does this camera take?', 'integer');
	if ($data{'battery_qty'} > 0) {
		$data{'battery_type'} = &listchoices($db, 'battery type', "select * from choose_battery");
	}
	$data{'notes'} = prompt('', 'Additional notes', 'text');
	$data{'source'} = prompt('', 'Where was the camera acquired from?', 'text');
	$data{'min_shutter'} = prompt('', 'What\'s the fastest shutter speed?', 'text');
	$data{'max_shutter'} = prompt('', 'What\'s the slowest shutter speed?', 'text');
	$data{'bulb'} = prompt('', 'Does the camera have bulb exposure mode?', 'boolean');
	$data{'time'} = prompt('', 'Does the camera have time exposure mode?', 'boolean');
	$data{'min_iso'} = prompt('', 'What\'s the lowest ISO the camera can do?', 'integer');
	$data{'max_iso'} = prompt('', 'What\'s the highest ISO the camera can do?', 'integer');
	$data{'af_points'} = prompt('', 'How many autofocus points does the camera have?', 'integer');
	$data{'int_flash'} = prompt('', 'Does the camera have an internal flash?', 'boolean');
	if ($data{'int_flash'} == 1) {
		$data{'int_flash_gn'} = prompt('', 'What\'s the guide number of the internal flash?', 'integer');
	}
	$data{'ext_flash'} = prompt('', 'Does the camera support an external flash?', 'boolean');
	if ($data{'ext_flash'} == 1) {
		$data{'pc_sync'} = prompt('', 'Does the camera have a PC sync socket?', 'boolean');
		$data{'hotshoe'} = prompt('', 'Does the camera have a hot shoe?', 'boolean');
	}
	if ($data{'int_flash'} == 1 || $data{'ext_flash'} == 1) {
		$data{'coldshoe'} = prompt('', 'Does the camera have a cold/accessory shoe?', 'boolean');
		$data{'x_sync'} = prompt('', 'What\'s the X-sync speed?', 'text');
		$data{'flash_metering'} = &listchoices($db, 'flash protocol', "select * from FLASH_PROTOCOL");
	}
	$data{'condition_id'} = &listchoices($db, 'condition', "select condition_id as id, name as opt from `CONDITION`");
	$data{'oem_case'} = prompt('', 'Do you have the original case for this camera?', 'boolean');
	$data{'dof_preview'} = prompt('', 'Does this camera have a depth-of-field preview feature?', 'boolean');
	my $cameraid = &newrecord($db, \%data, 'CAMERA');

	# Now we have a camera ID, we can insert rows in auxiliary tables
	if (prompt('yes', 'Add exposure programs for this camera?', 'boolean')) {
		if (my $m = prompt('', 'Does it have manual exposure?', 'boolean')) {
			my %epdata = ('camera_id' => $cameraid, 'exposure_program_id' => '1');
			&newrecord($db, \%epdata, 'EXPOSURE_PROGRAM_AVAILABLE');
		}
		if (my $p = prompt('', 'Does it have program/auto exposure?', 'boolean')) {
			my %epdata = ('camera_id' => $cameraid, 'exposure_program_id' => '2');
			&newrecord($db, \%epdata, 'EXPOSURE_PROGRAM_AVAILABLE');
		}
		if (my $av = prompt('', 'Does it have aperture priority exposure?', 'boolean')) {
			my %epdata = ('camera_id' => $cameraid, 'exposure_program_id' => '3');
			&newrecord($db, \%epdata, 'EXPOSURE_PROGRAM_AVAILABLE');
		}
		if (my $tv = prompt('', 'Does it have shutter priority exposure?', 'boolean')) {
			my %epdata = ('camera_id' => $cameraid, 'exposure_program_id' => '4');
			&newrecord($db, \%epdata, 'EXPOSURE_PROGRAM_AVAILABLE');
		}
		if (my $tv = prompt('', 'Does it have bulb exposure?', 'boolean')) {
			my %epdata = ('camera_id' => $cameraid, 'exposure_program_id' => '9');
			&newrecord($db, \%epdata, 'EXPOSURE_PROGRAM_AVAILABLE');
		}
	}

	if (prompt('yes', 'Add shutter speeds for this camera?', 'boolean')) {
		while (1) {
			my %shutterdata;
			$shutterdata{'shutter_speed'} = prompt('', 'Enter shutter speed', 'text');
			$shutterdata{'camera_id'} = $cameraid;
			&newrecord($db, \%shutterdata, 'SHUTTER_SPEED_AVAILABLE');
			if (!prompt('yes', 'Add another shutter speed?', 'boolean')) {
				last;
			}
		}
	}
}
