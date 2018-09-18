package handlers;

# This package provides reusable handlers to be interact with the user

use strict;
use warnings;

use Exporter qw(import);
use Config::IniHash;
use YAML;

my $path;
BEGIN {
	if ($FindBin::Bin =~ /(.*)/) {
		$path = $1;
	}
}
use lib "$path/lib";
use funcs;
use queries;
use tagger;

our @EXPORT = qw(
	film_add film_load film_archive film_develop film_tag film_locate film_bulk film_annotate
	camera_add camera_displaylens camera_sell camera_repair camera_addbodytype camera_stats camera_exposureprogram camera_shutterspeeds camera_accessory camera_meteringmode camera_info camera_choose
	mount_add mount_view mount_adapt
	negative_add negative_bulkadd negative_stats negative_prints
	lens_add lens_sell lens_repair lens_stats lens_accessory lens_info
	print_add print_tone print_sell print_order print_fulfil print_archive print_locate print_reprint print_exhibit print_label
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
	audit_shutterspeeds audit_exposureprograms audit_meteringmodes
	exhibition_add exhibition_review
);

sub film_add {
	# Add a newly-purchased film
	my $db = shift;
	my %data;
	if (&prompt({default=>'no', prompt=>'Is this film bulk-loaded?', type=>'boolean'}) == 1) {
		# These are filled in only for bulk-loaded films
		$data{'film_bulk_id'} = &listchoices({db=>$db, query=>"select * from choose_bulk_film"});
		$data{'film_bulk_loaded'} = &prompt({default=>&today($db), prompt=>'When was the film bulk-loaded?'});
		# These are deduced automagically for bulk-loaded films
		$data{'film_batch'} = &lookupval($db, "select batch from FILM_BULK where film_bulk_id=$data{'film_bulk_id'}");
		$data{'film_expiry'} = &lookupval($db, "select expiry from FILM_BULK where film_bulk_id=$data{'film_bulk_id'}");
		$data{'purchase_date'} = &lookupval($db, "select purchase_date from FILM_BULK where film_bulk_id=$data{'film_bulk_id'}");
		$data{'filmstock_id'} = &lookupval($db, "select filmstock_id from FILM_BULK where film_bulk_id=$data{'film_bulk_id'}");
		$data{'format_id'} = &lookupval($db, "select format_id from FILM_BULK where film_bulk_id=$data{'film_bulk_id'}");
	} else {
		# These are filled in only for standalone films
		$data{'film_batch'} = &prompt({default=>'', prompt=>'Film batch number', type=>'text'});
		$data{'film_expiry'} = &prompt({default=>'', prompt=>'Film expiry date', type=>'date'});
		$data{'purchase_date'} = &prompt({default=>&today($db), prompt=>'Purchase date', type=>'date'});
		$data{'filmstock_id'} = &listchoices({db=>$db, query=>"select * from choose_filmstock", inserthandler=>\&filmstock_add});
		$data{'format_id'} = &listchoices({db=>$db, query=>"select format_id as id, format as opt from FORMAT", inserthandler=>\&format_add});
	}
	$data{'frames'} = &prompt({default=>'', prompt=>'How many frames?', type=>'integer'});
	$data{'price'} = &prompt({default=>'', prompt=>'Purchase price', type=>'decimal'});
	my $filmid = &newrecord($db, \%data, 'FILM');
	if (&prompt({default=>'no', prompt=>'Load this film into a camera now?', type=>'boolean'})) {
		&film_load($db, $filmid);
	}
	return $filmid;
}

sub film_load {
	# Load a film into a camera
	my $db = shift;
	my $film_id = shift || &listchoices({db=>$db, query=>"select * from choose_film_to_load"});
	my %data;
	$data{'camera_id'} = &listchoices({db=>$db, query=>"select C.camera_id as id, concat(M.manufacturer, ' ', C.model) as opt from CAMERA as C, FILM as F, MANUFACTURER as M where F.format_id=C.format_id and C.manufacturer_id=M.manufacturer_id and film_id=$film_id and own=1 order by opt"});
	$data{'exposed_at'} = &prompt({default=>&lookupval($db, "select iso from FILM, FILMSTOCK where FILM.filmstock_id=FILMSTOCK.filmstock_id and film_id=$film_id"), prompt=>'What ISO?', type=>'integer'});
	$data{'date_loaded'} = &prompt({default=>&today($db), prompt=>'What date was this film loaded?', type=>'date'});
	$data{'notes'} = &prompt({default=>'', prompt=>'Notes', type=>'text'});
	&updaterecord($db, \%data, 'FILM', "film_id=$film_id");
}

sub film_archive {
	# Archive a film for storage
	my $db = shift;
	my $film_id = shift || &prompt({default=>'', prompt=>'Enter ID of film to archive', type=>'integer'});
	my %data;
	$data{'archive_id'} = &listchoices({db=>$db, query=>"select archive_id as id, name as opt from ARCHIVE where archive_type_id in (1,2) and sealed = 0", inserthandler=>\&archive_add});
	&updaterecord($db, \%data, 'FILM', "film_id=$film_id");
}

sub film_develop {
	# Develop a film
	my $db = shift;
	my $film_id = shift || &listchoices({db=>$db, query=>"select * from choose_film_to_develop"});
	my %data;
	$data{'date'} = &prompt({default=>&today($db), prompt=>'What date was this film processed?', type=>'date'});
	$data{'developer_id'} = &listchoices({db=>$db, query=>"select developer_id as id, name as opt from DEVELOPER where for_film=1", inserthandler=>\&developer_add});
	$data{'directory'} = &prompt({default=>'', prompt=>'What directory are these scans in?', type=>'text'});
	$data{'photographer_id'} = &listchoices({db=>$db, keyword=>'photographer', query=>"select person_id as id, name as opt from PERSON", inserthandler=>\&person_add});
	$data{'dev_uses'} = &prompt({default=>'', prompt=>'How many previous uses has the developer had?', type=>'integer'});
	$data{'dev_time'} = &prompt({default=>'', prompt=>'How long was the film developed for?', type=>'hh:mm:ss'});
	$data{'dev_temp'} = &prompt({default=>'', prompt=>'What temperature was the developer?', type=>'decimal'});
	$data{'dev_n'} = &prompt({default=>0, prompt=>'What push/pull was used?', type=>'integer'});
	$data{'development_notes'} = &prompt({default=>'', prompt=>'Any other development notes', type=>'text'});
	$data{'processed_by'} = &prompt({default=>'', prompt=>'Who developed the film?', type=>'text'});
	&updaterecord($db, \%data, 'FILM', "film_id=$film_id");
	if (&prompt({default=>'no', prompt=>'Archive this film now?', type=>'boolean'})) {
		&film_archive($db, $film_id);
	}
}

sub film_tag {
	# Write EXIF tags to a film
	my $db = shift;
	my $film_id = shift || &prompt({default=>'', prompt=>'Which film do you want to write EXIF tags to?', type=>'integer'});
	if ($film_id eq '') {
		&prompt({default=>'no', prompt=>'This will write EXIF tags to ALL scans in the database. Are you sure?', type=>'boolean'}) or die "Aborted!\n";
	}
	&tag($db, $film_id);
}

sub film_locate {
	my $db = shift;
	my $film_id = shift || &prompt({default=>'', prompt=>'Which film do you want to locate?', type=>'integer'});

	if (my $archiveid = &lookupval($db, "select archive_id from FILM where film_id=$film_id")) {
		my $archive = &lookupval($db, "select concat(name, ' (', location, ')') as archive from ARCHIVE where archive_id = $archiveid");
		print "Film #${film_id} is in $archive\n";
	} else {
		print "The location of film #${film_id} is unknown\n";
	}
	exit;
}

sub film_bulk {
	my $db = shift;
	my %data;
	$data{'filmstock_id'} = &listchoices({db=>$db, query=>"select * from choose_filmstock", inserthandler=>\&filmstock_add});
	$data{'format_id'} = &listchoices({db=>$db, query=>"select format_id as id, format as opt from FORMAT", inserthandler=>\&format_add});
	$data{'batch'} = &prompt({default=>'', prompt=>'Film batch number', type=>'text'});
	$data{'expiry'} = &prompt({default=>'', prompt=>'Film expiry date', type=>'date'});
	$data{'purchase_date'} = &prompt({default=>&today($db), prompt=>'Purchase date', type=>'date'});
	$data{'cost'} = &prompt({default=>'', prompt=>'Purchase price', type=>'decimal'});
	$data{'source'} = &prompt({default=>'', prompt=>'Where was this bulk film purchased from?', type=>'text'});
	my $filmid = &newrecord($db, \%data, 'FILM_BULK');
	return $filmid;
}

sub film_annotate {
	my $db = shift;
	my $film_id = &prompt({default=>'', prompt=>'Which film do you want to annotate?', type=>'integer'});
	&annotatefilm($db, $film_id);
}

