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
use tagger;

our @EXPORT = qw(
	film_add film_load film_archive film_develop film_tag film_locate
	camera_add camera_displaylens camera_sell camera_repair camera_addbodytype camera_stats
	mount_add mount_view mount_adapt
	negative_add negative_bulkadd negative_stats
	lens_add lens_sell lens_repair lens_stats
	print_add print_tone print_sell print_order print_fulfil print_archive print_locate
	paperstock_add
	developer_add
	toner_add
	task_run
	filmstock_add
	teleconverter_add
	filter_add filter_adapt
	manufacturer_add
	accessory_add accessory_type
	enlarger_add enlarger_sell
	flash_add
	battery_add
	format_add
	negativesize_add
	lightmeter_add
	process_add
	person_add
	projector_add
	movie_add
	archive_add archive_films archive_list archive_seal archive_unseal archive_move
	shuttertype_add focustype_add flashprotocol_add meteringtype_add shutterspeed_add
);

sub film_add {
	# Add a newly-purchased film
	my $db = shift;
	my %data;
	$data{'filmstock_id'} = &listchoices($db, 'filmstock', "select * from choose_filmstock", 'integer', \&filmstock_add);
	$data{'format_id'} = &listchoices($db, 'format', "select format_id as id, format as opt from FORMAT", 'integer', \&format_add);
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
	my $filmid = &newrecord($db, \%data, 'FILM');
	return $filmid;
}

sub film_load {
	# Load a film into a camera
	my $db = shift;
	my %data;
	my $film_id = &listchoices($db, 'film', "select * from choose_film_to_load");
	$data{'exposed_at'} = prompt(&lookupval($db, "select iso from FILM, FILMSTOCK where FILM.filmstock_id=FILMSTOCK.filmstock_id and film_id=$film_id"), 'What ISO?', 'integer');
	$data{'date_loaded'} = prompt(&today($db), 'What date was this film loaded?', 'date');
	$data{'camera_id'} = &listchoices($db, 'camera', "select C.camera_id as id, concat(M.manufacturer, ' ', C.model) as opt from CAMERA as C, FILM as F, MANUFACTURER as M where F.format_id=C.format_id and C.manufacturer_id=M.manufacturer_id and film_id=$film_id and own=1 order by opt");
	$data{'notes'} = prompt('', 'Notes', 'text');
	&updaterecord($db, \%data, 'FILM', "film_id=$film_id");
}

sub film_archive {
	# Archive a film for storage
	my $db = shift;
	my %data;
	my $film_id = prompt('', 'Enter ID of film to archive', 'integer');
	$data{'archive_id'} = &listchoices($db, 'archive', "select archive_id as id, name as opt from ARCHIVE where archive_type_id in (1,2) and sealed = 0", 'integer', \&archive_add);
	&updaterecord($db, \%data, 'FILM', "film_id=$film_id");
}

sub film_develop {
	# Develop a film
	my $db = shift;
	my %data;
	my $film_id = &listchoices($db, 'film', "select * from choose_film_to_develop");
	$data{'date'} = prompt(&today($db), 'What date was this film processed?', 'date');
	$data{'developer_id'} = &listchoices($db, 'developer', "select developer_id as id, name as opt from DEVELOPER where for_film=1", 'integer', \&developer_add);
	$data{'directory'} = prompt('', 'What directory are these scans in?', 'text');
	$data{'photographer_id'} = &listchoices($db, 'photographer', "select person_id as id, name as opt from PERSON", 'integer', \&person_add);
	$data{'dev_uses'} = prompt('', 'How many previous uses has the developer had?', 'integer');
	$data{'dev_time'} = prompt('', 'How long was the film developed for?', 'hh:mm:ss');
	$data{'dev_temp'} = prompt('', 'What temperature was the developer?', 'decimal');
	$data{'dev_n'} = prompt(0, 'What push/pull was used?', 'integer');
	$data{'development_notes'} = prompt('', 'Any other development notes', 'text');
	$data{'processed_by'} = prompt('', 'Who developed the film?', 'text');
	&updaterecord($db, \%data, 'FILM', "film_id=$film_id");
}

sub film_tag {
	# Write EXIF tags to a film
	my $db = shift;
	my $film_id = prompt('', 'Which film do you want to write EXIF tags to?', 'integer');
	if ($film_id eq '') {
		prompt('no', 'This will write EXIF tags to ALL scans in the database. Are you sure?', 'boolean') or die "Aborted!\n";
	}
	&tag($db, $film_id);
}

sub film_locate {
	my $db = shift;
	my $film_id = prompt('', 'Which film do you want to locate?', 'integer');

	if (my $archiveid = &lookupval($db, "select archive_id from FILM where film_id=$film_id")) {
		my $archive = &lookupval($db, "select concat(name, ' (', location, ')') as archive from ARCHIVE where archive_id = $archiveid");
		print "Film #${film_id} is in $archive\n";
	} else {
		print "The location of film #${film_id} is unknown\n";
	}
	exit;
}

sub camera_add {
	# Add a new camera
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'model'} = prompt('', 'What model is the camera?', 'text');
	$data{'fixed_mount'} = prompt('', 'Does this camera have a fixed lens?', 'boolean');
	if ($data{'fixed_mount'} == 1) {
		# Get info about lens
		print "Please enter some information about the lens\n";
		$data{'lens_id'} = &lens_add($db);
	} else {
		$data{'mount_id'} = &listchoices($db, 'mount', "select mount_id as id, mount as opt from MOUNT where purpose='Camera'", 'integer', \&mount_add);
	}
	$data{'format_id'} = &listchoices($db, 'format', "select format_id as id, format as opt from FORMAT", 'integer', \&format_add);
	$data{'focus_type_id'} = &listchoices($db, 'focus type', "select focus_type_id as id, focus_type as opt from FOCUS_TYPE", 'integer', \&focustype_add);
	$data{'metering'} = prompt('', 'Does this camera have metering?', 'boolean');
	if ($data{'metering'} == 1) {
		$data{'coupled_metering'} = prompt('', 'Is the metering coupled?', 'boolean');
		$data{'metering_mode_id'} = &listchoices($db, 'metering mode', "select metering_mode_id as id, metering_mode as opt from METERING_MODE");
		$data{'metering_type_id'} = &listchoices($db, 'metering type', "select metering_type_id as id, metering as opt from METERING_TYPE", 'integer', \&meteringtype_add);
		$data{'meter_min_ev'} = prompt('', 'What\'s the lowest EV the meter can handle?', 'integer');
		$data{'meter_max_ev'} = prompt('', 'What\'s the highest EV the meter can handle?', 'integer');
	}
	$data{'body_type_id'} = &listchoices($db, 'body type', "select body_type_id as id, body_type as opt from BODY_TYPE", \&camera_addbodytype);
	$data{'weight'} = prompt('', 'What does it weigh? (g)', 'integer');
	$data{'acquired'} = prompt(&today($db), 'When was it acquired?', 'date');
	$data{'cost'} = prompt('', 'What did the camera cost?', 'decimal');
	$data{'introduced'} = prompt('', 'What year was the camera introduced?', 'integer');
	$data{'discontinued'} = prompt('', 'What year was the camera discontinued?', 'integer');
	$data{'serial'} = prompt('', 'What is the camera\'s serial number?', 'text');
	$data{'datecode'} = prompt('', 'What is the camera\'s datecode?', 'text');
	$data{'manufactured'} = prompt('', 'When was the camera manufactured?', 'integer');
	$data{'own'} = prompt('yes', 'Do you own this camera?', 'boolean');
	$data{'negative_size_id'} = &listchoices($db, 'negative size', "select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE", 'integer', \&negativesize_add);
	$data{'shutter_type_id'} = &listchoices($db, 'shutter type', "select shutter_type_id as id, shutter_type as opt from SHUTTER_TYPE", 'integer', \&shuttertype_add);
	$data{'shutter_model'} = prompt('', 'What is the shutter model?', 'text');
	$data{'cable_release'} = prompt('', 'Does this camera have a cable release?', 'boolean');
	$data{'viewfinder_coverage'} = prompt('', 'What is the viewfinder coverage?', 'integer');
	$data{'power_drive'} = prompt('', 'Does this camera have power drive?', 'boolean');
	if ($data{'power_drive'} == 1) {
		$data{'continuous_fps'} = prompt('How many frames per second can this camera manage?', 'decimal');
	}
	$data{'video'} = prompt('no', 'Does this camera have a video/movie function?', 'boolean');
	$data{'digital'} = prompt('no', 'Is this a digital camera?', 'boolean');
	$data{'battery_qty'} = prompt('', 'How many batteries does this camera take?', 'integer');
	if ($data{'battery_qty'} > 0) {
		$data{'battery_type'} = &listchoices($db, 'battery type', "select * from choose_battery", \&battery_add);
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
		$data{'flash_metering'} = &listchoices($db, 'flash protocol', "select * from FLASH_PROTOCOL", 'integer', \&flashprotocol_add);
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

	if (prompt('yes', 'Add accessory compatibility for this camera?', 'boolean')) {
		while (1) {
			my %compatdata;
			$compatdata{'accessory_id'} = &listchoices($db, 'select * from choose_accessory', 'integer');
			$compatdata{'camera_id'} = $cameraid;
			&newrecord($db, \%compatdata, 'ACCESSORY_COMPAT');
			if (!prompt('yes', 'Add more accessory compatibility info?', 'boolean')) {
				last;
			}
		}
	}
	return $cameraid;
}

