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

our @EXPORT = qw(film_add film_load film_develop camera_add camera_displaylens negative_add negative_bulkadd lens_add print_add print_tone print_sell paperstock_add developer_add);

sub film_add {
	# Add a newly-purchased film
	my $db = shift;
	my %data;
	$data{'filmstock_id'} = &listchoices($db, 'filmstock', "select * from choose_filmstock");
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

sub camera_displaylens {
	my $db = shift;
	my %data;
	$data{'camera_id'} = &listchoices($db, 'camera', "select camera_id as id, concat( manufacturer, ' ',model) as opt from CAMERA, MANUFACTURER where mount_id is not null and own=1 and CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id and camera_id not in (select camera_id from DISPLAYLENS)");
	my $mount = &lookupval($db, "select mount_id from CAMERA where camera_id=$data{'camera_id'}");
	$data{'lens_id'} = &listchoices($db, 'lens', "select lens_id as id, concat(manufacturer, ' ', model) as opt from LENS, MANUFACTURER where mount_id=$mount and LENS.manufacturer_id=MANUFACTURER.manufacturer_id and own=1 and lens_id not in (select lens_id from DISPLAYLENS)");
	&newrecord($db, \%data, 'DISPLAYLENS');
}

sub negative_add {
	# Add a single neg to a film
	my $db = shift;
	my %data;
	$data{'film_id'} = prompt('', 'Which film does this negative belong to?', 'integer');
	$data{'frame'} = prompt('', 'Frame number', 'text');
	$data{'description'} = prompt('', 'Caption', 'text');
	$data{'date'} = prompt(&today($db), 'What date was this negative taken?', 'date');
	$data{'lens_id'} = &listchoices($db, 'lens', "select LENS.lens_id as id, LENS.model as opt from FILM, CAMERA, LENS where FILM.camera_id=CAMERA.camera_id and CAMERA.mount_id=LENS.mount_id and FILM.film_id=$data{'film_id'}");
	$data{'shutter_speed'} = prompt('', 'Shutter speed', 'text');
	$data{'aperture'} = prompt('', 'Aperture', 'decimal');
	$data{'filter_id'} = &listchoices($db, 'filter', "select * from choose_filter");
	$data{'teleconverter_id'} = &listchoices($db, 'teleconverter', "select teleconverter_id as id, concat(manufacturer, ' ', T.model, ' (', factor, 'x)') as opt from TELECONVERTER as T, CAMERA as C, FILM as F, MANUFACTURER as M where C.mount_id=T.mount_id and F.camera_id=C.camera_id and M.manufacturer_id=T.manufacturer_id and film_id=$data{'film_id'}");
	$data{'notes'} = prompt('', 'Extra notes', 'text');
	$data{'mount_adapter_id'} = &listchoices($db, 'mount adapter', "select mount_adapter_id as id, mount as opt from MOUNT_ADAPTER as MA, CAMERA as C, FILM as F, MOUNT as M where C.mount_id=MA.camera_mount and F.camera_id=C.camera_id and M.mount_id=MA.lens_mount and film_id=$data{'film_id'}");
	$data{'focal_length'} = prompt(&lookupval($db, "select min_focal_length from LENS where lens_id=$data{'lens_id'}"), 'Focal length', 'integer');
	$data{'latitude'} = prompt('', 'Latitude', 'decimal');
	$data{'longitude'} = prompt('', 'Longitude', 'decimal');
	$data{'flash'} = prompt('no', 'Was flash used?', 'boolean');
	$data{'metering_mode'} = &listchoices($db, 'metering mode', "select metering_mode_id as id, metering_mode as opt from METERING_MODE");
	$data{'exposure_program'} = &listchoices($db, 'exposure program', "select exposure_program_id as id, exposure_program as opt from EXPOSURE_PROGRAM");
	&newrecord($db, \%data, 'NEGATIVE');
}

sub negative_bulkadd {
	my $db = shift;
	# Add lots of negatives to a film, maybe asks if they were all shot with the same lens
	my $film_id = prompt('', 'Bulk add negatives to which film?', 'integer');
	my $num = prompt('', 'How many frames to add?', 'integer');

	# Execute query
	my $sth = $db->prepare('insert into NEGATIVE (film_id, frame) values (?, ?)');
	for my $i (1..$num) {
		$sth->execute($film_id, $i);
	}
}

sub lens_add {
	my $db = shift;
	my %data;
	$data{'fixed_mount'} = prompt('no', 'Does this lens have a fixed mount?', 'boolean');
	if ($data{'fixed_mount'} == 0) {
		$data{'mount_id'} = &listchoices($db, 'mount', "select mount_id as id, mount as opt from MOUNT");
	}
	$data{'zoom'} = prompt('no', 'Is this a zoom lens?', 'boolean');
	if ($data{'zoom'} == 0) {
		$data{'min_focal_length'} = prompt('', 'What is the focal length?', 'integer');
		$data{'max_focal_length'} = $data{'min_focal_length'};
	} else {
		$data{'min_focal_length'} = prompt('', 'What is the minimum focal length?', 'integer');
		$data{'max_focal_length'} = prompt('', 'What is the maximum focal length?', 'integer');
	}
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER");
	$data{'model'} = prompt('', 'What is the lens model?', 'text');
	$data{'closest_focus'} = prompt('', 'How close can the lens focus? (cm)', 'integer');
	$data{'max_aperture'} = prompt('', 'What is the largest lens aperture?', 'decimal');
	$data{'min_aperture'} = prompt('', 'What is the smallest lens aperture?', 'decimal');
	$data{'elements'} = prompt('', 'How many elements does the lens have?', 'integer');
	$data{'groups'} = prompt('', 'How many groups are these elements in?', 'integer');
	$data{'weight'} = prompt('', 'What is the weight of the lens? (g)', 'integer');
	$data{'nominal_min_angle_diag'} = prompt('', 'What is the minimum diagonal angle of view?', 'integer');
	$data{'nominal_max_angle_diag'} = prompt('', 'What is the maximum diagonal angle of view?', 'integer');
	$data{'aperture_blades'} = prompt('', 'How many aperture blades does the lens have?', 'integer');
	$data{'autofocus'} = prompt('', 'Does this lens have autofocus?', 'boolean');
	$data{'filter_thread'} = prompt('', 'What is the diameter of the filter thread? (mm)', 'decimal');
	$data{'magnification'} = prompt('', 'What is the maximum magnification possible with this lens?', 'decimal');
	$data{'url'} = prompt('', 'Informational URL for this lens', 'text');
	$data{'serial'} = prompt('', 'What is the serial number of the lens?', 'text');
	$data{'date_code'} = prompt('', 'What is the date code of the lens?', 'text');
	$data{'introduced'} = prompt('', 'When was this lens introduced?', 'integer');
	$data{'discontinued'} = prompt('', 'When was this lens discontinued?', 'integer');
	$data{'manufactured'} = prompt('', 'When was this lens manufactured?', 'integer');
	$data{'negative_size_id'} = &listchoices($db, 'negative size', "select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE");
	$data{'acquired'} = prompt(&today($db), 'When was this lens acquired?', 'date');
	$data{'cost'} = prompt('', 'How much did this lens cost?', 'decimal');
	$data{'notes'} = prompt('', 'Notes', 'text');
	$data{'own'} = prompt('yes', 'Do you own this lens?', 'boolean');
	$data{'source'} = prompt('', 'Where was this lens sourced from?', 'text');
	$data{'coating'} = prompt('', 'What coating does this lens have?', 'text');
	$data{'hood'} = prompt('', 'What is the model number of the suitable hood for this lens?', 'text');
	$data{'hood_id'} = &listchoices($db, 'lens hood', "select hood_id as id, model as opt from HOOD");
	$data{'exif_lenstype'} = prompt('', 'EXIF lens type code', 'text');
	$data{'rectilinear'} = prompt('yes', 'Is this a rectilinear lens?', 'boolean');
	$data{'length'} = prompt('', 'How long is this lens? (mm)', 'integer');
	$data{'diameter'} = prompt('', 'How wide is this lens? (mm)', 'integer');
	$data{'condition_id'} = &listchoices($db, 'condition', "select condition_id as id, name as opt from `CONDITION`");
	$data{'image_circle'} = prompt('', 'What is the diameter of the image circle?', 'integer');
	$data{'formula'} = prompt('', 'Does this lens have a named optical formula?', 'text');
	$data{'shutter_model'} = prompt('', 'What shutter does this lens incorporate?', 'text');
	&newrecord($db, \%data, 'LENS');
}

sub print_add {
	my $db = shift;
	my %data;
	my $film_id = prompt('', 'Film ID to print from', 'integer');
	my $frame = &listchoices($db, 'Frame to print from', "select frame as id, description as opt from NEGATIVE where film_id=$film_id", 'text');
	my $neg_id = &lookupval($db, "select lookupneg('$film_id', '$frame')");
	$data{'negative_id'} = prompt($neg_id, 'Negative ID to print from', 'integer');
	$data{'date'} = prompt(&today($db), 'Date that the print was made', 'date');
	$data{'paper_stock_id'} = &listchoices($db, 'paper stock', "select * from choose_paper");
	$data{'height'} = prompt('', 'Height of the print (inches)', 'integer');
	$data{'width'} = prompt('', 'Width of the print (inches)', 'integer');
	$data{'aperture'} = prompt('', 'Aperture used on enlarging lens', 'decimal');
	$data{'exposure_time'} = prompt('', 'Exposure time (s)', 'integer');
	$data{'filtration_grade'} = prompt('', 'Filtration grade', 'decimal');
	$data{'development_time'} = prompt('', 'Development time (s)', 'integer');
	$data{'enlarger_id'} = &listchoices($db, 'enlarger', "select * from choose_enlarger");
	$data{'lens_id'} = &listchoices($db, 'enlarger lens', "select * from choose_enlarger_lens");
	$data{'developer_id'} = &listchoices($db, 'developer', "select developer_id as id, name as opt from DEVELOPER where for_paper=1");
	$data{'fine'} = prompt('', 'Is this a fine print?', 'boolean');
	$data{'notes'} = prompt('', 'Notes', 'text');
	&newrecord($db, \%data, 'PRINT');
}

sub print_tone {
	my $db = shift;
	my %data;
	my %where;
	$where{'print_id'} = prompt('', 'Which print did you tone?', 'integer');
	$data{'bleach_time'} = prompt('00:00:00', 'How long did you bleach for? (HH:MM:SS)', 'hh:mm:ss');
	$data{'toner_id'} = &listchoices($db, 'toner', "select toner_id as id, toner as opt from TONER");
	$data{'toner_dilution'} = prompt('', 'What was the dilution of the first toner?', 'text');
	$data{'toner_time'} = prompt('', 'How long did you tone for? (HH:MM:SS)', 'hh:mm:ss');
	if (prompt('no', 'Did you use a second toner?', 'boolean') == 1) {
		$data{'2nd_toner_id'} = &listchoices($db, 'toner', "select toner_id as id, toner as opt from TONER");
		$data{'2nd_toner_dilution'} = prompt('', 'What was the dilution of the second toner?', 'text');
		$data{'2nd_toner_time'} = prompt('', 'How long did you tone for? (HH:MM:SS)', 'hh:mm:ss');
	}
	&updaterecord($db, \%data, 'PRINT', \%where);
}

sub print_sell {
	my $db = shift;
	my %data;
	my $print_id = prompt('', 'Which print did you sell?', 'integer');
	$data{'own'} = 0;
	$data{'location'} = prompt('', 'What happened to the print?', 'text');
	$data{'sold_price'} = prompt('', 'What price was the print sold for?', 'decimal');
	&updaterecord($db, \%data, 'PRINT', "print_id=$print_id");
}

sub paperstock_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER");
	$data{'name'} = prompt('', 'What model is the paper?', 'text');
	$data{'resin_coated'} = prompt('', 'Is this paper resin-coated?', 'boolean');
	$data{'tonable'} = prompt('', 'Is this paper tonable?', 'boolean');
	$data{'colour'} = prompt('', 'Is this a colour paper?', 'boolean');
	$data{'finish'} = prompt('', 'What surface finish does this paper have?', 'text');
	&newrecord($db, \%data, 'PAPER_STOCK');
}

sub developer_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER");
	$data{'name'} = prompt('', 'What model is the developer?', 'text');
	$data{'for_paper'} = prompt('', 'Is this developer suitable for paper?', 'boolean');
	$data{'for_film'} = prompt('', 'Is this developer suitable for film?', 'boolean');
	$data{'chemistry'} = prompt('', 'What type of chemistry is this developer based on?', 'text');
	&newrecord($db, \%data, 'DEVELOPER');
}