sub camera_add {
	# Add a new camera
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'model'} = &prompt({default=>'', prompt=>'What model is the camera?', type=>'text'});
	$data{'fixed_mount'} = &prompt({default=>'', prompt=>'Does this camera have a fixed lens?', type=>'boolean'});
	if ($data{'fixed_mount'} == 1) {
		# Get info about lens
		print "Please enter some information about the lens\n";
		$data{'lens_id'} = &lens_add($db);
	} else {
		$data{'mount_id'} = &listchoices({db=>$db, query=>"select mount_id as id, mount as opt from MOUNT where purpose='Camera'", inserthandler=>\&mount_add});
	}
	$data{'format_id'} = &listchoices({db=>$db, query=>"select format_id as id, format as opt from FORMAT", inserthandler=>\&format_add});
	$data{'focus_type_id'} = &listchoices({db=>$db, query=>"select focus_type_id as id, focus_type as opt from FOCUS_TYPE", inserthandler=>\&focustype_add});
	$data{'metering'} = &prompt({default=>'', prompt=>'Does this camera have metering?', type=>'boolean'});
	if ($data{'metering'} == 1) {
		$data{'coupled_metering'} = &prompt({default=>'', prompt=>'Is the metering coupled?', type=>'boolean'});
		$data{'metering_type_id'} = &listchoices({db=>$db, query=>"select metering_type_id as id, metering as opt from METERING_TYPE", inserthandler=>\&meteringtype_add});
		$data{'meter_min_ev'} = &prompt({default=>'', prompt=>'What\'s the lowest EV the meter can handle?', type=>'integer'});
		$data{'meter_max_ev'} = &prompt({default=>'', prompt=>'What\'s the highest EV the meter can handle?', type=>'integer'});
	}
	$data{'body_type_id'} = &listchoices({db=>$db, query=>"select body_type_id as id, body_type as opt from BODY_TYPE", inserthandler=>\&camera_addbodytype});
	$data{'weight'} = &prompt({default=>'', prompt=>'What does it weigh? (g)', type=>'integer'});
	$data{'acquired'} = &prompt({default=>&today($db), prompt=>'When was it acquired?', type=>'date'});
	$data{'cost'} = &prompt({default=>'', prompt=>'What did the camera cost?', type=>'decimal'});
	$data{'introduced'} = &prompt({default=>'', prompt=>'What year was the camera introduced?', type=>'integer'});
	$data{'discontinued'} = &prompt({default=>'', prompt=>'What year was the camera discontinued?', type=>'integer'});
	$data{'serial'} = &prompt({default=>'', prompt=>'What is the camera\'s serial number?', type=>'text'});
	$data{'datecode'} = &prompt({default=>'', prompt=>'What is the camera\'s datecode?', type=>'text'});
	$data{'manufactured'} = &prompt({default=>'', prompt=>'When was the camera manufactured?', type=>'integer'});
	$data{'own'} = &prompt({default=>'yes', prompt=>'Do you own this camera?', type=>'boolean'});
	$data{'negative_size_id'} = &listchoices({db=>$db, query=>"select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE", inserthandler=>\&negativesize_add});
	$data{'shutter_type_id'} = &listchoices({db=>$db, query=>"select shutter_type_id as id, shutter_type as opt from SHUTTER_TYPE", inserthandler=>\&shuttertype_add});
	$data{'shutter_model'} = &prompt({default=>'', prompt=>'What is the shutter model?', type=>'text'});
	$data{'cable_release'} = &prompt({default=>'', prompt=>'Does this camera have a cable release?', type=>'boolean'});
	$data{'viewfinder_coverage'} = &prompt({default=>'', prompt=>'What is the viewfinder coverage?', type=>'integer'});
	$data{'power_drive'} = &prompt({default=>'', prompt=>'Does this camera have power drive?', type=>'boolean'});
	if ($data{'power_drive'} == 1) {
		$data{'continuous_fps'} = &prompt({prompt=>'How many frames per second can this camera manage?', type=>'decimal'});
	}
	$data{'video'} = &prompt({default=>'no', prompt=>'Does this camera have a video/movie function?', type=>'boolean'});
	$data{'digital'} = &prompt({default=>'no', prompt=>'Is this a digital camera?', type=>'boolean'});
	$data{'battery_qty'} = &prompt({default=>'', prompt=>'How many batteries does this camera take?', type=>'integer'});
	if ($data{'battery_qty'} > 0) {
		$data{'battery_type'} = &listchoices({db=>$db, keyword=>'battery type', query=>"select * from choose_battery", inserthandler=>\&battery_add});
	}
	$data{'notes'} = &prompt({default=>'', prompt=>'Additional notes', type=>'text'});
	$data{'source'} = &prompt({default=>'', prompt=>'Where was the camera acquired from?', type=>'text'});
	$data{'min_shutter'} = &prompt({default=>'', prompt=>'What\'s the fastest shutter speed?', type=>'text'});
	$data{'max_shutter'} = &prompt({default=>'', prompt=>'What\'s the slowest shutter speed?', type=>'text'});
	$data{'bulb'} = &prompt({default=>'', prompt=>'Does the camera have bulb exposure mode?', type=>'boolean'});
	$data{'time'} = &prompt({default=>'', prompt=>'Does the camera have time exposure mode?', type=>'boolean'});
	$data{'min_iso'} = &prompt({default=>'', prompt=>'What\'s the lowest ISO the camera can do?', type=>'integer'});
	$data{'max_iso'} = &prompt({default=>'', prompt=>'What\'s the highest ISO the camera can do?', type=>'integer'});
	$data{'af_points'} = &prompt({default=>'', prompt=>'How many autofocus points does the camera have?', type=>'integer'});
	$data{'int_flash'} = &prompt({default=>'', prompt=>'Does the camera have an internal flash?', type=>'boolean'});
	if ($data{'int_flash'} == 1) {
		$data{'int_flash_gn'} = &prompt({default=>'', prompt=>'What\'s the guide number of the internal flash?', type=>'integer'});
	}
	$data{'ext_flash'} = &prompt({default=>'', prompt=>'Does the camera support an external flash?', type=>'boolean'});
	if ($data{'ext_flash'} == 1) {
		$data{'pc_sync'} = &prompt({default=>'', prompt=>'Does the camera have a PC sync socket?', type=>'boolean'});
		$data{'hotshoe'} = &prompt({default=>'', prompt=>'Does the camera have a hot shoe?', type=>'boolean'});
	}
	if ($data{'int_flash'} == 1 || $data{'ext_flash'} == 1) {
		$data{'coldshoe'} = &prompt({default=>'', prompt=>'Does the camera have a cold/accessory shoe?', type=>'boolean'});
		$data{'x_sync'} = &prompt('', 'What\'s the X-sync speed?', 'text');
		$data{'flash_metering'} = &listchoices({db=>$db, query=>"select * from FLASH_PROTOCOL", inserthandler=>\&flashprotocol_add});
	}
	$data{'condition_id'} = &listchoices({db=>$db, keyword=>'condition', query=>"select condition_id as id, name as opt from `CONDITION`"});
	$data{'oem_case'} = &prompt({default=>'', prompt=>'Do you have the original case for this camera?', type=>'boolean'});
	$data{'dof_preview'} = &prompt({default=>'', prompt=>'Does this camera have a depth-of-field preview feature?', type=>'boolean'});
	$data{'tripod'} = &prompt({default=>'', prompt=>'Does this camera have a tripod bush?', type=>'boolean'});
	my $cameraid = &newrecord($db, \%data, 'CAMERA');

	# Now we have a camera ID, we can insert rows in auxiliary tables
	if (&prompt({default=>'yes', prompt=>'Add exposure programs for this camera?', type=>'boolean'})) {
		&camera_exposureprogram($db, $cameraid);
	}

	if (&prompt({default=>'yes', prompt=>'Add metering modes for this camera?', type=>'boolean'})) {
		if ($data{'metering'}) {
			&camera_meteringmode($db, $cameraid);
		} else {
			my %mmdata = ('camera_id' => $cameraid, 'metering_mode_id' => 0);
			&newrecord($db, \%mmdata, 'METERING_MODE_AVAILABLE');
		}
	}

	if (&prompt({default=>'yes', prompt=>'Add shutter speeds for this camera?', type=>'boolean'})) {
		&camera_shutterspeeds($db, $cameraid);
	}

	if (&prompt({default=>'yes', prompt=>'Add accessory compatibility for this camera?', type=>'boolean'})) {
		&camera_accessory($db, $cameraid);
	}

	if (&prompt({default=>'yes', prompt=>'Add a display lens for this camera?', type=>'boolean'})) {
		&camera_displaylens($db, $cameraid);
	}
	return $cameraid;
}

sub camera_accessory {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, query=>"select * from choose_camera"});
	while (1) {
		my %compatdata;
		$compatdata{'accessory_id'} = &listchoices({db=>$db, query=>'select * from choose_accessory'});
		$compatdata{'camera_id'} = $cameraid;
		&newrecord($db, \%compatdata, 'ACCESSORY_COMPAT');
		if (!&prompt({default=>'yes', prompt=>'Add more accessory compatibility info?', type=>'boolean'})) {
			last;
		}
	}
}

sub camera_shutterspeeds {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, query=>"select * from choose_camera"});
	while (1) {
		my %shutterdata;
		$shutterdata{'shutter_speed'} = &listchoices({db=>$db, keyword=>'shutter speed', query=>"SELECT shutter_speed as id, '' as opt FROM photography.SHUTTER_SPEED where shutter_speed not in ('B', 'T') and shutter_speed not in (select shutter_speed from SHUTTER_SPEED_AVAILABLE where camera_id=$cameraid) order by duration", type=>'text', insert_handler=>\&shutterspeed_add});
		$shutterdata{'camera_id'} = $cameraid;
		&newrecord($db, \%shutterdata, 'SHUTTER_SPEED_AVAILABLE');
		if (!&prompt({default=>'yes', prompt=>'Add another shutter speed?', type=>'boolean'})) {
			last;
		}
	}
}

sub camera_exposureprogram {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, query=>"select * from choose_camera"});
	my $exposureprograms = &lookupcol($db, 'select * from EXPOSURE_PROGRAM');
	foreach my $exposureprogram (@$exposureprograms) {
		# Skip 'creative' AE modes
		next if $exposureprogram->{exposure_program_id} == 5;
		next if $exposureprogram->{exposure_program_id} == 6;
		next if $exposureprogram->{exposure_program_id} == 7;
		next if $exposureprogram->{exposure_program_id} == 8;
		if (&prompt({default=>'no', prompt=>"Does this camera have $exposureprogram->{exposure_program} exposure program?", type=>'boolean'})) {
			my %epdata = ('camera_id' => $cameraid, 'exposure_program_id' => $exposureprogram->{exposure_program_id});
			&newrecord($db, \%epdata, 'EXPOSURE_PROGRAM_AVAILABLE');
			last if $exposureprogram->{exposure_program_id} == 0;
		}
	}
}

sub camera_meteringmode {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, query=>"select * from choose_camera"});
	my $meteringmodes = &lookupcol($db, 'select * from METERING_MODE');
	foreach my $meteringmode (@$meteringmodes) {
		if (&prompt({default=>'no', prompt=>"Does this camera have $meteringmode->{metering_mode} metering?", type=>'boolean'})) {
			my %mmdata = ('camera_id' => $cameraid, 'metering_mode_id' => $meteringmode->{metering_mode_id});
			&newrecord($db, \%mmdata, 'METERING_MODE_AVAILABLE');
			last if $meteringmode->{metering_mode_id} == 0;
		}
	}
}

sub camera_displaylens {
	my $db = shift;
	my %data;
	$data{'camera_id'} = shift || &listchoices({db=>$db, query=>"select camera_id as id, concat( manufacturer, ' ',model) as opt from CAMERA, MANUFACTURER where mount_id is not null and own=1 and CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id and camera_id not in (select camera_id from DISPLAYLENS)"});
	my $mount = &lookupval($db, "select mount_id from CAMERA where camera_id=$data{'camera_id'}");
	$data{'lens_id'} = &listchoices({db=>$db, query=>"select lens_id as id, concat(manufacturer, ' ', model) as opt from LENS, MANUFACTURER where mount_id=$mount and LENS.manufacturer_id=MANUFACTURER.manufacturer_id and own=1 and lens_id not in (select lens_id from DISPLAYLENS)"});
	my $displaylensid = &newrecord($db, \%data, 'DISPLAYLENS');
	return $displaylensid;
}