sub camera_displaylens {
	my $db = shift;
	my %data;
	$data{'camera_id'} = &listchoices($db, 'camera', "select camera_id as id, concat( manufacturer, ' ',model) as opt from CAMERA, MANUFACTURER where mount_id is not null and own=1 and CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id and camera_id not in (select camera_id from DISPLAYLENS)");
	my $mount = &lookupval($db, "select mount_id from CAMERA where camera_id=$data{'camera_id'}");
	$data{'lens_id'} = &listchoices($db, 'lens', "select lens_id as id, concat(manufacturer, ' ', model) as opt from LENS, MANUFACTURER where mount_id=$mount and LENS.manufacturer_id=MANUFACTURER.manufacturer_id and own=1 and lens_id not in (select lens_id from DISPLAYLENS)");
	my $displaylensid = &newrecord($db, \%data, 'DISPLAYLENS');
	return $displaylensid;
}

sub camera_sell {
	my $db = shift;
	my %data;
	my $cameraid = &listchoices($db, 'camera', "select camera_id as id, concat( manufacturer, ' ',model) as opt from CAMERA, MANUFACTURER where own=1 and CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id order by opt");
	$data{'own'} = 0;
	$data{'lost'} = prompt(&today($db), 'What date was this camera sold?', 'date');
	$data{'lost_price'} = prompt('', 'How much did this camera sell for?', 'decimal');
	&updaterecord($db, \%data, 'CAMERA', "camera_id=$cameraid");
	if (&lookupval($db, "select fixed_mount from CAMERA where camera_id=$cameraid")) {
		my $lensid = &lookupval($db, "select lens_id from CAMERA where camera_id=$cameraid");
		if ($lensid) {
			my %lensdata;
			$lensdata{'own'} = 0;
			$lensdata{'lost'} = $data{'lost'};
			$lensdata{'lost_price'} = 0;
			&updaterecord($db, \%lensdata, 'LENS', "lens_id=$lensid");
		}
	}

}

sub camera_repair {
	my $db = shift;
	my %data;
	$data{'camera_id'} = &listchoices($db, 'camera', "select camera_id as id, concat( manufacturer, ' ',model) as opt from CAMERA, MANUFACTURER where own=1 and CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id order by opt");
	$data{'date'} = prompt(&today($db), 'What date was this camera repaired?', 'date');
	$data{'summary'} = prompt('', 'Short summary of repair', 'text');
	$data{'description'} = prompt('', 'Longer description of repair', 'text');
	my $repair_id = &newrecord($db, \%data, 'REPAIR');
	return $repair_id;
}

sub camera_stats {
	my $db = shift;
	my $camera_id = &listchoices($db, 'camera', "select camera_id as id, concat( manufacturer, ' ',model) as opt from CAMERA, MANUFACTURER where own=1 and CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id order by opt");
	my $camera = &lookupval($db, "select concat( manufacturer, ' ',model) as opt from CAMERA, MANUFACTURER where CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id and camera_id=$camera_id");
	print "\tShowing statistics for $camera\n";
	my $total_shots_with_cam = &lookupval($db, "select count(*) from NEGATIVE, FILM where NEGATIVE.film_id=FILM.film_id and camera_id=$camera_id");
	my $total_shots = &lookupval($db, "select count(*) from NEGATIVE");
	if ($total_shots > 0) {
		my $percentage = round(100 * $total_shots_with_cam / $total_shots);
		print "\tThis camera has been used to take $total_shots_with_cam frames, which is ${percentage}% of the frames in your collection\n";
	}
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
	$data{'filter_id'} = &listchoices($db, 'filter', "select * from choose_filter", 'integer', \&filter_add);
	$data{'teleconverter_id'} = &listchoices($db, 'teleconverter', "select teleconverter_id as id, concat(manufacturer, ' ', T.model, ' (', factor, 'x)') as opt from TELECONVERTER as T, CAMERA as C, FILM as F, MANUFACTURER as M where C.mount_id=T.mount_id and F.camera_id=C.camera_id and M.manufacturer_id=T.manufacturer_id and film_id=$data{'film_id'}", 'integer', \&teleconverter_add);
	$data{'notes'} = prompt('', 'Extra notes', 'text');
	$data{'mount_adapter_id'} = &listchoices($db, 'mount adapter', "select mount_adapter_id as id, mount as opt from MOUNT_ADAPTER as MA, CAMERA as C, FILM as F, MOUNT as M where C.mount_id=MA.camera_mount and F.camera_id=C.camera_id and M.mount_id=MA.lens_mount and film_id=$data{'film_id'}");
	$data{'focal_length'} = prompt(&lookupval($db, "select min_focal_length from LENS where lens_id=$data{'lens_id'}"), 'Focal length', 'integer');
	$data{'latitude'} = prompt('', 'Latitude', 'decimal');
	$data{'longitude'} = prompt('', 'Longitude', 'decimal');
	$data{'flash'} = prompt('no', 'Was flash used?', 'boolean');
	$data{'metering_mode'} = &listchoices($db, 'metering mode', "select metering_mode_id as id, metering_mode as opt from METERING_MODE");
	$data{'exposure_program'} = &listchoices($db, 'exposure program', "select exposure_program_id as id, exposure_program as opt from EXPOSURE_PROGRAM");
	$data{'photographer_id'} = &listchoices($db, 'photographer', "select person_id as id, name as opt from PERSON", 'integer', \&person_add);
	my $negativeid = &newrecord($db, \%data, 'NEGATIVE');
	return $negativeid;
}

sub negative_bulkadd {
	my $db = shift;
	# Add lots of negatives to a film, maybe asks if they were all shot with the same lens
	my %data;
	$data{'film_id'} = prompt('', 'Bulk add negatives to which film?', 'integer');
	my $num = prompt('', 'How many frames to add?', 'integer');
	if (prompt('no', "Add any other attributes to all $num negatives?", 'boolean')) {
		$data{'description'} = prompt('', 'Caption', 'text');
		$data{'date'} = prompt(&today($db), 'What date was this negative taken?', 'date');
		$data{'lens_id'} = &listchoices($db, 'lens', "select LENS.lens_id as id, LENS.model as opt from FILM, CAMERA, LENS where FILM.camera_id=CAMERA.camera_id and CAMERA.mount_id=LENS.mount_id and FILM.film_id=$data{'film_id'}");
		$data{'shutter_speed'} = prompt('', 'Shutter speed', 'text');
		$data{'aperture'} = prompt('', 'Aperture', 'decimal');
		$data{'filter_id'} = &listchoices($db, 'filter', "select * from choose_filter", 'integer', \&filter_add);
		$data{'teleconverter_id'} = &listchoices($db, 'teleconverter', "select teleconverter_id as id, concat(manufacturer, ' ', T.model, ' (', factor, 'x)') as opt from TELECONVERTER as T, CAMERA as C, FILM as F, MANUFACTURER as M where C.mount_id=T.mount_id and F.camera_id=C.camera_id and M.manufacturer_id=T.manufacturer_id and film_id=$data{'film_id'}", 'integer', \&teleconverter_add);
		$data{'notes'} = prompt('', 'Extra notes', 'text');
		$data{'mount_adapter_id'} = &listchoices($db, 'mount adapter', "select mount_adapter_id as id, mount as opt from MOUNT_ADAPTER as MA, CAMERA as C, FILM as F, MOUNT as M where C.mount_id=MA.camera_mount and F.camera_id=C.camera_id and M.mount_id=MA.lens_mount and film_id=$data{'film_id'}");
		$data{'focal_length'} = prompt(&lookupval($db, "select min_focal_length from LENS where lens_id=$data{'lens_id'}"), 'Focal length', 'integer');
		$data{'latitude'} = prompt('', 'Latitude', 'decimal');
		$data{'longitude'} = prompt('', 'Longitude', 'decimal');
		$data{'flash'} = prompt('no', 'Was flash used?', 'boolean');
		$data{'metering_mode'} = &listchoices($db, 'metering mode', "select metering_mode_id as id, metering_mode as opt from METERING_MODE");
		$data{'exposure_program'} = &listchoices($db, 'exposure program', "select exposure_program_id as id, exposure_program as opt from EXPOSURE_PROGRAM");
	}

	# Delete empty strings from data hash
	foreach (keys %data) {
		delete $data{$_} unless (defined $data{$_} and $data{$_} ne '');
	}

	# Build query
	my $sql = SQL::Abstract->new;

	# Final confirmation
	prompt('yes', 'Proceed?', 'boolean') or die "Aborted!\n";

	# Execute query
	for my $i (1..$num) {
		# Now inside the loop, add an incremented frame number for each neg
		$data{'frame'} = $i;

		# Generate an abstract object for this negative
		my($stmt, @bind) = $sql->insert('NEGATIVE', \%data);

		# Execute query
		my $sth = $db->prepare($stmt);
		$sth->execute(@bind);
	}

	print "Inserted $num negatives into film #$data{'film_id'}\n";
}

sub negative_stats {
	my $db = shift;
	my $film_id = prompt('', 'Film ID to print from', 'integer');
	my $frame = &listchoices($db, 'Frame to print from', "select frame as id, description as opt from NEGATIVE where film_id=$film_id", 'text');
	my $neg_id = &lookupval($db, "select lookupneg('$film_id', '$frame')");
	my $noprints = &lookupval($db, "select count(*) from PRINT where negative_id=$neg_id");
	print "\tThis negative has been printed $noprints times\n";
}

sub lens_add {
	my $db = shift;
	my %data;
	$data{'fixed_mount'} = prompt('no', 'Does this lens have a fixed mount?', 'boolean');
	if ($data{'fixed_mount'} == 0) {
		$data{'mount_id'} = &listchoices($db, 'mount', "select mount_id as id, mount as opt from MOUNT", 'integer', \&mount_add);
	}
	$data{'zoom'} = prompt('no', 'Is this a zoom lens?', 'boolean');
	if ($data{'zoom'} == 0) {
		$data{'min_focal_length'} = prompt('', 'What is the focal length?', 'integer');
		$data{'max_focal_length'} = $data{'min_focal_length'};
	} else {
		$data{'min_focal_length'} = prompt('', 'What is the minimum focal length?', 'integer');
		$data{'max_focal_length'} = prompt('', 'What is the maximum focal length?', 'integer');
	}
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
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
	$data{'negative_size_id'} = &listchoices($db, 'negative size', "select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE", \&negativesize_add);
	$data{'acquired'} = prompt(&today($db), 'When was this lens acquired?', 'date');
	$data{'cost'} = prompt('', 'How much did this lens cost?', 'decimal');
	$data{'notes'} = prompt('', 'Notes', 'text');
	$data{'own'} = prompt('yes', 'Do you own this lens?', 'boolean');
	$data{'source'} = prompt('', 'Where was this lens sourced from?', 'text');
	$data{'coating'} = prompt('', 'What coating does this lens have?', 'text');
	$data{'hood'} = prompt('', 'What is the model number of the suitable hood for this lens?', 'text');
	$data{'exif_lenstype'} = prompt('', 'EXIF lens type code', 'text');
	$data{'rectilinear'} = prompt('yes', 'Is this a rectilinear lens?', 'boolean');
	$data{'length'} = prompt('', 'How long is this lens? (mm)', 'integer');
	$data{'diameter'} = prompt('', 'How wide is this lens? (mm)', 'integer');
	$data{'condition_id'} = &listchoices($db, 'condition', "select condition_id as id, name as opt from `CONDITION`");
	$data{'image_circle'} = prompt('', 'What is the diameter of the image circle?', 'integer');
	$data{'formula'} = prompt('', 'Does this lens have a named optical formula?', 'text');
	$data{'shutter_model'} = prompt('', 'What shutter does this lens incorporate?', 'text');
	my $lensid = &newrecord($db, \%data, 'LENS');

	if (prompt('yes', 'Add accessory compatibility for this lens?', 'boolean')) {
		while (1) {
			my %compatdata;
			$compatdata{'accessory_id'} = &listchoices($db, 'select * from choose_accessory', 'integer');
			$compatdata{'lens_id'} = $lensid;
			&newrecord($db, \%compatdata, 'ACCESSORY_COMPAT');
			if (!prompt('yes', 'Add more accessory compatibility info?', 'boolean')) {
				last;
			}
		}
	}
	return $lensid;
}

sub lens_sell {
	my $db = shift;
	my %data;
	my $lensid = &listchoices($db, 'camera', "select lens_id as id, concat( manufacturer, ' ',model) as opt from LENS, MANUFACTURER where own=1 and fixed_mount=0 and LENS.manufacturer_id=MANUFACTURER.manufacturer_id order by opt");
	$data{'own'} = 0;
	$data{'lost'} = prompt(&today($db), 'What date was this lens sold?', 'date');
	$data{'lost_price'} = prompt('', 'How much did this lens sell for?', 'decimal');
	&updaterecord($db, \%data, 'LENS', "lens_id=$lensid");
}