sub camera_sell {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, query=>"select * from choose_camera"});
	my %data;
	$data{'own'} = 0;
	$data{'lost'} = &prompt({default=>&today($db), prompt=>'What date was this camera sold?', type=>'date'});
	$data{'lost_price'} = &prompt({default=>'', prompt=>'How much did this camera sell for?', type=>'decimal'});
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
	$data{'camera_id'} = shift || &listchoices({db=>$db, query=>"select * from choose_camera"});
	$data{'date'} = &prompt({default=>&today($db), prompt=>'What date was this camera repaired?', type=>'date'});
	$data{'summary'} = &prompt({default=>'', prompt=>'Short summary of repair', type=>'text'});
	$data{'description'} = &prompt({default=>'', prompt=>'Longer description of repair', type=>'text'});
	my $repair_id = &newrecord($db, \%data, 'REPAIR');
	return $repair_id;
}

sub camera_info {
	my $db = shift;
	my $camera_id = &listchoices({db=>$db, query=>"select * from choose_camera"});
	my $cameradata = &lookupcol($db, "select * from camera_summary where `Camera ID`=$camera_id");
	print Dump($cameradata);
}

sub camera_stats {
	my $db = shift;
	my $camera_id = &listchoices({db=>$db, query=>"select * from choose_camera"});
	my $camera = &lookupval($db, "select concat( manufacturer, ' ',model) as opt from CAMERA, MANUFACTURER where CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id and camera_id=$camera_id");
	print "\tShowing statistics for $camera\n";
	my $total_shots_with_cam = &lookupval($db, "select count(*) from NEGATIVE, FILM where NEGATIVE.film_id=FILM.film_id and camera_id=$camera_id");
	my $total_shots = &lookupval($db, "select count(*) from NEGATIVE");
	if ($total_shots > 0) {
		my $percentage = round(100 * $total_shots_with_cam / $total_shots);
		print "\tThis camera has been used to take $total_shots_with_cam frames, which is ${percentage}% of the frames in your collection\n";
	}
}

sub camera_choose {
	my $db = shift;
	my %where;
	$where{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER"});
	$where{'format_id'} = &listchoices({db=>$db, query=>"select format_id as id, format as opt from FORMAT"});
	$where{'bulb'} = &prompt({default=>'', prompt=>'Do you need Bulb (B) shutter speed?', type=>'boolean'});
	$where{'time'} = &prompt({default=>'', prompt=>'Do you need Time (T) shutter speed?', type=>'boolean'});
	$where{'fixed_mount'} = &prompt({default=>'', prompt=>'Do you need a camera with an interchangeable lens?', type=>'boolean'});
	if ($where{'fixed_mount'} && $where{'fixed_mount'} != 1) {
		$where{'mount_id'} = &listchoices({db=>$db, query=>"select mount_id as id, mount as opt from MOUNT where purpose='Camera'"});
	}
	$where{'focus_type_id'} = &listchoices({db=>$db, query=>"select focus_type_id as id, focus_type as opt from FOCUS_TYPE", 'integer'});
	$where{'metering'} = &prompt({default=>'', prompt=>'Do you need a camera with metering?', type=>'boolean'});
	if ($where{'metering'} && $where{'metering'} == 1) {
		$where{'coupled_metering'} = &prompt({default=>'', prompt=>'Do you need coupled metering?', type=>'boolean'});
		$where{'metering_type_id'} = &listchoices({db=>$db, query=>"select metering_type_id as id, metering as opt from METERING_TYPE"});
	}
	$where{'body_type_id'} = &listchoices({db=>$db, query=>"select body_type_id as id, body_type as opt from BODY_TYPE"});
	$where{'negative_size_id'} = &listchoices({db=>$db, query=>"select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE"});
	$where{'cable_release'} = &prompt({default=>'', prompt=>'Do you need a camera with cable release?', type=>'boolean'});
	$where{'power_drive'} = &prompt({default=>'', prompt=>'Do you need a camera with power drive?', type=>'boolean'});
	$where{'int_flash'} = &prompt({default=>'', prompt=>'Do you need a camera with internal flash?', type=>'boolean'});
	$where{'ext_flash'} = &prompt({default=>'', prompt=>'Do you need a camera that supports an external flash?', type=>'boolean'});
	if ($where{'ext_flash'} && $where{'ext_flash'} == 1) {
		$where{'pc_sync'} = &prompt({default=>'', prompt=>'Do you need a PC sync socket?', type=>'boolean'});
		$where{'hotshoe'} = &prompt({default=>'', prompt=>'Do you need a hot shoe?', type=>'boolean'});
	}
	if (($where{'int_flash'} && $where{'int_flash'} == 1) || ($where{'ext_flash'} && $where{'ext_flash'} == 1)) {
		$where{'coldshoe'} = &prompt({default=>'', prompt=>'Do you need a cold/accessory shoe?', type=>'boolean'});
		$where{'flash_metering'} = &listchoices({db=>$db, query=>"select * from FLASH_PROTOCOL"});
	}
	$where{'dof_preview'} = &prompt({default=>'', prompt=>'Do you need a depth-of-field preview feature?', type=>'boolean'});
	$where{'tripod'} = &prompt({default=>'', prompt=>'Do you need a tripod bush?', type=>'boolean'});

	my $thinwhere = &thin(\%where);
	my $sql = SQL::Abstract->new;
	my @fields = ('id', 'opt');
	my($stmt, @bind) = $sql->select('camera_chooser', \@fields, $thinwhere);
	my $sth = $db->prepare($stmt);
	$sth->execute(@bind);
	my $i=0;
	print "\n";
	while (my $ref = $sth->fetchrow_hashref) {
		print "\t$ref->{id}\t$ref->{opt}\n";
		$i++;
	}
	print "\n\tFound $i cameras that match your criteria\n";
}

sub negative_add {
	# Add a single neg to a film
	my $db = shift;
	my %data;
	$data{'film_id'} = &prompt({default=>'', prompt=>'Which film does this negative belong to?', type=>'integer'});
	if (!&lookupval($db, "select camera_id from FILM where film_id=$data{'film_id'}")) {
		print "Film must be loaded into a camera before you can add negatives\n";
		if (&prompt({default=>'yes', prompt=>'Load film into a camera now?', type=>'boolean'})) {
			&film_load($db, $data{'film_id'});
		} else {
			exit;
		}
	}
	$data{'frame'} = &prompt({default=>'', prompt=>'Frame number', type=>'text'});
	$data{'description'} = &prompt({default=>'', prompt=>'Caption', type=>'text'});
	$data{'date'} = &prompt({default=>&today($db), prompt=>'What date was this negative taken?', type=>'date'});
	$data{'lens_id'} = &listchoices({db=>$db, keyword=>'lens', query=>"select LENS.lens_id as id, LENS.model as opt from FILM, CAMERA, LENS where FILM.camera_id=CAMERA.camera_id and CAMERA.mount_id=LENS.mount_id and FILM.film_id=$data{'film_id'}"});
	$data{'shutter_speed'} = &listchoices({db=>$db, keyword=>'shutter speed', query=>"SELECT SP.shutter_speed as id, '' as opt FROM SHUTTER_SPEED_AVAILABLE as SPA, SHUTTER_SPEED as SP, FILM, CAMERA where film_id=$data{'film_id'} and SPA.shutter_speed=SP.shutter_speed and FILM.camera_id=CAMERA.camera_id and CAMERA.camera_id=SPA.camera_id order by duration"});
	$data{'aperture'} = &prompt({default=>'', prompt=>'Aperture', type=>'decimal'});
	$data{'filter_id'} = &listchoices({db=>$db, query=>"select * from choose_filter", inserthandler=>\&filter_add});
	$data{'teleconverter_id'} = &listchoices({db=>$db, keyword=>'teleconverter', query=>"select teleconverter_id as id, concat(manufacturer, ' ', T.model, ' (', factor, 'x)') as opt from TELECONVERTER as T, CAMERA as C, FILM as F, MANUFACTURER as M where C.mount_id=T.mount_id and F.camera_id=C.camera_id and M.manufacturer_id=T.manufacturer_id and film_id=$data{'film_id'}", inserthandler=>\&teleconverter_add});
	$data{'notes'} = &prompt({default=>'', prompt=>'Extra notes', type=>'text'});
	$data{'mount_adapter_id'} = &listchoices({db=>$db, query=>"select mount_adapter_id as id, mount as opt from MOUNT_ADAPTER as MA, CAMERA as C, FILM as F, MOUNT as M where C.mount_id=MA.camera_mount and F.camera_id=C.camera_id and M.mount_id=MA.lens_mount and film_id=$data{'film_id'}"});
	$data{'focal_length'} = &prompt({default=>&lookupval($db, "select min_focal_length from LENS where lens_id=$data{'lens_id'}"), prompt=>'Focal length', type=>'integer'});
	$data{'latitude'} = &prompt({default=>'', prompt=>'Latitude', type=>'decimal'});
	$data{'longitude'} = &prompt({default=>'', prompt=>'Longitude', type=>'decimal'});
	$data{'flash'} = &prompt({default=>'no', prompt=>'Was flash used?', type=>'boolean'});
	$data{'metering_mode'} = &listchoices({db=>$db, query=>"select metering_mode_id as id, metering_mode as opt from METERING_MODE"});
	$data{'exposure_program'} = &listchoices({db=>$db, query=>"select exposure_program_id as id, exposure_program as opt from EXPOSURE_PROGRAM"});
	$data{'photographer_id'} = &listchoices({db=>$db, keyword=>'photographer', query=>"select person_id as id, name as opt from PERSON", inserthandler=>\&person_add});
	my $negativeid = &newrecord($db, \%data, 'NEGATIVE');
	return $negativeid;
}

sub negative_bulkadd {
	my $db = shift;
	# Add lots of negatives to a film, maybe asks if they were all shot with the same lens
	my %data;
	$data{'film_id'} = shift || &prompt({default=>'', prompt=>'Bulk add negatives to which film?', type=>'integer'});
	my $num = &prompt({default=>'', prompt=>'How many frames to add?', type=>'integer'});
	if (&prompt({default=>'no', prompt=>"Add any other attributes to all $num negatives?", type=>'boolean'})) {
		$data{'description'} = &prompt({default=>'', prompt=>'Caption', type=>'text'});
		$data{'date'} = &prompt({default=>&today($db), prompt=>'What date was this negative taken?', type=>'date'});
		$data{'lens_id'} = &listchoices({db=>$db, keyword=>'lens', query=>"select LENS.lens_id as id, LENS.model as opt from FILM, CAMERA, LENS where FILM.camera_id=CAMERA.camera_id and CAMERA.mount_id=LENS.mount_id and FILM.film_id=$data{'film_id'}"});
		$data{'shutter_speed'} = &listchoices({db=>$db, keyword=>'shutter speed', query=>"SELECT SP.shutter_speed FROM SHUTTER_SPEED_AVAILABLE as SPA, SHUTTER_SPEED as SP, FILM, CAMERA where film_id=$data{'film_id'} and SPA.shutter_speed=SP.shutter_speed and FILM.camera_id=CAMERA.camera_id and CAMERA.camera_id=SPA.camera_id order by duration"});
		$data{'aperture'} = &prompt({default=>'', prompt=>'Aperture', type=>'decimal'});
		$data{'filter_id'} = &listchoices({db=>$db, query=>"select * from choose_filter", inserthandler=>\&filter_add});
		$data{'teleconverter_id'} = &listchoices({db=>$db, keyword=>'teleconverter', query=>"select teleconverter_id as id, concat(manufacturer, ' ', T.model, ' (', factor, 'x)') as opt from TELECONVERTER as T, CAMERA as C, FILM as F, MANUFACTURER as M where C.mount_id=T.mount_id and F.camera_id=C.camera_id and M.manufacturer_id=T.manufacturer_id and film_id=$data{'film_id'}", inserthandler=>\&teleconverter_add});
		$data{'notes'} = &prompt({default=>'', prompt=>'Extra notes', type=>'text'});
		$data{'mount_adapter_id'} = &listchoices({db=>$db, query=>"select mount_adapter_id as id, mount as opt from MOUNT_ADAPTER as MA, CAMERA as C, FILM as F, MOUNT as M where C.mount_id=MA.camera_mount and F.camera_id=C.camera_id and M.mount_id=MA.lens_mount and film_id=$data{'film_id'}"});
		$data{'focal_length'} = &prompt({default=>&lookupval($db, "select min_focal_length from LENS where lens_id=$data{'lens_id'}"), prompt=>'Focal length', type=>'integer'});
		$data{'latitude'} = &prompt({default=>'', prompt=>'Latitude', type=>'decimal'});
		$data{'longitude'} = &prompt({default=>'', prompt=>'Longitude', type=>'decimal'});
		$data{'flash'} = &prompt({default=>'no', prompt=>'Was flash used?', type=>'boolean'});
		$data{'metering_mode'} = &listchoices({db=>$db, query=>"select metering_mode_id as id, metering_mode as opt from METERING_MODE"});
		$data{'exposure_program'} = &listchoices({db=>$db, query=>"select exposure_program_id as id, exposure_program as opt from EXPOSURE_PROGRAM"});
	}

	# Delete empty strings from data hash
	foreach (keys %data) {
		delete $data{$_} unless (defined $data{$_} and $data{$_} ne '');
	}

	# Build query
	my $sql = SQL::Abstract->new;

	# Final confirmation
	&prompt({default=>'yes', prompt=>'Proceed?', type=>'boolean'}) or die "Aborted!\n";

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
	my $neg_id = &chooseneg($db);
	my $noprints = &lookupval($db, "select count(*) from PRINT where negative_id=$neg_id");
	print "\tThis negative has been printed $noprints times\n";
}

sub negative_prints {
	my $db = shift;
	my $neg_id = &chooseneg($db);
	&printlist($db, "prints from negative $neg_id", "select id, opt from print_locations where negative_id=$neg_id");
}

sub lens_add {
	my $db = shift;
	my %data;
	$data{'fixed_mount'} = &prompt({default=>'no', prompt=>'Does this lens have a fixed mount?', type=>'boolean'});
	if ($data{'fixed_mount'} == 0) {
		$data{'mount_id'} = &listchoices({db=>$db, query=>"select mount_id as id, mount as opt from MOUNT", inserthandler=>\&mount_add});
	}
	$data{'zoom'} = &prompt({default=>'no', prompt=>'Is this a zoom lens?', type=>'boolean'});
	if ($data{'zoom'} == 0) {
		$data{'min_focal_length'} = &prompt({default=>'', prompt=>'What is the focal length?', type=>'integer'});
		$data{'max_focal_length'} = $data{'min_focal_length'};
	} else {
		$data{'min_focal_length'} = &prompt({default=>'', prompt=>'What is the minimum focal length?', type=>'integer'});
		$data{'max_focal_length'} = &prompt({default=>'', prompt=>'What is the maximum focal length?', type=>'integer'});
	}
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'model'} = &prompt({default=>'', prompt=>'What is the lens model?', type=>'text'});
	$data{'closest_focus'} = &prompt({default=>'', prompt=>'How close can the lens focus? (cm)', type=>'integer'});
	$data{'max_aperture'} = &prompt({default=>'', prompt=>'What is the largest lens aperture?', type=>'decimal'});
	$data{'min_aperture'} = &prompt({default=>'', prompt=>'What is the smallest lens aperture?', type=>'decimal'});
	$data{'elements'} = &prompt({default=>'', prompt=>'How many elements does the lens have?', type=>'integer'});
	$data{'groups'} = &prompt({default=>'', prompt=>'How many groups are these elements in?', type=>'integer'});
	$data{'weight'} = &prompt({default=>'', prompt=>'What is the weight of the lens? (g)', type=>'integer'});
	$data{'nominal_min_angle_diag'} = &prompt({default=>'', prompt=>'What is the minimum diagonal angle of view?', type=>'integer'});
	$data{'nominal_max_angle_diag'} = &prompt({default=>'', prompt=>'What is the maximum diagonal angle of view?', type=>'integer'});
	$data{'aperture_blades'} = &prompt({default=>'', prompt=>'How many aperture blades does the lens have?', type=>'integer'});
	$data{'autofocus'} = &prompt({default=>'', prompt=>'Does this lens have autofocus?', type=>'boolean'});
	$data{'filter_thread'} = &prompt({default=>'', prompt=>'What is the diameter of the filter thread? (mm)', type=>'decimal'});
	$data{'magnification'} = &prompt({default=>'', prompt=>'What is the maximum magnification possible with this lens?', type=>'decimal'});
	$data{'url'} = &prompt({default=>'', prompt=>'Informational URL for this lens', type=>'text'});
	$data{'serial'} = &prompt({default=>'', prompt=>'What is the serial number of the lens?', type=>'text'});
	$data{'date_code'} = &prompt({default=>'', prompt=>'What is the date code of the lens?', type=>'text'});
	$data{'introduced'} = &prompt({default=>'', prompt=>'When was this lens introduced?', type=>'integer'});
	$data{'discontinued'} = &prompt({default=>'', prompt=>'When was this lens discontinued?', type=>'integer'});
	$data{'manufactured'} = &prompt({default=>'', prompt=>'When was this lens manufactured?', type=>'integer'});
	$data{'negative_size_id'} = &listchoices({db=>$db, query=>"select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE", inserthandler=>\&negativesize_add});
	$data{'acquired'} = &prompt({default=>&today($db), prompt=>'When was this lens acquired?', type=>'date'});
	$data{'cost'} = &prompt({default=>'', prompt=>'How much did this lens cost?', type=>'decimal'});
	$data{'notes'} = &prompt({default=>'', prompt=>'Notes', type=>'text'});
	$data{'own'} = &prompt({default=>'yes', prompt=>'Do you own this lens?', type=>'boolean'});
	$data{'source'} = &prompt({default=>'', prompt=>'Where was this lens sourced from?', type=>'text'});
	$data{'coating'} = &prompt({default=>'', prompt=>'What coating does this lens have?', type=>'text'});
	$data{'hood'} = &prompt({default=>'', prompt=>'What is the model number of the suitable hood for this lens?', type=>'text'});
	$data{'exif_lenstype'} = &prompt({default=>'', prompt=>'EXIF lens type code', type=>'text'});
	$data{'rectilinear'} = &prompt({default=>'yes', prompt=>'Is this a rectilinear lens?', type=>'boolean'});
	$data{'length'} = &prompt({default=>'', prompt=>'How long is this lens? (mm)', type=>'integer'});
	$data{'diameter'} = &prompt({default=>'', prompt=>'How wide is this lens? (mm)', type=>'integer'});
	$data{'condition_id'} = &listchoices({db=>$db, keyword=>'condition', query=>"select condition_id as id, name as opt from `CONDITION`"});
	$data{'image_circle'} = &prompt({default=>'', prompt=>'What is the diameter of the image circle?', type=>'integer'});
	$data{'formula'} = &prompt({default=>'', prompt=>'Does this lens have a named optical formula?', type=>'text'});
	$data{'shutter_model'} = &prompt({default=>'', prompt=>'What shutter does this lens incorporate?', type=>'text'});
	my $lensid = &newrecord($db, \%data, 'LENS');

	if (&prompt({default=>'yes', prompt=>'Add accessory compatibility for this lens?', type=>'boolean'})) {
		&lens_accessory($db, $lensid);
	}
	return $lensid;
}

sub lens_accessory {
	my $db = shift;
	my $lensid = shift || &listchoices({db=>$db, query=>"select * from choose_lens"});
	while (1) {
		my %compatdata;
		$compatdata{'accessory_id'} = &listchoices({db=>$db, query=>'select * from choose_accessory'});
		$compatdata{'lens_id'} = $lensid;
		&newrecord($db, \%compatdata, 'ACCESSORY_COMPAT');
		if (!&prompt({default=>'yes', prompt=>'Add more accessory compatibility info?', type=>'boolean'})) {
			last;
		}
	}
}

sub lens_sell {
	my $db = shift;
	my %data;
	my $lensid = shift || &listchoices({db=>$db, query=>"select * from choose_lens"});
	$data{'own'} = 0;
	$data{'lost'} = &prompt({default=>&today($db), prompt=>'What date was this lens sold?', type=>'date'});
	$data{'lost_price'} = &prompt({default=>'', prompt=>'How much did this lens sell for?', type=>'decimal'});
	&updaterecord($db, \%data, 'LENS', "lens_id=$lensid");
}

sub lens_repair {
	my $db = shift;
	my %data;
	$data{'lens_id'} = shift || &listchoices({db=>$db, query=>"select * from choose_lens"});
	$data{'date'} = &prompt({default=>&today($db), prompt=>'What date was this lens repaired?', type=>'date'});
	$data{'summary'} = &prompt({default=>'', prompt=>'Short summary of repair', type=>'text'});
	$data{'description'} = &prompt({default=>'', prompt=>'Longer description of repair', type=>'text'});
	my $repair_id = &newrecord($db, \%data, 'REPAIR');
	return $repair_id;
}