sub lens_repair {
	my $db = shift;
	my %data;
	$data{'lens_id'} = &listchoices($db, 'lens', "select lens_id as id, concat( manufacturer, ' ',model) as opt from LENS, MANUFACTURER where own=1 and fixed_mount=0 and LENS.manufacturer_id=MANUFACTURER.manufacturer_id order by opt");
	$data{'date'} = prompt(&today($db), 'What date was this lens repaired?', 'date');
	$data{'summary'} = prompt('', 'Short summary of repair', 'text');
	$data{'description'} = prompt('', 'Longer description of repair', 'text');
	my $repair_id = &newrecord($db, \%data, 'REPAIR');
	return $repair_id;
}

sub lens_stats {
	my $db = shift;
	my $lens_id = &listchoices($db, 'lens', "select lens_id as id, concat( manufacturer, ' ',model) as opt from LENS, MANUFACTURER where own=1 and fixed_mount=0 and LENS.manufacturer_id=MANUFACTURER.manufacturer_id order by opt");
	my $lens = &lookupval($db, "select concat( manufacturer, ' ',model) as opt from LENS, MANUFACTURER where LENS.manufacturer_id=MANUFACTURER.manufacturer_id and lens_id=$lens_id");
	print "\tShowing statistics for $lens\n";
	my $total_shots_with_lens = &lookupval($db, "select count(*) from NEGATIVE where lens_id=$lens_id");
	my $total_shots = &lookupval($db, "select count(*) from NEGATIVE");
	if ($total_shots > 0) {
		my $percentage = round(100 * $total_shots_with_lens / $total_shots);
		print "\tThis lens has been used to take $total_shots_with_lens frames, which is ${percentage}% of the frames in your collection\n";
	}
	my $maxaperture = &lookupval($db, "select max_aperture from LENS where lens_id=$lens_id");
	my $modeaperture = &lookupval($db, "select aperture from (select aperture, count(aperture) from NEGATIVE where lens_id=$lens_id and aperture is not null group by aperture order by count(aperture) desc limit 1) as t1");
	print "\tThis lens has a maximum aperture of f/$maxaperture but you most commonly use it at f/$modeaperture\n";
	if (&lookupval($db, "select zoom from LENS where lens_id=$lens_id")) {
		my $minf = &lookupval($db, "select min_focal_length from LENS where lens_id=$lens_id");
		my $maxf = &lookupval($db, "select max_focal_length from LENS where lens_id=$lens_id");
		my $meanf = &lookupval($db, "select avg(focal_length) from NEGATIVE where lens_id=$lens_id");
		print "\tThis is a zoom lens with a range of ${minf}-${maxf}mm, but the average focal length you used is ${meanf}mm\n";
	}
}

sub print_add {
	my $db = shift;
	my %data;
	my $neg_id;
	my $todo_id = &listchoices($db, 'print from the order queue', 'SELECT * FROM photography.choose_todo');
	if ($todo_id) {
		$neg_id = &lookupval($db, "select negative_id from TO_PRINT where id=$todo_id");
	} else {
		my $film_id = prompt('', 'Film ID to print from', 'integer');
		my $frame = &listchoices($db, 'Frame to print from', "select frame as id, description as opt from NEGATIVE where film_id=$film_id", 'text');
		$neg_id = &lookupval($db, "select lookupneg('$film_id', '$frame')");
	}
	$data{'negative_id'} = prompt($neg_id, 'Negative ID to print from', 'integer');
	$data{'date'} = prompt(&today($db), 'Date that the print was made', 'date');
	$data{'paper_stock_id'} = &listchoices($db, 'paper stock', "select * from choose_paper", 'integer', \&paperstock_add);
	$data{'height'} = prompt('', 'Height of the print (inches)', 'integer');
	$data{'width'} = prompt('', 'Width of the print (inches)', 'integer');
	$data{'aperture'} = prompt('', 'Aperture used on enlarging lens', 'decimal');
	$data{'exposure_time'} = prompt('', 'Exposure time (s)', 'integer');
	$data{'filtration_grade'} = prompt('', 'Filtration grade', 'decimal');
	$data{'development_time'} = prompt('', 'Development time (s)', 'integer');
	$data{'enlarger_id'} = &listchoices($db, 'enlarger', "select * from choose_enlarger");
	$data{'lens_id'} = &listchoices($db, 'enlarger lens', "select * from choose_enlarger_lens");
	$data{'developer_id'} = &listchoices($db, 'developer', "select developer_id as id, name as opt from DEVELOPER where for_paper=1", 'integer', \&developer_add);
	$data{'fine'} = prompt('', 'Is this a fine print?', 'boolean');
	$data{'notes'} = prompt('', 'Notes', 'text');
	$data{'printer_id'} = &listchoices($db, 'printer', "select person_id as id, name as opt from PERSON", 'integer', \&person_add);
	my $printid = &newrecord($db, \%data, 'PRINT');

	# Mark is as complete in the todo list
	if ($todo_id) {
		my %data2;
		$data2{'printed'} = 1;
		$data2{'print_id'} = $printid;
		&updaterecord($db, \%data2, 'TO_PRINT', "id=$todo_id");
	}

	return $printid;
}

sub print_fulfil {
	my $db = shift;
	my %data;
	my $todo_id = &listchoices($db, 'print from the queue', 'SELECT * FROM photography.choose_todo');
	$data{'printed'} = prompt('yes', 'Is this print order now fulfilled?', 'boolean');
	$data{'print_id'} = prompt('', 'Which print fulfilled this order?', 'integer');
	&updaterecord($db, \%data, 'TO_PRINT', "id=$todo_id");
}