sub lens_stats {
	my $db = shift;
	my $lens_id = &listchoices({db=>$db, query=>"select * from choose_lens"});
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

sub lens_info {
	my $db = shift;
	my $lens_id = &listchoices({db=>$db, query=>"select * from choose_lens"});
	my $lensdata = &lookupcol($db, "select * from lens_summary where `Lens ID`=$lens_id");
	print Dump($lensdata);
}

sub print_add {
	my $db = shift;
	my %data;
	my $neg_id;
	my $todo_id = &listchoices({db=>$db, keyword=>'print from the order queue', query=>'SELECT * FROM photography.choose_todo'});
	if ($todo_id) {
		$neg_id = &lookupval($db, "select negative_id from TO_PRINT where id=$todo_id");
	} else {
		$neg_id = &chooseneg($db);
	}
	$data{'negative_id'} = &prompt({default=>$neg_id, prompt=>'Negative ID to print from', type=>'integer'});
	$data{'date'} = &prompt({default=>&today($db), prompt=>'Date that the print was made', type=>'date'});
	$data{'paper_stock_id'} = &listchoices({db=>$db, keyword=>'paper stock', query=>"select * from choose_paper", inserthandler=>\&paperstock_add});
	$data{'height'} = &prompt({default=>'', prompt=>'Height of the print (inches)', type=>'integer'});
	$data{'width'} = &prompt({default=>'', prompt=>'Width of the print (inches)', type=>'integer'});
	$data{'aperture'} = &prompt({default=>'', prompt=>'Aperture used on enlarging lens', type=>'decimal'});
	$data{'exposure_time'} = &prompt({default=>'', prompt=>'Exposure time (s)', type=>'integer'});
	$data{'filtration_grade'} = &prompt({default=>'', prompt=>'Filtration grade', type=>'decimal'});
	$data{'development_time'} = &prompt({default=>'60', prompt=>'Development time (s)', type=>'integer'});
	$data{'enlarger_id'} = &listchoices({db=>$db, query=>"select * from choose_enlarger", inserthandler=>\&enlarger_add});
	$data{'lens_id'} = &listchoices({db=>$db, query=>"select * from choose_enlarger_lens"});
	$data{'developer_id'} = &listchoices({db=>$db, query=>"select developer_id as id, name as opt from DEVELOPER where for_paper=1", inserthandler=>\&developer_add});
	$data{'fine'} = &prompt({default=>'', prompt=>'Is this a fine print?', type=>'boolean'});
	$data{'notes'} = &prompt({default=>'', prompt=>'Notes', type=>'text'});
	$data{'printer_id'} = &listchoices({db=>$db, keyword=>'printer', query=>"select person_id as id, name as opt from PERSON", inserthandler=>\&person_add});
	my $printid = &newrecord($db, \%data, 'PRINT');

	# Mark is as complete in the todo list
	if ($todo_id) {
		my %data2;
		$data2{'printed'} = 1;
		$data2{'print_id'} = $printid;
		&updaterecord($db, \%data2, 'TO_PRINT', "id=$todo_id");
	}

	if (&prompt({default=>'no', prompt=>'Did you tone this print?', type=>'boolean'})) {
		&print_tone($db, $printid);
	}

	if (&prompt({default=>'no', prompt=>'Archive this print?', type=>'boolean'})) {
		&print_archive($db, $printid);
	}

	return $printid;
}

sub print_fulfil {
	my $db = shift;
	my %data;
	my $todo_id = &listchoices({db=>$db, keyword=>'print from the queue', query=>'SELECT * FROM photography.choose_todo'});
	$data{'printed'} = &prompt({default=>'yes', prompt=>'Is this print order now fulfilled?', type=>'boolean'});
	$data{'print_id'} = &prompt({default=>'', prompt=>'Which print fulfilled this order?', type=>'integer'});
	&updaterecord($db, \%data, 'TO_PRINT', "id=$todo_id");
}

sub print_tone {
	my $db = shift;
	my %data;
	my $print_id = shift || &prompt({default=>'', prompt=>'Which print did you tone?', type=>'integer'});
	$data{'bleach_time'} = &prompt({default=>'00:00:00', prompt=>'How long did you bleach for? (HH:MM:SS)', type=>'hh:mm:ss'});
	$data{'toner_id'} = &listchoices({db=>$db, query=>"select toner_id as id, toner as opt from TONER", inserthandler=>\&toner_add});
	my $dilution1 = &lookupval($db, "select stock_dilution from TONER where toner_id=$data{'toner_id'}");
	$data{'toner_dilution'} = &prompt({default=>$dilution1, prompt=>'What was the dilution of the first toner?', type=>'text'});
	$data{'toner_time'} = &prompt({default=>'', prompt=>'How long did you tone for? (HH:MM:SS)', type=>'hh:mm:ss'});
	if (&prompt({default=>'no', prompt=>'Did you use a second toner?', type=>'boolean'}) == 1) {
		$data{'2nd_toner_id'} = &listchoices({db=>$db, query=>"select toner_id as id, toner as opt from TONER", inserthandler=>\&toner_add});
		my $dilution2 = &lookupval($db, "select stock_dilution from TONER where toner_id=$data{'2nd_toner_id'}");
		$data{'2nd_toner_dilution'} = &prompt({default=>$dilution2, prompt=>'What was the dilution of the second toner?', type=>'text'});
		$data{'2nd_toner_time'} = &prompt({default=>'', prompt=>'How long did you tone for? (HH:MM:SS)', type=>'hh:mm:ss'});
	}
	&updaterecord($db, \%data, 'PRINT', "print_id=$print_id");
}

sub print_sell {
	my $db = shift;
	my %data;
	my $print_id = shift || &prompt({default=>'', prompt=>'Which print did you sell?', type=>'integer'});
	$data{'own'} = 0;
	$data{'location'} = &prompt({default=>'', prompt=>'What happened to the print?', type=>'text'});
	$data{'sold_price'} = &prompt({default=>'', prompt=>'What price was the print sold for?', type=>'decimal'});
	&updaterecord($db, \%data, 'PRINT', "print_id=$print_id");
}

sub print_order {
	my $db = shift;
	my %data;
	my $neg_id = &chooseneg($db);
	$data{'negative_id'} = &prompt({default=>$neg_id, prompt=>'Negative ID to print from', type=>'integer'});
	$data{'height'} = &prompt({default=>'', prompt=>'Height of the print (inches)', type=>'integer'});
	$data{'width'} = &prompt({default=>'', prompt=>'Width of the print (inches)', type=>'integer'});
	$data{'recipient'} = &prompt({default=>'', prompt=>'Who is the print for?', type=>'text'});
	$data{'added'} = &prompt({default=>&today($db), prompt=>'Date that this order was placed', type=>'date'});
	my $orderid = &newrecord($db, \%data, 'TO_PRINT');
}

sub print_archive {
	# Archive a print for storage
	my $db = shift;
	my %data;
	my $print_id = shift || &prompt({default=>'', prompt=>'Which print did you archive?', type=>'integer'});
	$data{'archive_id'} = &listchoices({db=>$db, query=>"select archive_id as id, name as opt from ARCHIVE where archive_type_id = 3 and sealed = 0", inserthandler=>\&archive_add});
	$data{'own'} = 1;
	$data{'location'} = 'Archive',
	&updaterecord($db, \%data, 'PRINT', "print_id=$print_id");
}

sub print_locate {
	my $db = shift;
	my $print_id = &prompt({default=>'', prompt=>'Which print do you want to locate?', type=>'integer'});

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

sub print_reprint {
	my $db = shift;
	my $print_id = &prompt({default=>'', prompt=>'Which print do you want to reprint?', type=>'integer'});
	my $negative = &lookupval($db, "select concat(film_id, '/', frame) as negative from PRINT, NEGATIVE where print_id = $print_id and PRINT.negative_id=NEGATIVE.negative_id");
	my $caption = &lookupval($db, "select description from PRINT, NEGATIVE where print_id = $print_id and PRINT.negative_id=NEGATIVE.negative_id");
	print "\tPrint #${print_id} was made from Negative $negative \"$caption\"\n";

	my $size = &lookupval($db, "select concat(width,'x',height,'\"') as size from PRINT where print_id = $print_id");
	my $paper = &lookupval($db, "select concat(manufacturer, ' ', PAPER_STOCK.name) as paper from PRINT, PAPER_STOCK, MANUFACTURER where print_id = $print_id and PRINT.paper_stock_id = PAPER_STOCK.paper_stock_id and PAPER_STOCK.manufacturer_id=MANUFACTURER.manufacturer_id");
	print "\tIt was made on $paper at size $size\n";

	# enlarger, lens
	my $enlarger = &lookupval($db, "select concat(manufacturer, ' ', enlarger) as enlarger from PRINT, ENLARGER, MANUFACTURER where print_id=$print_id and PRINT.enlarger_id=ENLARGER.enlarger_id and ENLARGER.manufacturer_id = MANUFACTURER.manufacturer_id");
	my $lens = &lookupval($db, "select concat(manufacturer, ' ', model) as lens from PRINT, LENS, MANUFACTURER where print_id=$print_id and PRINT.lens_id=LENS.lens_id and LENS.manufacturer_id = MANUFACTURER.manufacturer_id");
	print "\tIt was made with the $enlarger enlarger and $lens lens\n";
	if (&lookupval($db, "select ENLARGER.lost from PRINT, ENLARGER where print_id=$print_id and PRINT.enlarger_id=ENLARGER.enlarger_id")) {
		print "\tYou no longer own the $enlarger, so the exposure information may be useless!\n";
	}

	# time & aperture
	my $time = &lookupval($db, "select exposure_time from PRINT where print_id=$print_id");
	my $aperture = &lookupval($db, "select aperture from PRINT where print_id=$print_id");
	print "\tExposure was ${time}s at f/${aperture}\n";

	# multigrade filter
	if (my $grade = &lookupval($db, "select filtration_grade from PRINT where print_id=$print_id")) {
		print "\tFiltration grade was $grade\n";
	} else {
		print "\tPrint was unfiltered\n";
	}
	# toner
	if (&lookupval($db, "select toner_id from PRINT where print_id=$print_id")) {
		# at least one toner
		my $firsttoner = &lookupval($db, "select concat(manufacturer, ' ', toner, if(toner_dilution is not null, concat(' (', toner_dilution, ')'), ''), if(toner_time is not null, concat(' for ', toner_time), '')) as toner from PRINT, TONER, MANUFACTURER where PRINT.toner_id=TONER.toner_id and TONER.manufacturer_id=MANUFACTURER.manufacturer_id");
		if (&lookupval($db, "select 2nd_toner_id from PRINT where print_id=$print_id")) {
			# 2 toners
			my $secondtoner = &lookupval($db, "select concat(manufacturer, ' ', toner, if(2nd_toner_dilution is not null, concat(' (', 2nd_toner_dilution, ')'), ''), if(2nd_toner_time is not null, concat(' for ', 2nd_toner_time), '')) as toner from PRINT, TONER, MANUFACTURER where PRINT.2nd_toner_id=TONER.toner_id and TONER.manufacturer_id=MANUFACTURER.manufacturer_id");
			print "\tToned frst in $firsttoner\n";
			print "\tThen toned in $secondtoner\n";
		} else {
			# 1 toner
			print "\tToned in $firsttoner\n";
		}
	} else {
		# no toner
		print "\tPrint was not toned\n";
	}
}

sub print_exhibit {
	my $db = shift;
	my %data;
	$data{'print_id'} = &prompt({default=>'', prompt=>'Which print do you want to exhibit?', type=>'integer'});
	$data{'exhibition_id'} = &listchoices({db=>$db, query=>"select exhibition_id as id, title as opt from EXHIBITION", inserthandler=>\&exhibition_add});
	my $id = &newrecord($db, \%data, 'EXHIBIT');
	return $id;
}

sub print_label {
	my $db = shift;
	my $print_id = &prompt({default=>'', prompt=>'Which print do you want to label?', type=>'integer'});
	my $data = &lookupcol($db, "select * from print_info where print_id=$print_id");
	my $row = @$data[0];
	print "\t#$row->{'print_id'} $row->{'description'}\n" if ($row->{print_id} && $row->{description});
	print "\tPhotographed $row->{photo_date}\n" if ($row->{photo_date});
	print "\tPrinted $row->{print_date}\n" if ($row->{print_date});
	print "\tby $row->{name}\n" if ($row->{name});
}

sub paperstock_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'name'} = &prompt({default=>'', prompt=>'What model is the paper?', type=>'text'});
	$data{'resin_coated'} = &prompt({default=>'', prompt=>'Is this paper resin-coated?', type=>'boolean'});
	$data{'tonable'} = &prompt({default=>'', prompt=>'Is this paper tonable?', type=>'boolean'});
	$data{'colour'} = &prompt({default=>'', prompt=>'Is this a colour paper?', type=>'boolean'});
	$data{'finish'} = &prompt({default=>'', prompt=>'What surface finish does this paper have?', type=>'text'});
	my $paperstockid = &newrecord($db, \%data, 'PAPER_STOCK');
	return $paperstockid;
}