sub print_tone {
	my $db = shift;
	my %data;
	my $print_id = prompt('', 'Which print did you tone?', 'integer');
	$data{'bleach_time'} = prompt('00:00:00', 'How long did you bleach for? (HH:MM:SS)', 'hh:mm:ss');
	$data{'toner_id'} = &listchoices($db, 'toner', "select toner_id as id, toner as opt from TONER", 'integer', \&toner_add);
	my $dilution1 = &lookupval($db, "select stock_dilution from TONER where toner_id=$data{'toner_id'}");
	$data{'toner_dilution'} = prompt($dilution1, 'What was the dilution of the first toner?', 'text');
	$data{'toner_time'} = prompt('', 'How long did you tone for? (HH:MM:SS)', 'hh:mm:ss');
	if (prompt('no', 'Did you use a second toner?', 'boolean') == 1) {
		$data{'2nd_toner_id'} = &listchoices($db, 'toner', "select toner_id as id, toner as opt from TONER", 'integer', \&toner_add);
		my $dilution2 = &lookupval($db, "select stock_dilution from TONER where toner_id=$data{'2nd_toner_id'}");
		$data{'2nd_toner_dilution'} = prompt($dilution2, 'What was the dilution of the second toner?', 'text');
		$data{'2nd_toner_time'} = prompt('', 'How long did you tone for? (HH:MM:SS)', 'hh:mm:ss');
	}
	&updaterecord($db, \%data, 'PRINT', "print_id=$print_id");
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

sub print_order {
	my $db = shift;
	my %data;
	my $film_id = prompt('', 'Film ID to print from', 'integer');
	my $frame = &listchoices($db, 'Frame to print from', "select frame as id, description as opt from NEGATIVE where film_id=$film_id", 'text');
	my $neg_id = &lookupval($db, "select lookupneg('$film_id', '$frame')");
	$data{'negative_id'} = prompt($neg_id, 'Negative ID to print from', 'integer');
	$data{'height'} = prompt('', 'Height of the print (inches)', 'integer');
	$data{'width'} = prompt('', 'Width of the print (inches)', 'integer');
	$data{'recipient'} = prompt('', 'Who is the print for?', 'text');
	$data{'added'} = prompt(&today($db), 'Date that this order was placed', 'date');
	my $orderid = &newrecord($db, \%data, 'TO_PRINT');
}

sub print_archive {
	# Archive a print for storage
	my $db = shift;
	my %data;
	my $print_id = prompt('', 'Which print did you archive?', 'integer');
	$data{'archive_id'} = &listchoices($db, 'archive', "select archive_id as id, name as opt from ARCHIVE where archive_type_id = 3 and sealed = 0", 'integer', \&archive_add);
	$data{'own'} = 1;
	$data{'location'} = 'Archive',
	&updaterecord($db, \%data, 'PRINT', "print_id=$print_id");
}

sub print_locate {
	my $db = shift;
	my $print_id = prompt('', 'Which print do you want to locate?', 'integer');

	if (my $archiveid = &lookupval($db, "select archive_id from PRINT where print_id=$print_id")) {
		my $archive = &lookupval($db, "select concat(name, ' (', location, ')') as archive from ARCHIVE where archive_id = $archiveid");
		print "Print #${print_id} is in $archive\n";
	} elsif (my $location = &lookupval($db, "select location from PRINT where print_id=$print_id")) {
		if (my $own = &lookupval($db, "select own from PRINT where print_id=$print_id")) {
			print "Print #${print_id} is in the collection. Location: $location\n";
		} else {
			print "Print #${print_id} is not in the collection. Location: $location\n";
		}
	} else {
		print "The location of print #${print_id} is unknown\n";
	}
	exit;
}

sub paperstock_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'name'} = prompt('', 'What model is the paper?', 'text');
	$data{'resin_coated'} = prompt('', 'Is this paper resin-coated?', 'boolean');
	$data{'tonable'} = prompt('', 'Is this paper tonable?', 'boolean');
	$data{'colour'} = prompt('', 'Is this a colour paper?', 'boolean');
	$data{'finish'} = prompt('', 'What surface finish does this paper have?', 'text');
	my $paperstockid = &newrecord($db, \%data, 'PAPER_STOCK');
	return $paperstockid;
}

sub developer_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'name'} = prompt('', 'What model is the developer?', 'text');
	$data{'for_paper'} = prompt('', 'Is this developer suitable for paper?', 'boolean');
	$data{'for_film'} = prompt('', 'Is this developer suitable for film?', 'boolean');
	$data{'chemistry'} = prompt('', 'What type of chemistry is this developer based on?', 'text');
	my $developerid = &newrecord($db, \%data, 'DEVELOPER');
	return $developerid;
}

sub mount_add {
	my $db = shift;
	my %data;
	$data{'mount'} = prompt('', 'What is the name of this lens mount?', 'text');
	$data{'fixed'} = prompt('no', 'Is this a fixed mount?', 'boolean');
	$data{'shutter_in_lens'} = prompt('no', 'Does this mount contain the shutter in the lens?', 'boolean');
	$data{'type'} = prompt('', 'What type of mounting does this mount use? (e.g. bayonet, screw, etc)', 'text');
	$data{'purpose'} = prompt('camera', 'What is the intended purpose of this mount? (e.g. camera, enlarger, projector, etc)', 'text');
	$data{'digital_only'} = prompt('no', 'Is this a digital-only mount?', 'boolean');
	$data{'notes'} = prompt('', 'Notes about this mount', 'text');
	my $mountid = &newrecord($db, \%data, 'MOUNT');
	return $mountid;
}

sub mount_view {
	my $db = shift;
	my $mountid = &listchoices($db, 'mount', 'select mount_id as id, mount as opt from MOUNT');
	my $mountname = lookupval($db, "select mount from MOUNT where mount_id = ${mountid}");
	print "Showing data for $mountname mount\n";
	&printlist($db, "cameras with $mountname mount", "select C.camera_id as id, concat(M.manufacturer, ' ', C.model) as opt from CAMERA as C, MANUFACTURER as M where C.manufacturer_id=M.manufacturer_id and own=1 and mount_id=$mountid order by opt");
	&printlist($db, "lenses with $mountname mount", "select lens_id as id, concat(manufacturer, ' ', model) as opt from LENS, MANUFACTURER where mount_id=$mountid and LENS.manufacturer_id=MANUFACTURER.manufacturer_id and own=1 order by opt");
}

sub toner_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'toner'} = prompt('', 'What is the name of this toner?', 'text');
	$data{'formulation'} = prompt('', 'What is the chemical formulation of this toner?', 'text');
	$data{'stock_dilution'} = prompt('', 'What is the stock dilution of this toner?', 'text');
	my $tonerid = &newrecord($db, \%data, 'TONER');
	return $tonerid;
}

sub filmstock_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'name'} = prompt('', 'What is the name of this filmstock?', 'text');
	$data{'iso'} = prompt('', 'What is the box ISO/ASA speed of this filmstock?');
	$data{'colour'} = prompt('', 'Is this a colour film?', 'boolean');
	if ($data{'colour'} == 1) {
		$data{'panchromatic'} = 1;
	} else {
		$data{'panchromatic'} = prompt('yes', 'Is this a panchromatic film?', 'boolean');
	}
	$data{'process_id'} = &listchoices($db, 'process', 'SELECT process_id as id, name as opt FROM photography.PROCESS', 'integer', \&process_add);
	my $filmstockid = &newrecord($db, \%data, 'FILMSTOCK');
	return $filmstockid;
}

sub teleconverter_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'model'} = prompt('', 'What is the model of this teleconverter?', 'text');
	$data{'factor'} = prompt('', 'What is the magnification factor of this teleconverter?', 'decimal');
	$data{'mount_id'} = &listchoices($db, 'mount', "select mount_id as id, mount as opt from MOUNT where purpose='Camera'", 'integer', \&mount_add);
	$data{'elements'} = prompt('', 'How many elements does this teleconverter have?');
	$data{'groups'} = prompt('', 'How many groups are the elements arranged in?');
	$data{'multicoated'} = prompt('', 'Is this teleconverter multicoated?', 'boolean');
	my $teleconverterid = &newrecord($db, \%data, 'TELECONVERTER');
	return $teleconverterid;
}

sub filter_add {
	my $db = shift;
	my %data;
	$data{'type'} = prompt('', 'What type of filter is this?', 'text');
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'attenuation'} = prompt('', 'What attenutation (in stops) does this filter have?', 'decimal');
	$data{'thread'} = prompt('', 'What diameter mounting thread does this filter have?', 'decimal');
	$data{'qty'} = prompt(1, 'How many of these filters do you have?');
	my $filterid = &newrecord($db, \%data, 'FILTER');
	return $filterid;
}

sub process_add {
	my $db = shift;
	my %data;
	$data{'name'} = prompt('', 'What is the name of this film process?', 'text');
	$data{'colour'} = prompt('', 'Is this a colour process?', 'boolean');
	$data{'positive'} = prompt('', 'Is this a reversal process?', 'boolean');
	my $processid = &newrecord($db, \%data, 'PROCESS');
	return $processid;
}

sub filter_adapt {
	my $db = shift;
	my %data;
	$data{'camera_thread'} = prompt('', 'What diameter thread faces the camera on this filter adapter?', 'decimal');
	$data{'filter_thread'} = prompt('', 'What diameter thread faces the filter on this filter adapter?', 'decimal');
	my $filteradapterid = &newrecord($db, \%data, 'FILTER_ADAPTER');
	return $filteradapterid;
}

sub manufacturer_add {
	my $db = shift;
	my %data;
	$data{'manufacturer'} = prompt('', 'What is the name of the manufacturer?', 'text');
	$data{'country'} = prompt('', 'What country is the manufacturer based in?', 'text');
	$data{'city'} = prompt('', 'What city is the manufacturer based in?', 'text');
	$data{'url'} = prompt('', 'What is the main website of the manufacturer?', 'text');
	$data{'founded'} = prompt('', 'When was the manufacturer founded?', 'integer');
	$data{'dissolved'} = prompt('', 'When was the manufacturer dissolved?', 'integer');
	my $manufacturerid = &newrecord($db, \%data, 'MANUFACTURER');
	return $manufacturerid;
}

sub accessory_add {
	my $db = shift;
	my %data;
	$data{'accessory_type_id'} = &listchoices($db, 'accessory type', "select accessory_type_id as id, accessory_type as opt from ACCESSORY_TYPE", 'integer', \&accessory_type);
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'model'} = prompt('', 'What is the model of this accessory?', 'text');
	$data{'acquired'} = prompt(&today($db), 'When was this accessory acquired?', 'date');
	$data{'cost'} = prompt('', 'What did this accessory cost?', 'decimal');
	my $accessoryid = &newrecord($db, \%data, 'ACCESSORY');

	if (prompt('yes', 'Add camera compatibility info for this accessory?', 'boolean')) {
		while (1) {
			my %compatdata;
			$compatdata{'accessory_id'} = $accessoryid;
			$compatdata{'camera_id'} = &listchoices($db, 'camera', "select camera_id as id, concat( manufacturer, ' ',model) as opt from CAMERA, MANUFACTURER where own=1 and CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id order by opt");
			&newrecord($db, \%compatdata, 'ACCESSORY_COMPAT');
			if (!prompt('yes', 'Add another compatible camera?', 'boolean')) {
				last;
			}
		}
	}
	if (prompt('yes', 'Add lens compatibility info for this accessory?', 'boolean')) {
		while (1) {
			my %compatdata;
			$compatdata{'accessory_id'} = $accessoryid;
			$compatdata{'lens_id'} = &listchoices($db, 'camera', "select lens_id as id, concat( manufacturer, ' ',model) as opt from LENS, MANUFACTURER where own=1 and fixed_mount=0 and LENS.manufacturer_id=MANUFACTURER.manufacturer_id order by opt");
			&newrecord($db, \%compatdata, 'ACCESSORY_COMPAT');
			if (!prompt('yes', 'Add another compatible lens?', 'boolean')) {
				last;
			}
		}
	}
	return $accessoryid;
}

sub accessory_type {
	my $db = shift;
	my %data;
	$data{'accessory_type'} = prompt('', 'What type of accessory do you want to add?', 'text');
	my $accessorytypeid = &newrecord($db, \%data, 'ACCESSORY_TYPE');
	return $accessorytypeid;
}

sub enlarger_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'enlarger'} = prompt('', 'What is the model of this enlarger?', 'text');
	$data{'negative_size_id'} = &listchoices($db, 'negative size', "select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE", \&negativesize_add);
	$data{'introduced'} = prompt('', 'What year was this enlarger introduced?', 'integer');
	$data{'discontinued'} = prompt('', 'What year was this enlarger discontinued?', 'integer');
	$data{'acquired'} = prompt(&today($db), 'Purchase date', 'date');
	$data{'cost'} = prompt('', 'Purchase price', 'decimal');
	my $enlarger_id = &newrecord($db, \%data, 'ENLARGER');
	return $enlarger_id;
}

sub enlarger_sell {
	my $db = shift;
	my %data;
	my $enlarger_id = &listchoices($db, 'enlarger', "select * from choose_enlarger");
	$data{'lost'} = prompt(&today($db), 'What date was this enlarger sold?', 'date');
	$data{'lost_price'} = prompt('', 'How much did this enlarger sell for?', 'decimal');
	&updaterecord($db, \%data, 'ENLARGER', "enlarger_id=$enlarger_id");
}

sub flash_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'model'} = prompt('', 'What is the model of this flash?', 'text');
	$data{'guide_number'} = prompt('', 'What is the guide number of this flash?', 'integer');
	$data{'gn_info'} = prompt('ISO 100', 'What are the conditions of the guide number?', 'text');
	$data{'battery_powered'} = prompt('yes', 'Is this flash battery-powered?', 'boolean');
	if ($data{'battery_powered'} == 1) {
		$data{'battery_type_id'} = &listchoices($db, 'battery type', "select * from choose_battery", \&battery_add);
		$data{'battery_qty'} = prompt('', 'How many batteries does this flash need?', 'integer');
	}
	$data{'pc_sync'} = prompt('yes', 'Does this flash have a PC sync socket?', 'boolean');
	$data{'hot_shoe'} = prompt('yes', 'Does this flash have a hot shoe connector?', 'boolean');
	$data{'light_stand'} = prompt('yes', 'Can this flash be fitted onto a light stand?', 'boolean');
	$data{'manual_control'} = prompt('yes', 'Does this flash have manual power control?', 'boolean');
	$data{'swivel_head'} = prompt('yes', 'Does this flash have a left/right swivel head?', 'boolean');
	$data{'tilt_head'} = prompt('yes', 'Does this flash have an up/down tilt head?', 'boolean');
	$data{'zoom'} = prompt('yes', 'Does this flash have a zoom head?', 'boolean');
	$data{'dslr_safe'} = prompt('yes', 'Is this flash safe to use on a DSLR?', 'boolean');
	$data{'ttl'} = prompt('yes', 'Does this flash support TTL metering?', 'boolean');
	if ($data{'ttl'} == 1) {
		$data{'flash_protocol_id'} = &listchoices($db, 'flash protocol', "SELECT flash_protocol_id as id, concat(manufacturer, ' ', name) as opt FROM FLASH_PROTOCOL, MANUFACTURER where FLASH_PROTOCOL.manufacturer_id=MANUFACTURER.manufacturer_id");
	}
	$data{'trigger_voltage'} = prompt('', 'What is the measured trigger voltage?', 'decimal');
	$data{'own'} = 1;
	$data{'acquired'} = prompt(&today($db), 'When was it acquired?', 'date');
	$data{'cost'} = prompt('', 'What did this flash cost?', 'decimal');
	my $flashid = &newrecord($db, \%data, 'FLASH');
	return $flashid;
}

sub battery_add {
	my $db = shift;
	my %data;
	$data{'battery_name'} = prompt('', 'What is the name of this battery?', 'text');
	$data{'voltage'} = prompt('', 'What is the nominal voltage of this battery?', 'decimal');
	$data{'chemistry'} = prompt('', 'What type of chemistry is this battery based on?', 'text');
	$data{'other_names'} = prompt('', 'Does this type of battery go by any other names?');
	my $batteryid = &newrecord($db, \%data, 'BATTERY');
	return $batteryid;
}