sub developer_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'name'} = &prompt({default=>'', prompt=>'What model is the developer?', type=>'text'});
	$data{'for_paper'} = &prompt({default=>'', prompt=>'Is this developer suitable for paper?', type=>'boolean'});
	$data{'for_film'} = &prompt({default=>'', prompt=>'Is this developer suitable for film?', type=>'boolean'});
	$data{'chemistry'} = &prompt({default=>'', prompt=>'What type of chemistry is this developer based on?', type=>'text'});
	my $developerid = &newrecord($db, \%data, 'DEVELOPER');
	return $developerid;
}

sub mount_add {
	my $db = shift;
	my %data;
	$data{'mount'} = &prompt({default=>'', prompt=>'What is the name of this lens mount?', type=>'text'});
	$data{'fixed'} = &prompt({default=>'no', prompt=>'Is this a fixed mount?', type=>'boolean'});
	$data{'shutter_in_lens'} = &prompt({default=>'no', prompt=>'Does this mount contain the shutter in the lens?', type=>'boolean'});
	$data{'type'} = &prompt({default=>'', prompt=>'What type of mounting does this mount use? (e.g. bayonet, screw, etc)', type=>'text'});
	$data{'purpose'} = &prompt({default=>'camera', prompt=>'What is the intended purpose of this mount? (e.g. camera, enlarger, projector, etc)', type=>'text'});
	$data{'digital_only'} = &prompt({default=>'no', prompt=>'Is this a digital-only mount?', type=>'boolean'});
	$data{'notes'} = &prompt({default=>'', prompt=>'Notes about this mount', type=>'text'});
	my $mountid = &newrecord($db, \%data, 'MOUNT');
	return $mountid;
}

sub mount_view {
	my $db = shift;
	my $mountid = &listchoices({db=>$db, query=>'select mount_id as id, mount as opt from MOUNT'});
	my $mountname = lookupval($db, "select mount from MOUNT where mount_id = ${mountid}");
	print "Showing data for $mountname mount\n";
	&printlist($db, "cameras with $mountname mount", "select C.camera_id as id, concat(M.manufacturer, ' ', C.model) as opt from CAMERA as C, MANUFACTURER as M where C.manufacturer_id=M.manufacturer_id and own=1 and mount_id=$mountid order by opt");
	&printlist($db, "lenses with $mountname mount", "select lens_id as id, concat(manufacturer, ' ', model) as opt from LENS, MANUFACTURER where mount_id=$mountid and LENS.manufacturer_id=MANUFACTURER.manufacturer_id and own=1 order by opt");
}

sub toner_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'toner'} = &prompt({default=>'', prompt=>'What is the name of this toner?', type=>'text'});
	$data{'formulation'} = &prompt({default=>'', prompt=>'What is the chemical formulation of this toner?', type=>'text'});
	$data{'stock_dilution'} = &prompt({default=>'', prompt=>'What is the stock dilution of this toner?', type=>'text'});
	my $tonerid = &newrecord($db, \%data, 'TONER');
	return $tonerid;
}

sub filmstock_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'name'} = &prompt({default=>'', prompt=>'What is the name of this filmstock?', type=>'text'});
	$data{'iso'} = &prompt({default=>'', prompt=>'What is the box ISO/ASA speed of this filmstock?', type=>'integer'});
	$data{'colour'} = &prompt({default=>'', prompt=>'Is this a colour film?', type=>'boolean'});
	if ($data{'colour'} == 1) {
		$data{'panchromatic'} = 1;
	} else {
		$data{'panchromatic'} = &prompt({default=>'yes', prompt=>'Is this a panchromatic film?', type=>'boolean'});
	}
	$data{'process_id'} = &listchoices({db=>$db, query=>'SELECT process_id as id, name as opt FROM PROCESS', inserthandler=>\&process_add});
	my $filmstockid = &newrecord($db, \%data, 'FILMSTOCK');
	return $filmstockid;
}

sub teleconverter_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'model'} = &prompt({default=>'', prompt=>'What is the model of this teleconverter?', type=>'text'});
	$data{'factor'} = &prompt('', 'What is the magnification factor of this teleconverter?', 'decimal');
	$data{'mount_id'} = &listchoices({db=>$db, query=>"select mount_id as id, mount as opt from MOUNT where purpose='Camera'", inserthandler=>\&mount_add});
	$data{'elements'} = &prompt({default=>'', prompt=>'How many elements does this teleconverter have?', type=>'integer'});
	$data{'groups'} = &prompt({default=>'', prompt=>'How many groups are the elements arranged in?', type=>'integer'});
	$data{'multicoated'} = &prompt({default=>'', prompt=>'Is this teleconverter multicoated?', type=>'boolean'});
	my $teleconverterid = &newrecord($db, \%data, 'TELECONVERTER');
	return $teleconverterid;
}

sub filter_add {
	my $db = shift;
	my %data;
	$data{'type'} = &prompt({default=>'', prompt=>'What type of filter is this?', type=>'text'});
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandlers=>\&manufacturer_add});
	$data{'attenuation'} = &prompt({default=>'', prompt=>'What attenutation (in stops) does this filter have?', type=>'decimal'});
	$data{'thread'} = &prompt({default=>'', prompt=>'What diameter mounting thread does this filter have?', type=>'decimal'});
	$data{'qty'} = &prompt({default=>1, prompt=>'How many of these filters do you have?', type=>'integer'});
	my $filterid = &newrecord($db, \%data, 'FILTER');
	return $filterid;
}

sub process_add {
	my $db = shift;
	my %data;
	$data{'name'} = &prompt({default=>'', prompt=>'What is the name of this film process?', type=>'text'});
	$data{'colour'} = &prompt({default=>'', prompt=>'Is this a colour process?', type=>'boolean'});
	$data{'positive'} = &prompt({default=>'', prompt=>'Is this a reversal process?', type=>'boolean'});
	my $processid = &newrecord($db, \%data, 'PROCESS');
	return $processid;
}

sub filter_adapt {
	my $db = shift;
	my %data;
	$data{'camera_thread'} = &prompt({default=>'', prompt=>'What diameter thread faces the camera on this filter adapter?', type=>'decimal'});
	$data{'filter_thread'} = &prompt({default=>'', prompt=>'What diameter thread faces the filter on this filter adapter?', type=>'decimal'});
	my $filteradapterid = &newrecord($db, \%data, 'FILTER_ADAPTER');
	return $filteradapterid;
}

sub manufacturer_add {
	my $db = shift;
	my %data;
	$data{'manufacturer'} = &prompt({default=>'', prompt=>'What is the name of the manufacturer?', type=>'text'});
	$data{'country'} = &prompt({default=>'', prompt=>'What country is the manufacturer based in?', type=>'text'});
	$data{'city'} = &prompt({default=>'', prompt=>'What city is the manufacturer based in?', type=>'text'});
	$data{'url'} = &prompt({default=>'', prompt=>'What is the main website of the manufacturer?', type=>'text'});
	$data{'founded'} = &prompt({default=>'', prompt=>'When was the manufacturer founded?', type=>'integer'});
	$data{'dissolved'} = &prompt({default=>'', prompt=>'When was the manufacturer dissolved?', type=>'integer'});
	my $manufacturerid = &newrecord($db, \%data, 'MANUFACTURER');
	return $manufacturerid;
}

sub accessory_add {
	my $db = shift;
	my %data;
	$data{'accessory_type_id'} = &listchoices({db=>$db, query=>"select accessory_type_id as id, accessory_type as opt from ACCESSORY_TYPE", inserthandler=>\&accessory_type});
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'model'} = &prompt({default=>'', prompt=>'What is the model of this accessory?', type=>'text'});
	$data{'acquired'} = &prompt({default=>&today($db), prompt=>'When was this accessory acquired?', type=>'date'});
	$data{'cost'} = &prompt({default=>'', prompt=>'What did this accessory cost?', type=>'decimal'});
	my $accessoryid = &newrecord($db, \%data, 'ACCESSORY');

	if (&prompt({default=>'yes', prompt=>'Add camera compatibility info for this accessory?', type=>'boolean'})) {
		while (1) {
			my %compatdata;
			$compatdata{'accessory_id'} = $accessoryid;
			$compatdata{'camera_id'} = &listchoices({db=>$db, query=>"select * from choose_camera"});
			&newrecord($db, \%compatdata, 'ACCESSORY_COMPAT');
			if (!&prompt({default=>'yes', prompt=>'Add another compatible camera?', type=>'boolean'})) {
				last;
			}
		}
	}
	if (&prompt({default=>'yes', prompt=>'Add lens compatibility info for this accessory?', type=>'boolean'})) {
		while (1) {
			my %compatdata;
			$compatdata{'accessory_id'} = $accessoryid;
			$compatdata{'lens_id'} = &listchoices({db=>$db, query=>"select * from choose_lens"});
			&newrecord($db, \%compatdata, 'ACCESSORY_COMPAT');
			if (!&prompt({default=>'yes', prompt=>'Add another compatible lens?', type=>'boolean'})) {
				last;
			}
		}
	}
	return $accessoryid;
}

sub accessory_type {
	my $db = shift;
	my %data;
	$data{'accessory_type'} = &prompt({default=>'', prompt=>'What type of accessory do you want to add?', type=>'text'});
	my $accessorytypeid = &newrecord($db, \%data, 'ACCESSORY_TYPE');
	return $accessorytypeid;
}

sub enlarger_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'enlarger'} = &prompt({default=>'', prompt=>'What is the model of this enlarger?', type=>'text'});
	$data{'negative_size_id'} = &listchoices({db=>$db, query=>"select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE", inserthandler=>\&negativesize_add});
	$data{'introduced'} = &prompt({default=>'', prompt=>'What year was this enlarger introduced?', type=>'integer'});
	$data{'discontinued'} = &prompt({default=>'', prompt=>'What year was this enlarger discontinued?', type=>'integer'});
	$data{'acquired'} = &prompt({default=>&today($db), prompt=>'Purchase date', type=>'date'});
	$data{'cost'} = &prompt({default=>'', prompt=>'Purchase price', type=>'decimal'});
	my $enlarger_id = &newrecord($db, \%data, 'ENLARGER');
	return $enlarger_id;
}

sub enlarger_sell {
	my $db = shift;
	my %data;
	my $enlarger_id = shift || &listchoices({db=>$db, query=>"select * from choose_enlarger"});
	$data{'lost'} = &prompt({default=>&today($db), prompt=>'What date was this enlarger sold?', type=>'date'});
	$data{'lost_price'} = &prompt({default=>'', prompt=>'How much did this enlarger sell for?', type=>'decimal'});
	&updaterecord($db, \%data, 'ENLARGER', "enlarger_id=$enlarger_id");
}

sub flash_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'model'} = &prompt({default=>'', prompt=>'What is the model of this flash?', type=>'text'});
	$data{'guide_number'} = &prompt({default=>'', prompt=>'What is the guide number of this flash?', type=>'integer'});
	$data{'gn_info'} = &prompt({default=>'ISO 100', prompt=>'What are the conditions of the guide number?', type=>'text'});
	$data{'battery_powered'} = &prompt({default=>'yes', prompt=>'Is this flash battery-powered?', type=>'boolean'});
	if ($data{'battery_powered'} == 1) {
		$data{'battery_type_id'} = &listchoices({db=>$db, keyword=>'battery type', query=>"select * from choose_battery", inserthandler=>\&battery_add});
		$data{'battery_qty'} = &prompt({default=>'', prompt=>'How many batteries does this flash need?', type=>'integer'});
	}
	$data{'pc_sync'} = &prompt({default=>'yes', prompt=>'Does this flash have a PC sync socket?', type=>'boolean'});
	$data{'hot_shoe'} = &prompt({default=>'yes', prompt=>'Does this flash have a hot shoe connector?', type=>'boolean'});
	$data{'light_stand'} = &prompt({default=>'yes', prompt=>'Can this flash be fitted onto a light stand?', type=>'boolean'});
	$data{'manual_control'} = &prompt({default=>'yes', prompt=>'Does this flash have manual power control?', type=>'boolean'});
	$data{'swivel_head'} = &prompt({default=>'yes', prompt=>'Does this flash have a left/right swivel head?', type=>'boolean'});
	$data{'tilt_head'} = &prompt({default=>'yes', prompt=>'Does this flash have an up/down tilt head?', type=>'boolean'});
	$data{'zoom'} = &prompt({default=>'yes', prompt=>'Does this flash have a zoom head?', type=>'boolean'});
	$data{'dslr_safe'} = &prompt({default=>'yes', prompt=>'Is this flash safe to use on a DSLR?', type=>'boolean'});
	$data{'ttl'} = &prompt({default=>'yes', prompt=>'Does this flash support TTL metering?', type=>'boolean'});
	if ($data{'ttl'} == 1) {
		$data{'flash_protocol_id'} = &listchoices({db=>$db, keyword=>'flash protocol', query=>"SELECT flash_protocol_id as id, concat(manufacturer, ' ', name) as opt FROM FLASH_PROTOCOL, MANUFACTURER where FLASH_PROTOCOL.manufacturer_id=MANUFACTURER.manufacturer_id"});
	}
	$data{'trigger_voltage'} = &prompt({default=>'', prompt=>'What is the measured trigger voltage?', type=>'decimal'});
	$data{'own'} = 1;
	$data{'acquired'} = &prompt({default=>&today($db), prompt=>'When was it acquired?', type=>'date'});
	$data{'cost'} = &prompt({default=>'', prompt=>'What did this flash cost?', type=>'decimal'});
	my $flashid = &newrecord($db, \%data, 'FLASH');
	return $flashid;
}

sub battery_add {
	my $db = shift;
	my %data;
	$data{'battery_name'} = &prompt({default=>'', prompt=>'What is the name of this battery?', type=>'text'});
	$data{'voltage'} = &prompt({default=>'', prompt=>'What is the nominal voltage of this battery?', type=>'decimal'});
	$data{'chemistry'} = &prompt({default=>'', prompt=>'What type of chemistry is this battery based on?', type=>'text'});
	$data{'other_names'} = &prompt({default=>'', prompt=>'Does this type of battery go by any other names?', type=>'text'});
	my $batteryid = &newrecord($db, \%data, 'BATTERY');
	return $batteryid;
}

sub format_add {
	my $db = shift;
	my %data;
	$data{'format'} = &prompt({default=>'', prompt=>'What is the name of this film format?', type=>'text'});
	$data{'digital'} = &prompt({default=>'no', prompt=>'Is this a digital format?', type=>'boolean'});
	my $formatid = &newrecord($db, \%data, 'FORMAT');
	return $formatid;
}

sub negativesize_add {
	my $db = shift;
	my %data;
	$data{'negative_size'} = &prompt({default=>'', prompt=>'What is the name of this negative size?', type=>'text'});
	$data{'width'} = &prompt({default=>'', prompt=>'What is the width of this negative size in mm?', type=>'decimal'});
	$data{'height'} = &prompt({default=>'', prompt=>'What is the height of this negative size in mm?', type=>'decimal'});
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
	$data{'lens_mount'} = &listchoices({db=>$db, keyword=>'lens-facing mount', query=>"select mount_id as id, mount as opt from MOUNT where purpose='Camera'", type=> 'integer', inserthandler=>\&mount_add});
	$data{'camera_mount'} = &listchoices({db=>$db, keyword=>'camera-facing mount', query=>"select mount_id as id, mount as opt from MOUNT where purpose='Camera'", inserthandler=>\&mount_add});
	$data{'has_optics'} = &prompt({default=>'', prompt=>'Does this mount adapter have corrective optics?', type=>'boolean'});
	$data{'infinity_focus'} = &prompt({default=>'', prompt=>'Does this mount adapter have infinity focus?', type=>'boolean'});
	$data{'notes'} = &prompt({default=>'', prompt=>'Notes', type=>'text'});
	my $mountadapterid = &newrecord($db, \%data, 'MOUNT_ADAPTER');
	return $mountadapterid;
}

sub lightmeter_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'model'} = &prompt({default=>'', prompt=>'What is the model of this light meter?', type=>'text'});
	$data{'metering_type'} = &listchoices({db=>$db, query=>"select metering_type_id as id, metering as opt from METERING_TYPE", inserthandler=>\&meteringtype_add});
	$data{'reflected'} = &prompt({default=>'', prompt=>'Can this meter take reflected light readings?', type=>'boolean'});
	$data{'incident'} = &prompt({default=>'', prompt=>'Can this meter take incident light readings?', type=>'boolean'});
	$data{'spot'} = &prompt({default=>'', prompt=>'Can this meter take spot readings?', type=>'boolean'});
	$data{'flash'} = &prompt({default=>'', prompt=>'Can this meter take flash readings?', type=>'boolean'});
	$data{'min_asa'} = &prompt({default=>'', prompt=>'What\'s the lowest ISO/ASA setting this meter supports?', type=>'integer'});
	$data{'max_asa'} = &prompt({default=>'', prompt=>'What\'s the highest ISO/ASA setting this meter supports?', type=>'integer'});
	$data{'min_lv'} = &prompt({default=>'', prompt=>'What\'s the lowest light value (LV) reading this meter can give?', type=>'integer'});
	$data{'max_lv'} = &prompt({default=>'', prompt=>'What\'s the highest light value (LV) reading this meter can give?', type=>'integer'});
	my $lightmeterid = &newrecord($db, \%data, 'LIGHT_METER');
	return $lightmeterid;
}

sub camera_addbodytype {
	my $db = shift;
	my %data;
	$data{'body_type'} = &prompt({default=>'', prompt=>'Enter new camera body type', type=>'text'});
	my $bodytypeid = &newrecord($db, \%data, 'BODY_TYPE');
	return $bodytypeid;
}