sub format_add {
	my $db = shift;
	my %data;
	$data{'format'} = prompt('', 'What is the name of this film format?', 'text');
	$data{'digital'} = prompt('no', 'Is this a digital format?', 'boolean');
	my $formatid = &newrecord($db, \%data, 'FORMAT');
	return $formatid;
}

sub negativesize_add {
	my $db = shift;
	my %data;
	$data{'negative_size'} = prompt('', 'What is the name of this negative size?', 'text');
	$data{'width'} = prompt('', 'What is the width of this negative size in mm?', 'decimal');
	$data{'height'} = prompt('', 'What is the height of this negative size in mm?', 'decimal');
	if ($data{'width'} > 0 && $data{'height'} > 0) {
		$data{'crop_factor'} = round(sqrt($data{'width'}*$data{'width'} + $data{'height'}*$data{'height'}) / sqrt(36*36 + 24*24), 2);
		$data{'area'} = $data{'width'} * $data{'height'};
		$data{'aspect_ratio'} = round($data{'width'} / $data{'height'}, 2);
	}
	my $negativesizeid = &newrecord($db, \%data, 'NEGATIVE_SIZE');
	return $negativesizeid;
}

sub mount_adapt {
	my $db = shift;
	my %data;
	$data{'lens_mount'} = &listchoices($db, 'lens-facing mount', "select mount_id as id, mount as opt from MOUNT where purpose='Camera'", 'integer', \&mount_add);
	$data{'camera_mount'} = &listchoices($db, 'camera-facing mount', "select mount_id as id, mount as opt from MOUNT where purpose='Camera'", 'integer', \&mount_add);
	$data{'has_optics'} = prompt('', 'Does this mount adapter have corrective optics?', 'boolean');
	$data{'infinity_focus'} = prompt('', 'Does this mount adapter have infinity focus?', 'boolean');
	$data{'notes'} = prompt('', 'Notes', 'text');
	my $mountadapterid = &newrecord($db, \%data, 'MOUNT_ADAPTER');
	return $mountadapterid;
}

sub lightmeter_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'model'} = prompt('', 'What is the model of this light meter?', 'text');
	$data{'metering_type'} = &listchoices($db, 'metering type', "select metering_type_id as id, metering as opt from METERING_TYPE", 'integer', \&meteringtype_add);
	$data{'reflected'} = prompt('', 'Can this meter take reflected light readings?', 'boolean');
	$data{'incident'} = prompt('', 'Can this meter take incident light readings?', 'boolean');
	$data{'spot'} = prompt('', 'Can this meter take spot readings?', 'boolean');
	$data{'flash'} = prompt('', 'Can this meter take flash readings?', 'boolean');
	$data{'min_asa'} = prompt('', 'What\'s the lowest ISO/ASA setting this meter supports?', 'integer');
	$data{'max_asa'} = prompt('', 'What\'s the highest ISO/ASA setting this meter supports?', 'integer');
	$data{'min_lv'} = prompt('', 'What\'s the lowest light value (LV) reading this meter can give?', 'integer');
	$data{'max_lv'} = prompt('', 'What\'s the highest light value (LV) reading this meter can give?', 'integer');
	my $lightmeterid = &newrecord($db, \%data, 'LIGHT_METER');
	return $lightmeterid;
}

sub camera_addbodytype {
	my $db = shift;
	my %data;
	$data{'body_type'} = prompt('', 'Enter new camera body type', 'text');
	my $bodytypeid = &newrecord($db, \%data, 'BODY_TYPE');
	return $bodytypeid;
}

sub archive_add {
	my $db = shift;
	my %data;
	$data{'archive_type_id'} = &listchoices($db, 'archive type', "select archive_type_id as id, archive_type as opt from ARCHIVE_TYPE", 'integer');
	$data{'name'} = prompt('', 'What is the name of this archive?', 'text');
	$data{'max_width'} = prompt('', 'What is the maximum width of media that this archive can accept (if applicable)?', 'text');
	$data{'max_height'} = prompt('', 'What is the maximum height of media that this archive can accept (if applicable)?', 'text');
	$data{'location'} = prompt('', 'What is the location of this archive?', 'text');
	$data{'storage'} = prompt('', 'What is the storage type of this archive? (e.g. box, folder, ringbinder, etc)', 'text');
	$data{'sealed'} = prompt('no', 'Is this archive sealed (closed to new additions)?', 'boolean');
	my $archiveid = &newrecord($db, \%data, 'ARCHIVE');
	return $archiveid;
}

sub archive_films {
	my $db = shift;
	my %data;
	my $minfilm = prompt('', 'What is the lowest film ID in the range?', 'integer');
	my $maxfilm = prompt('', 'What is the highest film ID in the range?', 'integer');
	if (($minfilm =~ m/^\d+$/) && ($maxfilm =~ m/^\d+$/)) {
		if ($maxfilm le $minfilm) {
			print "Highest film ID must be higher than lowest film ID\n";
			exit;
		}
	} else {
		print "Must provide highest and lowest film IDs\n";
		exit;
	}
	$data{'archive_id'} = &listchoices($db, 'archive', "select archive_id as id, name as opt from ARCHIVE where archive_type_id in (1,2) and sealed = 0", 'integer', \&archive_add);
	&updaterecord($db, \%data, 'FILM', "film_id >= $minfilm and film_id <= $maxfilm and archive_id is null");
}

sub archive_list {
	my $db = shift;
	my $archive_id = &listchoices($db, 'archive', "select archive_id as id, name as opt from ARCHIVE", 'integer');
	my $archive_name = &lookupval($db, "select name from ARCHIVE where archive_id=$archive_id");
	my $query = "select * from (select concat('Film #', film_id) as id, notes as opt from FILM where archive_id=$archive_id union select concat('Print #', print_id) as id, description as opt from PRINT, NEGATIVE where PRINT.negative_id=NEGATIVE.negative_id and archive_id=$archive_id) as test order by id;";
	&printlist($db, "items in archive $archive_name", $query);
}

sub archive_seal {
	my $db = shift;
	my %data;
	my $archive_id = &listchoices($db, 'archive', "select archive_id as id, name as opt from ARCHIVE where sealed = 0", 'integer');
	$data{'sealed'} = 1;
	&updaterecord($db, \%data, 'ARCHIVE', "archive_id = $archive_id");
}

sub archive_unseal {
	my $db = shift;
	my %data;
	my $archive_id = &listchoices($db, 'archive', "select archive_id as id, name as opt from ARCHIVE where sealed = 1", 'integer');
	$data{'sealed'} = 0;
	&updaterecord($db, \%data, 'ARCHIVE', "archive_id = $archive_id");
}

sub archive_move {
	my $db = shift;
	my %data;
	my $archive_id = &listchoices($db, 'archive', "select archive_id as id, name as opt from ARCHIVE", 'integer');
	my $oldlocation = &lookupval($db, "select location from ARCHIVE where archive_id = $archive_id");
	$data{'location'} = prompt($oldlocation, 'What is the new location of this archive?', 'text');
	&updaterecord($db, \%data, 'ARCHIVE', "archive_id = $archive_id");
}

sub shuttertype_add {
	my $db = shift;
	my %data;
	$data{'shutter_type'} = prompt('', 'What type of shutter do you want to add?', 'text');
	my $id = &newrecord($db, \%data, 'SHUTTER_TYPE');
	return $id;
}