sub archive_add {
	my $db = shift;
	my %data;
	$data{'archive_type_id'} = &listchoices({db=>$db, query=>"select archive_type_id as id, archive_type as opt from ARCHIVE_TYPE"});
	$data{'name'} = &prompt({default=>'', prompt=>'What is the name of this archive?', type=>'text'});
	$data{'max_width'} = &prompt({default=>'', prompt=>'What is the maximum width of media that this archive can accept (if applicable)?', type=>'text'});
	$data{'max_height'} = &prompt({default=>'', prompt=>'What is the maximum height of media that this archive can accept (if applicable)?', type=>'text'});
	$data{'location'} = &prompt({default=>'', prompt=>'What is the location of this archive?', type=>'text'});
	$data{'storage'} = &prompt({default=>'', prompt=>'What is the storage type of this archive? (e.g. box, folder, ringbinder, etc)', type=>'text'});
	$data{'sealed'} = &prompt({default=>'no', prompt=>'Is this archive sealed (closed to new additions)?', type=>'boolean'});
	my $archiveid = &newrecord($db, \%data, 'ARCHIVE');
	return $archiveid;
}

sub archive_films {
	my $db = shift;
	my %data;
	my $minfilm = &prompt({default=>'', prompt=>'What is the lowest film ID in the range?', type=>'integer'});
	my $maxfilm = &prompt({default=>'', prompt=>'What is the highest film ID in the range?', type=>'integer'});
	if (($minfilm =~ m/^\d+$/) && ($maxfilm =~ m/^\d+$/)) {
		if ($maxfilm le $minfilm) {
			print "Highest film ID must be higher than lowest film ID\n";
			exit;
		}
	} else {
		print "Must provide highest and lowest film IDs\n";
		exit;
	}
	$data{'archive_id'} = &listchoices({db=>$db, query=>"select archive_id as id, name as opt from ARCHIVE where archive_type_id in (1,2) and sealed = 0", inserthandler=>\&archive_add});
	&updaterecord($db, \%data, 'FILM', "film_id >= $minfilm and film_id <= $maxfilm and archive_id is null");
}

sub archive_list {
	my $db = shift;
	my $archive_id = &listchoices({db=>$db, query=>"select archive_id as id, name as opt from ARCHIVE"});
	my $archive_name = &lookupval($db, "select name from ARCHIVE where archive_id=$archive_id");
	my $query = "select * from (select concat('Film #', film_id) as id, notes as opt from FILM where archive_id=$archive_id union select concat('Print #', print_id) as id, description as opt from PRINT, NEGATIVE where PRINT.negative_id=NEGATIVE.negative_id and archive_id=$archive_id) as test order by id;";
	&printlist($db, "items in archive $archive_name", $query);
}

sub archive_seal {
	my $db = shift;
	my %data;
	my $archive_id = &listchoices({db=>$db, query=>"select archive_id as id, name as opt from ARCHIVE where sealed = 0"});
	$data{'sealed'} = 1;
	&updaterecord($db, \%data, 'ARCHIVE', "archive_id = $archive_id");
}

sub archive_unseal {
	my $db = shift;
	my %data;
	my $archive_id = &listchoices({db=>$db, query=>"select archive_id as id, name as opt from ARCHIVE where sealed = 1"});
	$data{'sealed'} = 0;
	&updaterecord($db, \%data, 'ARCHIVE', "archive_id = $archive_id");
}

sub archive_move {
	my $db = shift;
	my %data;
	my $archive_id = shift || &listchoices({db=>$db, query=>"select archive_id as id, name as opt from ARCHIVE"});
	my $oldlocation = &lookupval($db, "select location from ARCHIVE where archive_id = $archive_id");
	$data{'location'} = &prompt({default=>$oldlocation, prompt=>'What is the new location of this archive?', type=>'text'});
	&updaterecord($db, \%data, 'ARCHIVE', "archive_id = $archive_id");
}

sub shuttertype_add {
	my $db = shift;
	my %data;
	$data{'shutter_type'} = &prompt({default=>'', prompt=>'What type of shutter do you want to add?', type=>'text'});
	my $id = &newrecord($db, \%data, 'SHUTTER_TYPE');
	return $id;
}

sub focustype_add {
	my $db = shift;
	my %data;
	$data{'focus_type'} = &prompt({default=>'', prompt=>'What type of focus system do you want to add?', type=>'text'});
	my $id = &newrecord($db, \%data, 'FOCUS_TYPE');
	return $id;
}

sub flashprotocol_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'name'} = &prompt({default=>'', prompt=>'What flash protocol do you want to add?', type=>'text'});
	my $id = &newrecord($db, \%data, 'FLASH_PROTOCOL');
	return $id;
}

sub meteringtype_add {
	my $db = shift;
	my %data;
	$data{'metering'} = &prompt({default=>'', prompt=>'What type of metering system do you want to add?', type=>'text'});
	my $id = &newrecord($db, \%data, 'METERING_TYPE');
	return $id;
}

sub shutterspeed_add {
	my $db = shift;
	my %data;
	$data{'shutter_speed'} = &prompt({default=>'', prompt=>'What shutter speed do you want to add?', type=>'text'});
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
	$data{'name'} = &prompt({default=>'', prompt=>'What is this person\'s name?', type=>'text'});
	my $id = &newrecord($db, \%data, 'PERSON');
	return $id;
}

sub projector_add {
	my $db = shift;
	my %data;
	$data{'manufacturer_id'} = &listchoices({db=>$db, query=>"select manufacturer_id as id, manufacturer as opt from MANUFACTURER", inserthandler=>\&manufacturer_add});
	$data{'model'} = &prompt({default=>'', prompt=>'What is the model of this projector?', type=>'text'});
	$data{'mount_id'} = &listchoices({db=>$db, query=>"select mount_id as id, mount as opt from MOUNT where purpose='Projector'", inserthandler=>\&mount_add});
	$data{'negative_size_id'} = &listchoices({db=>$db, query=>"select negative_size_id as id, negative_size as opt from NEGATIVE_SIZE", inserthandler=>\&negativesize_add});
	$data{'own'} = 1;
	$data{'cine'} = &prompt({default=>'', prompt=>'Is this a cine/movie projector?', type=>'boolean'});
	my $id = &newrecord($db, \%data, 'PROJECTOR');
	return $id;
}

sub movie_add {
	my $db = shift;
	my %data;
	$data{'title'} = &prompt({default=>'', prompt=>'What is the title of this movie?', type=>'text'});
	$data{'camera_id'} = &listchoices({db=>$db, query=>"select C.camera_id as id, concat(M.manufacturer, ' ', C.model) as opt from CAMERA as C, MANUFACTURER as M where C.manufacturer_id=M.manufacturer_id and own=1 and video=1 and digital=0 order by opt"});
	if (&lookupval($db, "select fixed_mount from CAMERA where camera_id = $data{'camera_id'}")) {
		$data{'lens_id'} = &lookupval($db, "select lens_id from CAMERA where camera_id = $data{'camera_id'}");
	} else {
		$data{'lens_id'} = &listchoices({db=>$db, query=>"select * from choose_lens"});
	}
	$data{'format_id'} = &listchoices({db=>$db, query=>"select format_id as id, format as opt from FORMAT", inserthandler=>\&format_add});
	$data{'sound'} = &prompt({default=>'', prompt=>'Does this movie have sound?', type=>'boolean'});
	$data{'fps'} = &prompt({default=>'', prompt=>'What is the framerate of this movie in fps?', type=>'integer'});
	$data{'filmstock_id'} = &listchoices({db=>$db, query=>"select * from choose_filmstock", inserthandler=>\&filmstock_add});
	$data{'feet'} = &prompt({default=>'', prompt=>'What is the length of this movie in feet?', type=>'integer'});
	$data{'date_loaded'} = &prompt({default=>&today($db), prompt=>'What date was the film loaded?', type=>'date'});
	$data{'date_shot'} = &prompt({default=>&today($db), prompt=>'What date was the movie shot?', type=>'date'});
	$data{'date_processed'} = &prompt({default=>&today($db), prompt=>'What date was the movie processed?', type=>'date'});
	$data{'process_id'} = &listchoices({db=>$db, keyword=>'process', query=>'SELECT process_id as id, name as opt FROM photography.PROCESS', inserthandler=>\&process_add});
	$data{'description'} = &prompt({default=>'', prompt=>'Please enter a description of the movie', type=>'text'});
	my $id = &newrecord($db, \%data, 'MOVIE');
}

sub audit_shutterspeeds {
	my $db = shift;
	my $cameraid = &listchoices({db=>$db, keyword=>'camera without shutter speed data', query=>"select * from choose_camera_without_shutter_data"});
	 &camera_shutterspeeds($db, $cameraid);
}

sub audit_exposureprograms {
	my $db = shift;
	my $cameraid = &listchoices({db=>$db, keyword=>'camera without exposure program data', query=>"select * from choose_camera_without_exposure_programs"});
	 &camera_exposureprogram($db, $cameraid);
}

sub audit_meteringmodes {
	my $db = shift;
	my $cameraid = &listchoices({db=>$db, keyword=>'camera without metering mode data', query=>"select * from choose_camera_without_metering_data"});
	&camera_meteringmode($db, $cameraid);
}

sub exhibition_add {
	my $db = shift;
	my %data;
	$data{'title'} = &prompt({default=>'', prompt=>'What is the title of this exhibition?', type=>'text'});
	$data{'location'} = &prompt({default=>'', prompt=>'Where is this exhibition?', type=>'text'});
	$data{'start_date'} = &prompt({default=>'', prompt=>'What date does the exhibition start?', type=>'date'});
	$data{'end_date'} = &prompt({default=>'', prompt=>'What date does the exhibition end?', type=>'date'});
	my $id = &newrecord($db, \%data, 'EXHIBITION');
}

sub exhibition_review {
	my $db = shift;
	my $exhibition_id = &listchoices({db=>$db, query=>"select exhibition_id as id, title as opt from EXHIBITION"});
	my $title = &lookupval($db, "select title from EXHIBITION where exhibition_id=$exhibition_id");

	my $query = "select PRINT.print_id as id, concat(description, ' (', displaysize(PRINT.width, PRINT.height), ')') as opt from NEGATIVE join PRINT on PRINT.negative_id=NEGATIVE.negative_id join EXHIBIT on EXHIBIT.print_id=PRINT.print_id join EXHIBITION on EXHIBITION.exhibition_id=EXHIBIT.exhibition_id where EXHIBITION.exhibition_id=$exhibition_id";

	  &printlist($db, "prints exhibited at $title", $query);
}

sub task_run {
	my $db = shift;

	my @tasks = @queries::tasks;
	for my $i (0 .. $#tasks) {
		print "\t$i\t$tasks[$i]{'desc'}\n";
	}

	# Wait for input
	my $input = &prompt({default=>'', prompt=>"Please select a task", type=>'integer'});

	my $sql = $tasks[$input]{'query'};
	my $rows = &updatedata($db, $sql);
	print "Updated $rows rows\n";
}

# This ensures the lib loads smoothly
1;