sub focustype_add {
	my $db = shift;
	my %data;
	$data{'focus_type'} = prompt('', 'What type of focus system do you want to add?', 'text');
	my $id = &newrecord($db, \%data, 'FOCUS_TYPE');
	return $id;
}

sub flashprotocol_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'name'} = prompt('', 'What flash protocol do you want to add?', 'text');
	my $id = &newrecord($db, \%data, 'FLASH_PROTOCOL');
	return $id;
}

sub meteringtype_add {
	my $db = shift;
	my %data;
	$data{'metering'} = prompt('', 'What type of metering system do you want to add?', 'text');
	my $id = &newrecord($db, \%data, 'METERING_TYPE');
	return $id;
}

sub shutterspeed_add {
	my $db = shift;
	my %data;
	$data{'shutter_speed'} = prompt('', 'What shutter speed do you want to add?', 'text');
	if ($data{'shutter_speed'} =~ m/1\/(\d+)/) {
		$data{'duration'} = 1 / $1;
	} elsif ($data{'shutter_speed'} =~ m/((0\.)?\d+)/) {
		$data{'duration'} = $1;
	}
	my $id = &newrecord($db, \%data, 'SHUTTER_SPEED');
	return $id;
}

sub person_add {
	my $db = shift;
	my %data;
	$data{'name'} = prompt('', 'What is this person\'s name?', 'text');
	my $id = &newrecord($db, \%data, 'PERSON');
	return $id;
}

sub projector_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices($db, 'manufacturer', "select manufacturer_id as id, manufacturer as opt from MANUFACTURER", 'integer', \&manufacturer_add);
	$data{'model'} = prompt('', 'What is the model of this projector?', 'text');
	$data{'mount_id'} = &listchoices($db, 'mount', "select mount_id as id, mount as opt from MOUNT where purpose='Projector'", 'integer', \&mount_add);
	$data{'negative_size_id'} = &listchoices($db, 'negative size', "select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE", 'integer', \&negativesize_add);
	$data{'own'} = 1;
	$data{'cine'} = prompt('', 'Is this a cine/movie projector?', 'boolean');
	my $id = &newrecord($db, \%data, 'PROJECTOR');
	return $id;
}

sub movie_add {
	my $db = shift;
	my %data;
	$data{'title'} = prompt('', 'What is the title of this movie?', 'text');
	$data{'camera_id'} = &listchoices($db, 'camera', "select C.camera_id as id, concat(M.manufacturer, ' ', C.model) as opt from CAMERA as C, MANUFACTURER as M where C.manufacturer_id=M.manufacturer_id and own=1 and video=1 and digital=0 order by opt");
	if (&lookupval($db, "select fixed_mount from CAMERA where camera_id = $data{'camera_id'}")) {
		$data{'lens_id'} = &lookupval($db, "select lens_id from CAMERA where camera_id = $data{'camera_id'}");
	} else {
		$data{'lens_id'} = &listchoices($db, 'lens', "select lens_id as id, concat( manufacturer, ' ',model) as opt from LENS, MANUFACTURER where own=1 and fixed_mount=0 and LENS.manufacturer_id=MANUFACTURER.manufacturer_id order by opt");
	}
	$data{'format_id'} = &listchoices($db, 'format', "select format_id as id, format as opt from FORMAT", 'integer', \&format_add);
	$data{'sound'} = prompt('', 'Does this movie have sound?', 'boolean');
	$data{'fps'} = prompt('', 'What is the fraterate of this movie in fps?', 'integer');
	$data{'filmstock_id'} = &listchoices($db, 'filmstock', "select * from choose_filmstock", 'integer', \&filmstock_add);
	$data{'feet'} = prompt('', 'What is the length of this movie in feet?', 'integer');
	$data{'date_loaded'} = prompt(&today($db), 'What date was the film loaded?', 'date');
	$data{'date_shot'} = prompt(&today($db), 'What date was the movie shot?', 'date');
	$data{'date_processed'} = prompt(&today($db), 'What date was the movie processed?', 'date');
	$data{'process_id'} = &listchoices($db, 'process', 'SELECT process_id as id, name as opt FROM photography.PROCESS', 'integer', \&process_add);
	$data{'description'} = prompt('', 'Please enter a description of the movie', 'text');
	my $id = &newrecord($db, \%data, 'MOVIE');
}

sub task_run {
	my $db = shift;
	my @tasks;
	push @tasks, {
		desc => 'Set right lens_id for all negatives taken with fixed-lens cameras',
		query => $queries::set_lens_id
	};

	push @tasks, {
		desc => 'Update lens focal length per negative',
		query => 'update
			NEGATIVE left join TELECONVERTER on(NEGATIVE.teleconverter_id=TELECONVERTER.teleconverter_id),
			LENS
		set
			NEGATIVE.focal_length=round(LENS.min_focal_length * coalesce(TELECONVERTER.factor,1))
		where
			NEGATIVE.lens_id=LENS.lens_id
			and LENS.zoom = 0
			and LENS.min_focal_length is not null
			and NEGATIVE.focal_length is null'
	};

	push @tasks, {
		desc => 'Update dates of fixed lenses',
		query => 'update
			LENS,
			CAMERA
		set
			LENS.acquired=CAMERA.acquired
		where
			LENS.lens_id = CAMERA.lens_id
			and CAMERA.fixed_mount = 1
			and CAMERA.acquired is not null
			and LENS.acquired!=CAMERA.acquired'
	};

	push @tasks, {
		desc => 'Set metering mode for negatives taken with cameras with only one metering mode',
		query => 'update
			NEGATIVE,
			FILM,
			CAMERA
		set
			NEGATIVE.metering_mode=CAMERA.metering_mode_id
		where
			NEGATIVE.film_id=FILM.film_id
			and FILM.camera_id=CAMERA.camera_id
			and CAMERA.metering_mode_id is not null
			and CAMERA.metering_mode_id != 4
			and CAMERA.metering_mode_id != 5'
	};

	push @tasks, {
		desc => 'Set exposure program for negatives taken with cameras with only one exposure program',
		query => 'UPDATE
			NEGATIVE,
			FILM,
			CAMERA,
			EXPOSURE_PROGRAM_AVAILABLE,
			(SELECT
				CAMERA.camera_id
			FROM
				CAMERA, EXPOSURE_PROGRAM_AVAILABLE
			where
				CAMERA.camera_id = EXPOSURE_PROGRAM_AVAILABLE.camera_id
			group by camera_id
			having count(exposure_program_id) = 1
			) as VALIDCAMERA
		set
			NEGATIVE.exposure_program = EXPOSURE_PROGRAM_AVAILABLE.exposure_program_id
		where
			CAMERA.camera_id = EXPOSURE_PROGRAM_AVAILABLE.camera_id
			and NEGATIVE.film_id=FILM.film_id
			and FILM.camera_id=CAMERA.camera_id
			and CAMERA.camera_id = VALIDCAMERA.camera_id
			and NEGATIVE.exposure_program is null'
	};

       for my $i (0 .. $#tasks) {
		print "\t$i\t$tasks[$i]{'desc'}\n";
	}

	# Wait for input
	my $input = prompt('', "Please select a task", 'integer');

	my $sql = $tasks[$input]{'query'};
	my $rows = &updatedata($db, $sql);
	$rows = 0 if ($rows eq  '0E0');
	print "Updated $rows rows\n";
}

# This ensures the lib loads smoothly
1;
