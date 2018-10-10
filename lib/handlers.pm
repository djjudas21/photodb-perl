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
	camera_add camera_displaylens camera_sell camera_repair camera_addbodytype camera_stats camera_exposureprogram camera_shutterspeeds camera_accessory camera_meteringmode camera_info camera_choose camera_edit
	mount_add mount_view mount_adapt
	negative_add negative_bulkadd negative_stats negative_prints
	lens_add lens_sell lens_repair lens_stats lens_accessory lens_info lens_edit
	print_add print_tone print_sell print_order print_fulfil print_archive print_locate print_reprint print_exhibit print_label print_worklist
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
	choose_manufacturer
);

sub film_add {
	# Add a newly-purchased film
	my $db = shift;
	my %data;
	if (&prompt({default=>'no', prompt=>'Is this film bulk-loaded?', type=>'boolean'}) == 1) {
		# These are filled in only for bulk-loaded films
		$data{film_bulk_id} = &listchoices({db=>$db, table=>'choose_bulk_film'});
		$data{film_bulk_loaded} = &prompt({default=>&today($db), prompt=>'When was the film bulk-loaded?'});
		# These are deduced automagically for bulk-loaded films
		$data{film_batch} = &lookupval({db=>$db, col=>'batch', table=>'FILM_BULK', where=>{film_bulk_id=>$data{'film_bulk_id'}}});
		$data{film_expiry} = &lookupval({db=>$db, col=>'expiry', table=>'FILM_BULK', where=>{film_bulk_id=>$data{'film_bulk_id'}}});
		$data{purchase_date} = &lookupval({db=>$db, col=>'purchase_date', table=>'FILM_BULK', where=>{film_bulk_id=>$data{'film_bulk_id'}}});
		$data{filmstock_id} = &lookupval({db=>$db, col=>'filmstock_id', table=>'FILM_BULK', where=>{film_bulk_id=>$data{'film_bulk_id'}}});
		$data{format_id} = &lookupval({db=>$db, col=>'format_id', table=>'FILM_BULK', where=>{film_bulk_id=>$data{'film_bulk_id'}}});
	} else {
		# These are filled in only for standalone films
		$data{film_batch} = &prompt({prompt=>'Film batch number'});
		$data{film_expiry} = &prompt({prompt=>'Film expiry date', type=>'date'});
		$data{purchase_date} = &prompt({default=>&today($db), prompt=>'Purchase date', type=>'date'});
		$data{filmstock_id} = &listchoices({db=>$db, table=>'choose_filmstock', inserthandler=>\&filmstock_add});
		$data{format_id} = &listchoices({db=>$db, cols=>['format_id as id', 'format as opt'], table=>'FORMAT', inserthandler=>\&format_add});
	}
	$data{frames} = &prompt({prompt=>'How many frames?', type=>'integer'});
	$data{price} = &prompt({prompt=>'Purchase price', type=>'decimal'});
	my $filmid = &newrecord({db=>$db, data=>\%data, table=>'FILM'});
	if (&prompt({default=>'no', prompt=>'Load this film into a camera now?', type=>'boolean'})) {
		&film_load($db, $filmid);
	}
	return $filmid;
}

sub film_load {
	# Load a film into a camera
	my $db = shift;
	my $film_id = shift || &listchoices({db=>$db, table=>'choose_film_to_load'});
	my %data;
	$data{camera_id} = &listchoices({db=>$db, table=>'choose_camera_by_film', where=>{film_id=>$film_id}});
	$data{exposed_at} = &prompt({default=>&lookupval({db=>$db, col=>"iso", table=>'FILM join FILMSTOCK on FILM.filmstock_id=FILMSTOCK.filmstock_id', where=>{film_id=>$film_id}}), prompt=>'What ISO?', type=>'integer'});
	$data{date_loaded} = &prompt({default=>&today($db), prompt=>'What date was this film loaded?', type=>'date'});
	$data{notes} = &prompt({prompt=>'Notes'});
	&updaterecord({db=>$db, data=>\%data, table=>'FILM', where=>"film_id=$film_id"});
}

sub film_archive {
	# Archive a film for storage
	my $db = shift;
	my $film_id = shift || &prompt({prompt=>'Enter ID of film to archive', type=>'integer'});
	my %data;
	$data{archive_id} = &listchoices({db=>$db, table=>'ARCHIVE', cols=>['archive_id as id', 'name as opt'], where=>['archive_type_id in (1,2)', 'sealed = 0'], inserthandler=>\&archive_add});
	&updaterecord({db=>$db, data=>\%data, table=>'FILM', where=>"film_id=$film_id"});
}

sub film_develop {
	# Develop a film
	my $db = shift;
	my $film_id = shift || &listchoices({db=>$db, table=>'choose_film_to_develop'});
	my %data;
	$data{date} = &prompt({default=>&today($db), prompt=>'What date was this film processed?', type=>'date'});
	$data{developer_id} = &listchoices({db=>$db, table=>'DEVELOPER', cols=>['developer_id as id', 'name as opt'], where=>{'for_film'=>1}, inserthandler=>\&developer_add});
	$data{directory} = &prompt({prompt=>'What directory are these scans in?'});
	$data{photographer_id} = &listchoices({db=>$db, keyword=>'photographer', table=> 'PERSON', cols=>['person_id as id', 'name as opt'], inserthandler=>\&person_add});
	$data{dev_uses} = &prompt({prompt=>'How many previous uses has the developer had?', type=>'integer'});
	$data{dev_time} = &prompt({prompt=>'How long was the film developed for?', type=>'hh:mm:ss'});
	$data{dev_temp} = &prompt({prompt=>'What temperature was the developer?', type=>'decimal'});
	$data{dev_n} = &prompt({default=>0, prompt=>'What push/pull was used?', type=>'integer'});
	$data{development_notes} = &prompt({prompt=>'Any other development notes'});
	$data{processed_by} = &prompt({prompt=>'Who developed the film?'});
	&updaterecord({db=>$db, data=>\%data, table=>'FILM', where=>"film_id=$film_id"});
	if (&prompt({default=>'no', prompt=>'Archive this film now?', type=>'boolean'})) {
		&film_archive($db, $film_id);
	}
}

sub film_tag {
	# Write EXIF tags to a film
	my $db = shift;
	my $film_id = shift || &prompt({prompt=>'Which film do you want to write EXIF tags to?', type=>'integer'});
	if ($film_id eq '') {
		&prompt({default=>'no', prompt=>'This will write EXIF tags to ALL scans in the database. Are you sure?', type=>'boolean'}) or die "Aborted!\n";
	}
	&tag($db, $film_id);
}

sub film_locate {
	my $db = shift;
	my $film_id = shift || &prompt({prompt=>'Which film do you want to locate?', type=>'integer'});

	if (my $archiveid = &lookupval({db=>$db, col=>'archive_id', table=>'FILM', where=>{film_id=>$film_id}})) {
		my $archive = &lookupval({db=>$db, col=>"select concat(name, ' (', location, ')') as archive", table=>'ARCHIVE', where=>{archive_id=> $archiveid}});
		print "Film #${film_id} is in $archive\n";
	} else {
		print "The location of film #${film_id} is unknown\n";
	}
	exit;
}

sub film_bulk {
	my $db = shift;
	my %data;
	$data{filmstock_id} = &listchoices({db=>$db, table=>'choose_filmstock', inserthandler=>\&filmstock_add});
	$data{format_id} = &listchoices({db=>$db, cols=>['format_id as id', 'format as opt'], table=>'FORMAT', inserthandler=>\&format_add});
	$data{batch} = &prompt({prompt=>'Film batch number'});
	$data{expiry} = &prompt({prompt=>'Film expiry date', type=>'date'});
	$data{purchase_date} = &prompt({default=>&today($db), prompt=>'Purchase date', type=>'date'});
	$data{cost} = &prompt({prompt=>'Purchase price', type=>'decimal'});
	$data{source} = &prompt({prompt=>'Where was this bulk film purchased from?'});
	my $filmid = &newrecord({db=>$db, data=>\%data, table=>'FILM_BULK'});
	return $filmid;
}

sub film_annotate {
	my $db = shift;
	my $film_id = &prompt({prompt=>'Which film do you want to annotate?', type=>'integer'});
	&annotatefilm($db, $film_id);
}

sub camera_add {
	# Add a new camera
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{model} = &prompt({prompt=>'What model is the camera?'});
	$data{fixed_mount} = &prompt({prompt=>'Does this camera have a fixed lens?', type=>'boolean'});
	if (defined($data{fixed_mount}) && $data{fixed_mount} == 1) {
		# Get info about lens
		print "Please enter some information about the lens\n";
		$data{lens_id} = &lens_add($db);
	} else {
		$data{mount_id} = &listchoices({db=>$db, cols=>['mount_id as id', 'mount as opt'], table=>'MOUNT', where=>{purpose=>'Camera'}, inserthandler=>\&mount_add});
	}
	$data{format_id} = &listchoices({db=>$db, cols=>['format_id as id', 'format as opt'], table=>'FORMAT', inserthandler=>\&format_add});
	$data{focus_type_id} = &listchoices({db=>$db, cols=>['focus_type_id as id', 'focus_type as opt'], table=>'FOCUS_TYPE', inserthandler=>\&focustype_add});
	$data{metering} = &prompt({prompt=>'Does this camera have metering?', type=>'boolean'});
	if (defined($data{metering}) && $data{metering} == 1) {
		$data{coupled_metering} = &prompt({prompt=>'Is the metering coupled?', type=>'boolean'});
		$data{metering_type_id} = &listchoices({db=>$db, cols=>['metering_type_id as id', 'metering as opt'], table=>'METERING_TYPE', inserthandler=>\&meteringtype_add});
		$data{meter_min_ev} = &prompt({prompt=>'What\'s the lowest EV the meter can handle?', type=>'integer'});
		$data{meter_max_ev} = &prompt({prompt=>'What\'s the highest EV the meter can handle?', type=>'integer'});
	}
	$data{body_type_id} = &listchoices({db=>$db, cols=>['body_type_id as id', 'body_type as opt'], table=>'BODY_TYPE', inserthandler=>\&camera_addbodytype});
	$data{weight} = &prompt({prompt=>'What does it weigh? (g)', type=>'integer'});
	$data{acquired} = &prompt({default=>&today($db), prompt=>'When was it acquired?', type=>'date'});
	$data{cost} = &prompt({prompt=>'What did the camera cost?', type=>'decimal'});
	$data{introduced} = &prompt({prompt=>'What year was the camera introduced?', type=>'integer'});
	$data{discontinued} = &prompt({prompt=>'What year was the camera discontinued?', type=>'integer'});
	$data{serial} = &prompt({prompt=>'What is the camera\'s serial number?'});
	$data{datecode} = &prompt({prompt=>'What is the camera\'s datecode?'});
	$data{manufactured} = &prompt({prompt=>'When was the camera manufactured?', type=>'integer'});
	$data{own} = &prompt({default=>'yes', prompt=>'Do you own this camera?', type=>'boolean'});
	$data{negative_size_id} = &listchoices({db=>$db, cols=>['negative_size_id as id', 'negative_size as opt'], table=>'NEGATIVE_SIZE', inserthandler=>\&negativesize_add});
	$data{shutter_type_id} = &listchoices({db=>$db, cols=>['shutter_type_id as id', 'shutter_type as opt'], table=>'SHUTTER_TYPE', inserthandler=>\&shuttertype_add});
	$data{shutter_model} = &prompt({prompt=>'What is the shutter model?'});
	$data{cable_release} = &prompt({prompt=>'Does this camera have a cable release?', type=>'boolean'});
	$data{viewfinder_coverage} = &prompt({prompt=>'What is the viewfinder coverage?', type=>'integer'});
	$data{power_drive} = &prompt({prompt=>'Does this camera have power drive?', type=>'boolean'});
	if (defined($data{power_drive}) && $data{power_drive} == 1) {
		$data{continuous_fps} = &prompt({prompt=>'How many frames per second can this camera manage?', type=>'decimal'});
	}
	$data{video} = &prompt({default=>'no', prompt=>'Does this camera have a video/movie function?', type=>'boolean'});
	$data{digital} = &prompt({default=>'no', prompt=>'Is this a digital camera?', type=>'boolean'});
	$data{battery_qty} = &prompt({prompt=>'How many batteries does this camera take?', type=>'integer'});
	if (defined($data{battery_qty}) && $data{battery_qty} > 0) {
		$data{battery_type} = &listchoices({db=>$db, keyword=>'battery type', table=>'choose_battery', inserthandler=>\&battery_add});
	}
	$data{notes} = &prompt({prompt=>'Additional notes'});
	$data{source} = &prompt({prompt=>'Where was the camera acquired from?'});
	$data{min_shutter} = &prompt({prompt=>'What\'s the fastest shutter speed?'});
	$data{max_shutter} = &prompt({prompt=>'What\'s the slowest shutter speed?'});
	$data{bulb} = &prompt({prompt=>'Does the camera have bulb exposure mode?', type=>'boolean'});
	$data{time} = &prompt({prompt=>'Does the camera have time exposure mode?', type=>'boolean'});
	$data{min_iso} = &prompt({prompt=>'What\'s the lowest ISO the camera can do?', type=>'integer'});
	$data{max_iso} = &prompt({prompt=>'What\'s the highest ISO the camera can do?', type=>'integer'});
	$data{af_points} = &prompt({prompt=>'How many autofocus points does the camera have?', type=>'integer'});
	$data{int_flash} = &prompt({prompt=>'Does the camera have an internal flash?', type=>'boolean'});
	if (defined($data{int_flash}) && $data{int_flash} == 1) {
		$data{int_flash_gn} = &prompt({prompt=>'What\'s the guide number of the internal flash?', type=>'integer'});
	}
	$data{ext_flash} = &prompt({prompt=>'Does the camera support an external flash?', type=>'boolean'});
	if ($data{ext_flash} == 1) {
		$data{pc_sync} = &prompt({prompt=>'Does the camera have a PC sync socket?', type=>'boolean'});
		$data{hotshoe} = &prompt({prompt=>'Does the camera have a hot shoe?', type=>'boolean'});
	}
	if ($data{int_flash} == 1 || $data{ext_flash} == 1) {
		$data{coldshoe} = &prompt({prompt=>'Does the camera have a cold/accessory shoe?', type=>'boolean'});
		$data{x_sync} = &prompt({prompt=>'What\'s the X-sync speed?', type=>'text'});
		$data{flash_metering} = &listchoices({db=>$db, table=>'choose_flash_protocol', inserthandler=>\&flashprotocol_add});
	}
	$data{condition_id} = &listchoices({db=>$db, keyword=>'condition', cols=>['condition_id as id', 'name as opt'], table=>'`CONDITION`'});
	$data{oem_case} = &prompt({prompt=>'Do you have the original case for this camera?', type=>'boolean'});
	$data{dof_preview} = &prompt({prompt=>'Does this camera have a depth-of-field preview feature?', type=>'boolean'});
	$data{tripod} = &prompt({prompt=>'Does this camera have a tripod bush?', type=>'boolean'});
	if (defined($data{mount_id})) {
		$data{display_lens} = &listchoices({db=>$db, table=>'choose_display_lens', where=>{mount_id=>$data{mount_id}}});
	}
	my $cameraid = &newrecord({db=>$db, data=>\%data, table=>'CAMERA'});

	# Now we have a camera ID, we can insert rows in auxiliary tables
	if (&prompt({default=>'yes', prompt=>'Add exposure programs for this camera?', type=>'boolean'})) {
		&camera_exposureprogram($db, $cameraid);
	}

	if (&prompt({default=>'yes', prompt=>'Add metering modes for this camera?', type=>'boolean'})) {
		if ($data{metering}) {
			&camera_meteringmode($db, $cameraid);
		} else {
			my %mmdata = ('camera_id' => $cameraid, 'metering_mode_id' => 0);
			&newrecord({db=>$db, data=>\%mmdata, table=>'METERING_MODE_AVAILABLE'});
		}
	}

	if (&prompt({default=>'yes', prompt=>'Add shutter speeds for this camera?', type=>'boolean'})) {
		&camera_shutterspeeds($db, $cameraid);
	}

	if (&prompt({default=>'yes', prompt=>'Add accessory compatibility for this camera?', type=>'boolean'})) {
		&camera_accessory($db, $cameraid);
	}
	return $cameraid;
}

sub camera_edit {
	my $db = shift;
	my $camera_id = shift || &listchoices({db=>$db, table=>'choose_camera'});
	my $existing = &lookupcol({db=>$db, table=>'CAMERA', where=>{camera_id=>$camera_id}});
	$existing = @$existing[0];
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db, default=>$$existing{manufacturer_id}});
	$data{model} = &prompt({prompt=>'What model is the camera?', default=>$$existing{model}});
	$data{fixed_mount} = &prompt({prompt=>'Does this camera have a fixed lens?', type=>'boolean', default=>$$existing{fixed_mount}});
	if ($data{fixed_mount} == 1) {
		if ($$existing{lens_id} eq '') {
			# Get info about lens
			print "Please enter some information about the lens\n";
			$data{lens_id} = &lens_add($db);
		}
	} else {
		$data{mount_id} = &listchoices({db=>$db, cols=>['mount_id as id', 'mount as opt'], table=>'MOUNT', where=>{'purpose'=>'Camera'}, inserthandler=>\&mount_add, default=>$$existing{mount_id}});
	}
	$data{format_id} = &listchoices({db=>$db, cols=>['format_id as id', 'format as opt'], table=>'FORMAT', inserthandler=>\&format_add, default=>$$existing{format_id}});
	$data{focus_type_id} = &listchoices({db=>$db, cols=>['focus_type_id as id', 'focus_type as opt'], table=>'FOCUS_TYPE', inserthandler=>\&focustype_add, default=>$$existing{focus_type_id}});
	$data{metering} = &prompt({prompt=>'Does this camera have metering?', type=>'boolean', default=>$$existing{metering}});
	if ($data{metering} == 1) {
		$data{coupled_metering} = &prompt({prompt=>'Is the metering coupled?', type=>'boolean', default=>$$existing{coupled_metering}});
		$data{metering_type_id} = &listchoices({db=>$db, cols=>['metering_type_id as id', 'metering as opt'], table=>'METERING_TYPE', inserthandler=>\&meteringtype_add, default=>$$existing{metering_type_id}});
		$data{meter_min_ev} = &prompt({prompt=>'What\'s the lowest EV the meter can handle?', type=>'integer', default=>$$existing{meter_min_ev}});
		$data{meter_max_ev} = &prompt({prompt=>'What\'s the highest EV the meter can handle?', type=>'integer', default=>$$existing{meter_max_ev}});
	}
	$data{body_type_id} = &listchoices({db=>$db, cols=>['body_type_id as id', 'body_type as opt'], table=>'BODY_TYPE', inserthandler=>\&camera_addbodytypei, default=>$$existing{body_type_id}});
	$data{weight} = &prompt({prompt=>'What does it weigh? (g)', type=>'integer', default=>$$existing{weight}});
	$data{acquired} = &prompt({default=>$$existing{acquired}, prompt=>'When was it acquired?', type=>'date'});
	$data{cost} = &prompt({prompt=>'What did the camera cost?', type=>'decimal', default=>$$existing{cost}});
	$data{introduced} = &prompt({prompt=>'What year was the camera introduced?', type=>'integer', default=>$$existing{introduced}});
	$data{discontinued} = &prompt({prompt=>'What year was the camera discontinued?', type=>'integer', default=>$$existing{discontinued}});
	$data{serial} = &prompt({prompt=>'What is the camera\'s serial number?', default=>$$existing{serial}});
	$data{datecode} = &prompt({prompt=>'What is the camera\'s datecode?', default=>$$existing{datecode}});
	$data{manufactured} = &prompt({prompt=>'When was the camera manufactured?', type=>'integer', default=>$$existing{manufactured}});
	$data{own} = &prompt({default=>$$existing{own}, prompt=>'Do you own this camera?', type=>'boolean'});
	$data{negative_size_id} = &listchoices({db=>$db, cols=>['negative_size_id as id', 'negative_size as opt'], table=>'NEGATIVE_SIZE', inserthandler=>\&negativesize_add, default=>$$existing{negative_size_id}});
	$data{shutter_type_id} = &listchoices({db=>$db, cols=>['shutter_type_id as id', 'shutter_type as opt'], table=>'SHUTTER_TYPE', inserthandler=>\&shuttertype_add, default=>$$existing{shutter_type_id}});
	$data{shutter_model} = &prompt({prompt=>'What is the shutter model?', default=>$$existing{shutter_model}});
	$data{cable_release} = &prompt({prompt=>'Does this camera have a cable release?', type=>'boolean', default=>$$existing{cable_release}});
	$data{viewfinder_coverage} = &prompt({prompt=>'What is the viewfinder coverage?', type=>'integer', default=>$$existing{viewfinder_coverage}});
	$data{power_drive} = &prompt({prompt=>'Does this camera have power drive?', type=>'boolean', default=>$$existing{power_drive}});
	if ($data{power_drive} == 1) {
		$data{continuous_fps} = &prompt({prompt=>'How many frames per second can this camera manage?', type=>'decimal', default=>$$existing{continuous_fps}});
	}
	$data{video} = &prompt({default=>$$existing{video}, prompt=>'Does this camera have a video/movie function?', type=>'boolean'});
	$data{digital} = &prompt({default=>$$existing{digital}, prompt=>'Is this a digital camera?', type=>'boolean'});
	$data{battery_qty} = &prompt({prompt=>'How many batteries does this camera take?', type=>'integer', default=>$$existing{battery_qty}});
	if ($data{battery_qty} > 0) {
		$data{battery_type} = &listchoices({db=>$db, keyword=>'battery type', table=>'choose_battery', inserthandler=>\&battery_add, default=>$$existing{battery_type}});
	}
	$data{notes} = &prompt({prompt=>'Additional notes', default=>$$existing{notes}});
	$data{source} = &prompt({prompt=>'Where was the camera acquired from?', default=>$$existing{source}});
	$data{min_shutter} = &prompt({prompt=>'What\'s the fastest shutter speed?', default=>$$existing{min_shutter}});
	$data{max_shutter} = &prompt({prompt=>'What\'s the slowest shutter speed?', default=>$$existing{max_shutter}});
	$data{bulb} = &prompt({prompt=>'Does the camera have bulb exposure mode?', type=>'boolean', default=>$$existing{bulb}});
	$data{time} = &prompt({prompt=>'Does the camera have time exposure mode?', type=>'boolean', default=>$$existing{time}});
	$data{min_iso} = &prompt({prompt=>'What\'s the lowest ISO the camera can do?', type=>'integer', default=>$$existing{min_iso}});
	$data{max_iso} = &prompt({prompt=>'What\'s the highest ISO the camera can do?', type=>'integer', default=>$$existing{max_iso}});
	$data{af_points} = &prompt({prompt=>'How many autofocus points does the camera have?', type=>'integer'}, default=>$$existing{af_points});
	$data{int_flash} = &prompt({prompt=>'Does the camera have an internal flash?', type=>'boolean', default=>$$existing{int_flash}});
	if ($data{int_flash} == 1) {
		$data{int_flash_gn} = &prompt({prompt=>'What\'s the guide number of the internal flash?', type=>'integer', default=>$$existing{int_flash_gn}});
	}
	$data{ext_flash} = &prompt({prompt=>'Does the camera support an external flash?', type=>'boolean', default=>$$existing{ext_flash}});
	if ($data{ext_flash} == 1) {
		$data{pc_sync} = &prompt({prompt=>'Does the camera have a PC sync socket?', type=>'boolean', default=>$$existing{pc_sync}});
		$data{hotshoe} = &prompt({prompt=>'Does the camera have a hot shoe?', type=>'boolean', default=>$$existing{hotshoe}});
	}
	if ($data{int_flash} == 1 || $data{ext_flash} == 1) {
		$data{coldshoe} = &prompt({prompt=>'Does the camera have a cold/accessory shoe?', type=>'boolean', default=>$$existing{coldshoe}});
		$data{x_sync} = &prompt({prompt=>'What\'s the X-sync speed?', type=>'text', default=>$$existing{x_sync}});
		$data{flash_metering} = &listchoices({db=>$db, table=>'choose_flash_protocol', inserthandler=>\&flashprotocol_add, default=>$$existing{flash_metering}});
	}
	$data{condition_id} = &listchoices({db=>$db, keyword=>'condition', cols=>['condition_id as id', 'name as opt'], table=>'CONDITION', default=>$$existing{condition_id}});
	$data{oem_case} = &prompt({prompt=>'Do you have the original case for this camera?', type=>'boolean', default=>$$existing{oem_case}});
	$data{dof_preview} = &prompt({prompt=>'Does this camera have a depth-of-field preview feature?', type=>'boolean', default=>$$existing{dof_preview}});
	$data{tripod} = &prompt({prompt=>'Does this camera have a tripod bush?', type=>'boolean', default=>$$existing{tripod}});
	if (defined($data{mount_id})) {
		$data{display_lens} = &listchoices({db=>$db, table=>'choose_display_lens', where=>{mount_id=>$data{mount_id}}});
	}

	# Compare new and old data to find changed fields
	my %changes;
	my $thindata = &thin(\%data);
	foreach my $key (keys %$thindata) {
		if (!defined($$existing{$key}) || $data{$key} ne $$existing{$key}) {
			$changes{$key} = $data{$key};
		}
	}
	&updaterecord({db=>$db, data=>\%changes, table=>'CAMERA', where=>"camera_id=$camera_id"});
}

sub camera_accessory {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, table=>'choose_camera'});
	while (1) {
		my %compatdata;
		$compatdata{accessory_id} = &listchoices({db=>$db, table=>'choose_accessory'});
		$compatdata{camera_id} = $cameraid;
		&newrecord({db=>$db, data=>\%compatdata, table=>'ACCESSORY_COMPAT'});
		if (!&prompt({default=>'yes', prompt=>'Add more accessory compatibility info?', type=>'boolean'})) {
			last;
		}
	}
}

sub camera_shutterspeeds {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, table=>'choose_camera'});
	while (1) {
		my %shutterdata;
		$shutterdata{shutter_speed} = &listchoices({db=>$db, keyword=>'shutter speed', query=>"SELECT shutter_speed as id, '' as opt FROM photography.SHUTTER_SPEED where shutter_speed not in ('B', 'T') and shutter_speed not in (select shutter_speed from SHUTTER_SPEED_AVAILABLE where camera_id=$cameraid) order by duration", type=>'text', insert_handler=>\&shutterspeed_add});
		$shutterdata{camera_id} = $cameraid;
		&newrecord({db=>$db, data=>\%shutterdata, table=>'SHUTTER_SPEED_AVAILABLE'});
		if (!&prompt({default=>'yes', prompt=>'Add another shutter speed?', type=>'boolean'})) {
			last;
		}
	}
}

sub camera_exposureprogram {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, table=>'choose_camera'});
	my $exposureprograms = &lookupcol({db=>$db, table=>'EXPOSURE_PROGRAM'});
	foreach my $exposureprogram (@$exposureprograms) {
		# Skip 'creative' AE modes
		next if $exposureprogram->{exposure_program_id} == 5;
		next if $exposureprogram->{exposure_program_id} == 6;
		next if $exposureprogram->{exposure_program_id} == 7;
		next if $exposureprogram->{exposure_program_id} == 8;
		if (&prompt({default=>'no', prompt=>"Does this camera have $exposureprogram->{exposure_program} exposure program?", type=>'boolean'})) {
			my %epdata = ('camera_id' => $cameraid, 'exposure_program_id' => $exposureprogram->{exposure_program_id});
			&newrecord({db=>$db, data=>\%epdata, table=>'EXPOSURE_PROGRAM_AVAILABLE'});
			last if $exposureprogram->{exposure_program_id} == 0;
		}
	}
}

sub camera_meteringmode {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, table=>'choose_camera'});
	my $meteringmodes = &lookupcol({db=>$db, table=>'METERING_MODE'});
	foreach my $meteringmode (@$meteringmodes) {
		if (&prompt({default=>'no', prompt=>"Does this camera have $meteringmode->{metering_mode} metering?", type=>'boolean'})) {
			my %mmdata = ('camera_id' => $cameraid, 'metering_mode_id' => $meteringmode->{metering_mode_id});
			&newrecord({db=>$db, data=>\%mmdata, table=>'METERING_MODE_AVAILABLE'});
			last if $meteringmode->{metering_mode_id} == 0;
		}
	}
}

sub camera_displaylens {
	my $db = shift;
	my %data;
	my $camera_id = shift || &listchoices({db=>$db, keyword=>'camera', table=>'choose_camera', where=>{mount_id=>{'!=', undef}}});
	my $mount = &lookupval({db=>$db, col=>'mount_id', table=>'CAMERA', where=>{camera_id=>$camera_id}});
	$data{display_lens} = &listchoices({db=>$db, table=>'choose_display_lens', where=>{camera_id=>[$camera_id, undef], mount_id=>$mount}, default=>&lookupval({db=>$db, col=>'display_lens', table=>'CAMERA', where=>{camera_id=>$camera_id}})});
	&updaterecord({db=>$db, data=>\%data, table=>'CAMERA', where=>"camera_id=$camera_id"});
}

sub camera_sell {
	my $db = shift;
	my $cameraid = shift || &listchoices({db=>$db, table=>'choose_camera'});
	my %data;
	$data{own} = 0;
	$data{lost} = &prompt({default=>&today($db), prompt=>'What date was this camera sold?', type=>'date'});
	$data{lost_price} = &prompt({prompt=>'How much did this camera sell for?', type=>'decimal'});
	&updaterecord({db=>$db, data=>\%data, table=>'CAMERA', where=>"camera_id=$cameraid"});
	if (&lookupval({db=>$db, col=>'fixed_mount', table=>'CAMERA', where=>{camera_id=>$cameraid}})) {
		my $lensid = &lookupval({db=>$db, col=>'lens_id', table=>'CAMERA', where=>{camera_id=>$cameraid}});
		if ($lensid) {
			my %lensdata;
			$lensdata{own} = 0;
			$lensdata{lost} = $data{lost};
			$lensdata{lost_price} = 0;
			&updaterecord({db=>$db, data=>\%lensdata, table=>'LENS', where=>"lens_id=$lensid"});
		}
	}
}

sub camera_repair {
	my $db = shift;
	my %data;
	$data{camera_id} = shift || &listchoices({db=>$db, table=>'choose_camera'});
	$data{date} = &prompt({default=>&today($db), prompt=>'What date was this camera repaired?', type=>'date'});
	$data{summary} = &prompt({prompt=>'Short summary of repair'});
	$data{description} = &prompt({prompt=>'Longer description of repair'});
	my $repair_id = &newrecord({db=>$db, data=>\%data, table=>'REPAIR'});
	return $repair_id;
}

sub camera_info {
	my $db = shift;
	my $camera_id = &listchoices({db=>$db, table=>'choose_camera'});
	my $cameradata = &lookupcol({db=>$db, table=>'camera_summary', where=>{'`Camera ID`'=>$camera_id}});
	print Dump($cameradata);
}

sub camera_stats {
	my $db = shift;
	my $camera_id = &listchoices({db=>$db, table=>'choose_camera'});
	my $camera = &lookupval({db=>$db, col=>"concat(manufacturer, ' ',model) as opt", table=>'CAMERA join MANUFACTURER on CAMERA.manufacturer_id=MANUFACTURER.manufacturer_id', where=>{camera_id=>$camera_id}});
	print "\tShowing statistics for $camera\n";
	my $total_shots_with_cam = &lookupval({db=>$db, col=>'count(*)', table=>'NEGATIVE join FILM on NEGATIVE.film_id=FILM.film_id', where=>{camera_id=>$camera_id}});
	my $total_shots = &lookupval({db=>$db, col=>'count(*)', table=>'NEGATIVE'});
	if ($total_shots > 0) {
		my $percentage = round(100 * $total_shots_with_cam / $total_shots);
		print "\tThis camera has been used to take $total_shots_with_cam frames, which is ${percentage}% of the frames in your collection\n";
	}
}

sub camera_choose {
	my $db = shift;
	my %where;
	$where{manufacturer_id} = &choose_manufacturer({db=>$db});
	$where{format_id} = &listchoices({db=>$db, cols=>['format_id as id', 'format as opt'], table=>'FORMAT'});
	$where{bulb} = &prompt({prompt=>'Do you need Bulb (B) shutter speed?', type=>'boolean'});
	$where{time} = &prompt({prompt=>'Do you need Time (T) shutter speed?', type=>'boolean'});
	$where{fixed_mount} = &prompt({prompt=>'Do you need a camera with an interchangeable lens?', type=>'boolean'});
	if ($where{fixed_mount} && $where{fixed_mount} != 1) {
		$where{mount_id} = &listchoices({db=>$db, cols=>['select mount_id as id', 'mount as opt'], table=>'MOUNT', where=>{'purpose'=>'Camera'}});
	}
	$where{focus_type_id} = &listchoices({db=>$db, cols=>['focus_type_id as id', 'focus_type as opt'], table=>'FOCUS_TYPE', 'integer'});
	$where{metering} = &prompt({prompt=>'Do you need a camera with metering?', type=>'boolean'});
	if ($where{metering} && $where{metering} == 1) {
		$where{coupled_metering} = &prompt({prompt=>'Do you need coupled metering?', type=>'boolean'});
		$where{metering_type_id} = &listchoices({db=>$db, cols=>['metering_type_id as id', 'metering as opt'], table=>'METERING_TYPE'});
	}
	$where{body_type_id} = &listchoices({db=>$db, cols=>['body_type_id as id', 'body_type as opt'], table=>'BODY_TYPE'});
	$where{negative_size_id} = &listchoices({db=>$db, cols=>['negative_size_id as id', 'negative_size as opt'], table=>'NEGATIVE_SIZE'});
	$where{cable_release} = &prompt({prompt=>'Do you need a camera with cable release?', type=>'boolean'});
	$where{power_drive} = &prompt({prompt=>'Do you need a camera with power drive?', type=>'boolean'});
	$where{int_flash} = &prompt({prompt=>'Do you need a camera with internal flash?', type=>'boolean'});
	$where{ext_flash} = &prompt({prompt=>'Do you need a camera that supports an external flash?', type=>'boolean'});
	if ($where{ext_flash} && $where{ext_flash} == 1) {
		$where{pc_sync} = &prompt({prompt=>'Do you need a PC sync socket?', type=>'boolean'});
		$where{hotshoe} = &prompt({prompt=>'Do you need a hot shoe?', type=>'boolean'});
	}
	if (($where{int_flash} && $where{int_flash} == 1) || ($where{ext_flash} && $where{ext_flash} == 1)) {
		$where{coldshoe} = &prompt({prompt=>'Do you need a cold/accessory shoe?', type=>'boolean'});
		$where{flash_metering} = &listchoices({db=>$db, table=>'choose_flash_protocol'});
	}
	$where{dof_preview} = &prompt({prompt=>'Do you need a depth-of-field preview feature?', type=>'boolean'});
	$where{tripod} = &prompt({prompt=>'Do you need a tripod bush?', type=>'boolean'});

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
	$data{film_id} = &prompt({prompt=>'Which film does this negative belong to?', type=>'integer'});
	if (!&lookupval({db=>$db, col=>'camera_id', table=>'FILM', where=>{film_id=>$data{film_id}}})) {
		print 'Film must be loaded into a camera before you can add negatives\n';
		if (&prompt({default=>'yes', prompt=>'Load film into a camera now?', type=>'boolean'})) {
			&film_load($db, $data{film_id});
		} else {
			exit;
		}
	}
	$data{frame} = &prompt({prompt=>'Frame number'});
	$data{description} = &prompt({prompt=>'Caption'});
	$data{date} = &prompt({default=>&today($db), prompt=>'What date was this negative taken?', type=>'date'});
	$data{lens_id} = &listchoices({db=>$db, keyword=>'lens', table=>'choose_lens_by_film', where=>{film_id=>$data{film_id}}});
	$data{shutter_speed} = &listchoices({db=>$db, keyword=>'shutter speed', table=>'choose_shutter_speed_by_film', where=>{film_id=>$data{film_id}}, type=>'text'});
	$data{aperture} = &prompt({prompt=>'Aperture', type=>'decimal'});
	my $filter_dia = 0;
	if ($data{lens_id}) {
		$filter_dia = &lookupval($db, "select if(filter_thread, filter_thread, 0) from LENS where lens_id=$data{lens_id}");
	}
	$data{filter_id} = &listchoices({db=>$db, table=>'choose_filter', where=>{'thread'=>{'>=', $filter_dia}}, inserthandler=>\&filter_add, skipok=>1, autodefault=>0});
	$data{teleconverter_id} = &listchoices({db=>$db, keyword=>'teleconverter', table=>'choose_teleconverter_by_film', where=>{film_id=>$data{film_id}}, inserthandler=>\&teleconverter_add, skipok=>1, autodefault=>0});
	$data{notes} = &prompt({prompt=>'Extra notes'});
	$data{mount_adapter_id} = &listchoices({db=>$db, table=>'choose_mount_adapter_by_film', where=>{film_id=>$data{film_id}}});
	$data{focal_length} = &prompt({default=>&lookupval({db=>$db, col=>'min_focal_length', table=>'LENS', where=>{lens_id=>$data{'lens_id'}}}), prompt=>'Focal length', type=>'integer'});
	$data{latitude} = &prompt({prompt=>'Latitude', type=>'decimal'});
	$data{longitude} = &prompt({prompt=>'Longitude', type=>'decimal'});
	$data{flash} = &prompt({default=>'no', prompt=>'Was flash used?', type=>'boolean'});
	$data{metering_mode} = &listchoices({db=>$db, cols=>['metering_mode_id as id', 'metering_mode as opt'], table=>'METERING_MODE'});
	$data{exposure_program} = &listchoices({db=>$db, cols=>['exposure_program_id as id', 'exposure_program as opt'], table=>'EXPOSURE_PROGRAM'});
	$data{photographer_id} = &listchoices({db=>$db, keyword=>'photographer', cols=>['person_id as id', 'name as opt'], table=>'PERSON', inserthandler=>\&person_add});
	if (&prompt({prompt=>'Is this negative duplicated from another?', type=>'boolean', default=>'no'})) {
		$data{copy_of} = &chooseneg({db=>$db, oktoreturnundef=>1});
	}
	my $negativeid = &newrecord({db=>$db, data=>\%data, table=>'NEGATIVE'});
	return $negativeid;
}

sub negative_bulkadd {
	my $db = shift;
	# Add lots of negatives to a film, maybe asks if they were all shot with the same lens
	my %data;
	$data{film_id} = shift || &prompt({prompt=>'Bulk add negatives to which film?', type=>'integer'});
	my $num = &prompt({prompt=>'How many frames to add?', type=>'integer'});
	if (&prompt({default=>'no', prompt=>"Add any other attributes to all $num negatives?", type=>'boolean'})) {
		$data{description} = &prompt({prompt=>'Caption'});
		$data{date} = &prompt({default=>&today($db), prompt=>'What date was this negative taken?', type=>'date'});
		$data{lens_id} = &listchoices({db=>$db, keyword=>'lens', table=>'choose_lens_by_film', where=>{film_id=>$data{film_id}}});
		$data{shutter_speed} = &listchoices({db=>$db, keyword=>'shutter speed', table=>'choose_shutter_speed_by_film', where=>{film_id=>$data{film_id}}});
		$data{aperture} = &prompt({prompt=>'Aperture', type=>'decimal'});
		$data{filter_id} = &listchoices({db=>$db, table=>'choose_filter', inserthandler=>\&filter_add, skipok=>1, autodefault=>0});
		$data{teleconverter_id} = &listchoices({db=>$db, keyword=>'teleconverter', table=>'choose_teleconverter_by_film', where=>{film_id=>$data{film_id}}, inserthandler=>\&teleconverter_add, skipok=>1, autodefault=>0});
		$data{notes} = &prompt({prompt=>'Extra notes'});
		$data{mount_adapter_id} = &listchoices({db=>$db, table=>'choose_mount_adapter_by_film', where=>{film_id=>$data{film_id}}});
		$data{focal_length} = &prompt({default=>&lookupval({db=>$db, col=>'min_focal_length', table=>'LENS', where=>{lens_id=>$data{lens_id}}}), prompt=>'Focal length', type=>'integer'});
		$data{latitude} = &prompt({prompt=>'Latitude', type=>'decimal'});
		$data{longitude} = &prompt({prompt=>'Longitude', type=>'decimal'});
		$data{flash} = &prompt({default=>'no', prompt=>'Was flash used?', type=>'boolean'});
		$data{metering_mode} = &listchoices({db=>$db, cols=>['metering_mode_id as id', 'metering_mode as opt'], table=>'METERING_MODE'});
		$data{exposure_program} = &listchoices({db=>$db, cols=>['exposure_program_id as id', 'exposure_program as opt'], table=>'EXPOSURE_PROGRAM'});
		$data{photographer_id} = &listchoices({db=>$db, keyword=>'photographer', cols=>['person_id as id', 'name as opt'], table=>'PERSON', inserthandler=>\&person_add});
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
		$data{frame} = $i;

		# Generate an abstract object for this negative
		my($stmt, @bind) = $sql->insert('NEGATIVE', \%data);

		# Execute query
		my $sth = $db->prepare($stmt);
		$sth->execute(@bind);
	}

	print "Inserted $num negatives into film #$data{film_id}\n";
}

sub negative_stats {
	my $db = shift;
	my $neg_id = &chooseneg({db=>$db});
	my $noprints = &lookupval({db=>$db, col=>'count(*)', table=>'PRINT', where=>{negative_id=>$neg_id}});
	print "\tThis negative has been printed $noprints times\n";
}

sub negative_prints {
	my $db = shift;
	my $neg_id = &chooseneg({db=>$db});
	&printlist({db=>$db, msg=>"prints from negative $neg_id", table=>'print_locations', where=>{negative_id=>$neg_id}});
}

sub lens_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{model} = &prompt({prompt=>'What is the lens model?'});
	$data{zoom} = &prompt({prompt=>'Is this a zoom lens?', type=>'boolean', default=>&guesszoom($data{model})});
	if ($data{zoom} == 0) {
		$data{min_focal_length} = &prompt({prompt=>'What is the focal length?', type=>'integer', default=>&guessminfl($data{model})});
		$data{max_focal_length} = $data{min_focal_length};
	} else {
		$data{min_focal_length} = &prompt({prompt=>'What is the minimum focal length?', type=>'integer', default=>&guessminfl($data{model})});
		$data{max_focal_length} = &prompt({prompt=>'What is the maximum focal length?', type=>'integer', default=>&guessmaxfl($data{model})});
	}
	$data{fixed_mount} = &prompt({default=>'no', prompt=>'Does this lens have a fixed mount?', type=>'boolean'});
	if ($data{fixed_mount} == 0) {
		$data{mount_id} = &listchoices({db=>$db, cols=>['mount_id as id', 'mount as opt'], table=>'MOUNT', inserthandler=>\&mount_add});
	}
	$data{max_aperture} = &prompt({prompt=>'What is the largest lens aperture?', type=>'decimal', default=>&guessaperture($data{model})});
	$data{min_aperture} = &prompt({prompt=>'What is the smallest lens aperture?', type=>'decimal'});
	$data{closest_focus} = &prompt({prompt=>'How close can the lens focus? (cm)', type=>'integer'});
	$data{elements} = &prompt({prompt=>'How many elements does the lens have?', type=>'integer'});
	$data{groups} = &prompt({prompt=>'How many groups are these elements in?', type=>'integer'});
	$data{weight} = &prompt({prompt=>'What is the weight of the lens? (g)', type=>'integer'});
	$data{nominal_min_angle_diag} = &prompt({prompt=>'What is the minimum diagonal angle of view?', type=>'integer'});
	$data{nominal_max_angle_diag} = &prompt({prompt=>'What is the maximum diagonal angle of view?', type=>'integer'});
	$data{aperture_blades} = &prompt({prompt=>'How many aperture blades does the lens have?', type=>'integer'});
	$data{autofocus} = &prompt({prompt=>'Does this lens have autofocus?', type=>'boolean'});
	$data{filter_thread} = &prompt({prompt=>'What is the diameter of the filter thread? (mm)', type=>'decimal'});
	$data{magnification} = &prompt({prompt=>'What is the maximum magnification possible with this lens?', type=>'decimal'});
	$data{url} = &prompt({prompt=>'Informational URL for this lens'});
	$data{serial} = &prompt({prompt=>'What is the serial number of the lens?'});
	$data{date_code} = &prompt({prompt=>'What is the date code of the lens?'});
	$data{introduced} = &prompt({prompt=>'When was this lens introduced?', type=>'integer'});
	$data{discontinued} = &prompt({prompt=>'When was this lens discontinued?', type=>'integer'});
	$data{manufactured} = &prompt({prompt=>'When was this lens manufactured?', type=>'integer'});
	$data{negative_size_id} = &listchoices({db=>$db, cols=>['negative_size_id as id', 'negative_size as opt'], table=>'NEGATIVE_SIZE', inserthandler=>\&negativesize_add});
	$data{acquired} = &prompt({default=>&today($db), prompt=>'When was this lens acquired?', type=>'date'});
	$data{cost} = &prompt({prompt=>'How much did this lens cost?', type=>'decimal'});
	$data{notes} = &prompt({prompt=>'Notes'});
	$data{own} = &prompt({default=>'yes', prompt=>'Do you own this lens?', type=>'boolean'});
	$data{source} = &prompt({prompt=>'Where was this lens sourced from?'});
	$data{coating} = &prompt({prompt=>'What coating does this lens have?'});
	$data{hood} = &prompt({prompt=>'What is the model number of the suitable hood for this lens?'});
	$data{exif_lenstype} = &prompt({prompt=>'EXIF lens type code'});
	$data{rectilinear} = &prompt({default=>'yes', prompt=>'Is this a rectilinear lens?', type=>'boolean'});
	$data{length} = &prompt({prompt=>'How long is this lens? (mm)', type=>'integer'});
	$data{diameter} = &prompt({prompt=>'How wide is this lens? (mm)', type=>'integer'});
	$data{condition_id} = &listchoices({db=>$db, keyword=>'condition', cols=>['condition_id as id', 'name as opt'], table=>'CONDITION'});
	$data{image_circle} = &prompt({prompt=>'What is the diameter of the image circle?', type=>'integer'});
	$data{formula} = &prompt({prompt=>'Does this lens have a named optical formula?'});
	$data{shutter_model} = &prompt({prompt=>'What shutter does this lens incorporate?'});
	my $lensid = &newrecord({db=>$db, data=>\%data, table=>'LENS'});

	if (&prompt({default=>'yes', prompt=>'Add accessory compatibility for this lens?', type=>'boolean'})) {
		&lens_accessory($db, $lensid);
	}
	return $lensid;
}

sub lens_edit {
	my $db = shift;
	my %data;
	my $lensid = shift || &listchoices({db=>$db, table=>'choose_lens'});
	my $existing = &lookupcol({db=>$db, table=>'LENS', where=>{lens_id=>$lensid}});
	$existing = @$existing[0];
	$data{manufacturer_id} = &choose_manufacturer({db=>$db, default=>$$existing{manufacturer_id}});
	$data{model} = &prompt({prompt=>'What is the lens model?', default=>$$existing{model}});
	$data{zoom} = &prompt({prompt=>'Is this a zoom lens?', type=>'boolean', default=>$$existing{zoom}});
	if ($data{zoom} == 0) {
		$data{min_focal_length} = &prompt({prompt=>'What is the focal length?', type=>'integer', default=>$$existing{min_focal_length}});
		$data{max_focal_length} = $data{min_focal_length};
	} else {
		$data{min_focal_length} = &prompt({prompt=>'What is the minimum focal length?', type=>'integer', default=>$$existing{min_focal_length}});
		$data{max_focal_length} = &prompt({prompt=>'What is the maximum focal length?', type=>'integer', default=>$$existing{max_focal_length}});
	}
	$data{fixed_mount} = &prompt({prompt=>'Does this lens have a fixed mount?', type=>'boolean', default=>$$existing{fixed_mount}});
	if ($data{fixed_mount} == 0) {
		$data{mount_id} = &listchoices({db=>$db, cols=>['mount_id as id', 'mount as opt'], table=>'MOUNT', inserthandler=>\&mount_add, default=>$$existing{mount_id}});
	}
	$data{max_aperture} = &prompt({prompt=>'What is the largest lens aperture?', type=>'decimal', default=>$$existing{max_aperture}});
	$data{min_aperture} = &prompt({prompt=>'What is the smallest lens aperture?', type=>'decimal', default=>$$existing{min_aperture}});
	$data{closest_focus} = &prompt({prompt=>'How close can the lens focus? (cm)', type=>'integer', default=>$$existing{closest_focus}});
	$data{elements} = &prompt({prompt=>'How many elements does the lens have?', type=>'integer', default=>$$existing{elements}});
	$data{groups} = &prompt({prompt=>'How many groups are these elements in?', type=>'integer', default=>$$existing{groups}});
	$data{weight} = &prompt({prompt=>'What is the weight of the lens? (g)', type=>'integer', default=>$$existing{weight}});
	$data{nominal_min_angle_diag} = &prompt({prompt=>'What is the minimum diagonal angle of view?', type=>'integer', default=>$$existing{nominal_min_angle_diag}});
	$data{nominal_max_angle_diag} = &prompt({prompt=>'What is the maximum diagonal angle of view?', type=>'integer', default=>$$existing{nominal_max_angle_diag}});
	$data{aperture_blades} = &prompt({prompt=>'How many aperture blades does the lens have?', type=>'integer', default=>$$existing{aperture_blades}});
	$data{autofocus} = &prompt({prompt=>'Does this lens have autofocus?', type=>'boolean', default=>$$existing{autofocus}});
	$data{filter_thread} = &prompt({prompt=>'What is the diameter of the filter thread? (mm)', type=>'decimal', default=>$$existing{filter_thread}});
	$data{magnification} = &prompt({prompt=>'What is the maximum magnification possible with this lens?', type=>'decimal', default=>$$existing{magnification}});
	$data{url} = &prompt({prompt=>'Informational URL for this lens', default=>$$existing{url}});
	$data{serial} = &prompt({prompt=>'What is the serial number of the lens?', default=>$$existing{serial}});
	$data{date_code} = &prompt({prompt=>'What is the date code of the lens?', default=>$$existing{date_code}});
	$data{introduced} = &prompt({prompt=>'When was this lens introduced?', type=>'integer', default=>$$existing{introduced}});
	$data{discontinued} = &prompt({prompt=>'When was this lens discontinued?', type=>'integer', default=>$$existing{discontinued}});
	$data{manufactured} = &prompt({prompt=>'When was this lens manufactured?', type=>'integer', default=>$$existing{manufactured}});
	$data{negative_size_id} = &listchoices({db=>$db, cols=>['negative_size_id as id', 'negative_size as opt'], table=>'NEGATIVE_SIZE', inserthandler=>\&negativesize_add, default=>$$existing{negative_size_id}});
	$data{acquired} = &prompt({prompt=>'When was this lens acquired?', type=>'date', default=>$$existing{acquired}});
	$data{cost} = &prompt({prompt=>'How much did this lens cost?', type=>'decimal', default=>$$existing{cost}});
	$data{notes} = &prompt({prompt=>'Notes', default=>$$existing{notes}});
	$data{own} = &prompt({prompt=>'Do you own this lens?', type=>'boolean', default=>$$existing{own}});
	$data{source} = &prompt({prompt=>'Where was this lens sourced from?', default=>$$existing{source}});
	$data{coating} = &prompt({prompt=>'What coating does this lens have?', default=>$$existing{coating}});
	$data{hood} = &prompt({prompt=>'What is the model number of the suitable hood for this lens?', default=>$$existing{hood}});
	$data{exif_lenstype} = &prompt({prompt=>'EXIF lens type code', default=>$$existing{exif_lenstype}});
	$data{rectilinear} = &prompt({prompt=>'Is this a rectilinear lens?', type=>'boolean', default=>$$existing{rectilinear}});
	$data{length} = &prompt({prompt=>'How long is this lens? (mm)', type=>'integer', default=>$$existing{length}});
	$data{diameter} = &prompt({prompt=>'How wide is this lens? (mm)', type=>'integer', default=>$$existing{diameter}});
	$data{condition_id} = &listchoices({db=>$db, keyword=>'condition', cols=>['condition_id as id', 'name as opt'], table=>'CONDITION', default=>$$existing{condition_id}});
	$data{image_circle} = &prompt({prompt=>'What is the diameter of the image circle?', type=>'integer', default=>$$existing{image_circle}});
	$data{formula} = &prompt({prompt=>'Does this lens have a named optical formula?', default=>$$existing{formula}});
	$data{shutter_model} = &prompt({prompt=>'What shutter does this lens incorporate?', default=>$$existing{shutter_model}});

	# Compare new and old data to find changed fields
	my %changes;
	my $thindata = &thin(\%data);
	foreach my $key (keys %$thindata) {
		if (!defined($$existing{$key}) || $data{$key} ne $$existing{$key}) {
			$changes{$key} = $data{$key};
		}
	}
	&updaterecord({db=>$db, data=>\%changes, table=>'LENS', where=>"lens_id=$lensid"});
}

sub lens_accessory {
	my $db = shift;
	my $lensid = shift || &listchoices({db=>$db, table=>'choose_lens'});
	while (1) {
		my %compatdata;
		$compatdata{accessory_id} = &listchoices({db=>$db, table=>'choose_accessory'});
		$compatdata{lens_id} = $lensid;
		&newrecord({db=>$db, data=>\%compatdata, table=>'ACCESSORY_COMPAT'});
		if (!&prompt({default=>'yes', prompt=>'Add more accessory compatibility info?', type=>'boolean'})) {
			last;
		}
	}
}

sub lens_sell {
	my $db = shift;
	my %data;
	my $lensid = shift || &listchoices({db=>$db, table=>'choose_lens'});
	$data{own} = 0;
	$data{lost} = &prompt({default=>&today($db), prompt=>'What date was this lens sold?', type=>'date'});
	$data{lost_price} = &prompt({prompt=>'How much did this lens sell for?', type=>'decimal'});
	&updaterecord({db=>$db, data=>\%data, table=>'LENS', where=>"lens_id=$lensid"});
}

sub lens_repair {
	my $db = shift;
	my %data;
	$data{lens_id} = shift || &listchoices({db=>$db, table=>'choose_lens'});
	$data{date} = &prompt({default=>&today($db), prompt=>'What date was this lens repaired?', type=>'date'});
	$data{summary} = &prompt({prompt=>'Short summary of repair'});
	$data{description} = &prompt({prompt=>'Longer description of repair'});
	my $repair_id = &newrecord({db=>$db, data=>\%data, table=>'REPAIR'});
	return $repair_id;
}

sub lens_stats {
	my $db = shift;
	my $lens_id = &listchoices({db=>$db, table=>'choose_lens'});
	my $lens = &lookupval({db=>$db, col=>"concat(manufacturer, ' ',model) as opt", table=>'LENS join MANUFACTURER on LENS.manufacturer_id=MANUFACTURER.manufacturer_id', where=>{lens_id=>$lens_id}});
	print "\tShowing statistics for $lens\n";
	my $total_shots_with_lens = &lookupval({db=>$db, col=>'count(*)', table=>'NEGATIVE', where=>{lens_id=>$lens_id}});
	my $total_shots = &lookupval({db=>$db, col=>'count(*)', table=>'NEGATIVE'});
	if ($total_shots > 0) {
		my $percentage = round(100 * $total_shots_with_lens / $total_shots);
		print "\tThis lens has been used to take $total_shots_with_lens frames, which is ${percentage}% of the frames in your collection\n";
	}
	my $maxaperture = &lookupval({db=>$db, col=>'max_aperture', table=>'LENS', where=>{lens_id=>$lens_id}});
	my $modeaperture = &lookupval({db=>$db, query=>"select aperture from (select aperture, count(aperture) from NEGATIVE where lens_id=$lens_id and aperture is not null group by aperture order by count(aperture) desc limit 1) as t1"});
	print "\tThis lens has a maximum aperture of f/$maxaperture but you most commonly use it at f/$modeaperture\n";
	if (&lookupval({db=>$db, col=>'zoom', table=>'LENS', where=>{lens_id=>$lens_id}})) {
		my $minf = &lookupval({db=>$db, col=>'min_focal_length', table=>'LENS', where=>{lens_id=>$lens_id}});
		my $maxf = &lookupval({db=>$db, col=>'max_focal_length', table=>'LENS', where=>{lens_id=>$lens_id}});
		my $meanf = &lookupval({db=>$db, col=>'avg(focal_length)', table=>'NEGATIVE', where=>{lens_id=>$lens_id}});
		print "\tThis is a zoom lens with a range of ${minf}-${maxf}mm, but the average focal length you used is ${meanf}mm\n";
	}
}

sub lens_info {
	my $db = shift;
	my $lens_id = &listchoices({db=>$db, table=>'choose_lens'});
	my $lensdata = &lookupcol({db=>$db, table=>'lens_summary', where=>{'`Lens ID`'=>$lens_id}});
	print Dump($lensdata);
}

sub print_add {
	my $db = shift;
	my %data;
	my $neg_id;
	my $todo_id = &listchoices({db=>$db, keyword=>'print from the order queue', table=>'choose_todo'});
	if ($todo_id) {
		$neg_id = &lookupval({db=>$db, col=>'negative_id', table=>'TO_PRINT', where=>{id=>$todo_id}});
	} else {
		$neg_id = &chooseneg({db=>$db});
	}
	$data{negative_id} = &prompt({default=>$neg_id, prompt=>'Negative ID to print from', type=>'integer'});
	$data{date} = &prompt({default=>&today($db), prompt=>'Date that the print was made', type=>'date'});
	$data{paper_stock_id} = &listchoices({db=>$db, keyword=>'paper stock', table=>'choose_paper', inserthandler=>\&paperstock_add});
	$data{height} = &prompt({prompt=>'Height of the print (inches)', type=>'integer'});
	$data{width} = &prompt({prompt=>'Width of the print (inches)', type=>'integer'});
	$data{aperture} = &prompt({prompt=>'Aperture used on enlarging lens', type=>'decimal'});
	$data{exposure_time} = &prompt({prompt=>'Exposure time (s)', type=>'integer'});
	$data{filtration_grade} = &prompt({prompt=>'Filtration grade', type=>'decimal'});
	$data{development_time} = &prompt({default=>'60', prompt=>'Development time (s)', type=>'integer'});
	$data{enlarger_id} = &listchoices({db=>$db, table=>'choose_enlarger', inserthandler=>\&enlarger_add});
	$data{lens_id} = &listchoices({db=>$db, table=>'choose_enlarger_lens'});
	$data{developer_id} = &listchoices({db=>$db, cols=>['developer_id as id', 'name as opt'], table=>'DEVELOPER', where=>{'for_paper'=>1}, inserthandler=>\&developer_add});
	$data{fine} = &prompt({prompt=>'Is this a fine print?', type=>'boolean'});
	$data{notes} = &prompt({prompt=>'Notes'});
	$data{printer_id} = &listchoices({db=>$db, keyword=>'printer', cols=>['person_id as id', 'name as opt'], table=>'PERSON', inserthandler=>\&person_add});
	my $printid = &newrecord({db=>$db, data=>\%data, table=>'PRINT'});

	# Mark is as complete in the todo list
	if ($todo_id) {
		my %data2;
		$data2{printed} = 1;
		$data2{print_id} = $printid;
		&updaterecord({db=>$db, data=>\%data2, table=>'TO_PRINT', where=>"id=$todo_id"});
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
	my $todo_id = &listchoices({db=>$db, keyword=>'print from the queue', table=>'choose_todo'});
	$data{printed} = &prompt({default=>'yes', prompt=>'Is this print order now fulfilled?', type=>'boolean'});
	$data{print_id} = &prompt({prompt=>'Which print fulfilled this order?', type=>'integer'});
	&updaterecord({db=>$db, data=>\%data, table=>'TO_PRINT', where=>"id=$todo_id"});
}

sub print_tone {
	my $db = shift;
	my %data;
	my $print_id = shift || &prompt({prompt=>'Which print did you tone?', type=>'integer'});
	$data{bleach_time} = &prompt({default=>'00:00:00', prompt=>'How long did you bleach for? (HH:MM:SS)', type=>'hh:mm:ss'});
	$data{toner_id} = &listchoices({db=>$db, cols=>['toner_id as id', 'toner as opt'], table=>'TONER', inserthandler=>\&toner_add});
	my $dilution1 = &lookupval({db=>$db, col=>'stock_dilution', table=>'TONER', where=>{toner_id=>$data{toner_id}}});
	$data{toner_dilution} = &prompt({default=>$dilution1, prompt=>'What was the dilution of the first toner?'});
	$data{toner_time} = &prompt({prompt=>'How long did you tone for? (HH:MM:SS)', type=>'hh:mm:ss'});
	if (&prompt({default=>'no', prompt=>'Did you use a second toner?', type=>'boolean'}) == 1) {
		$data{'2nd_toner_id'} = &listchoices({db=>$db, cols=>['toner_id as id', 'toner as opt'], table=>'TONER', inserthandler=>\&toner_add});
		my $dilution2 = &lookupval({db=>$db, col=>'stock_dilution', table=>'TONER', where=>{toner_id=>$data{'2nd_toner_id'}}});
		$data{'2nd_toner_dilution'} = &prompt({default=>$dilution2, prompt=>'What was the dilution of the second toner?'});
		$data{'2nd_toner_time'} = &prompt({prompt=>'How long did you tone for? (HH:MM:SS)', type=>'hh:mm:ss'});
	}
	&updaterecord({db=>$db, data=>\%data, table=>'PRINT', where=>"print_id=$print_id"});
}

sub print_sell {
	my $db = shift;
	my %data;
	my $print_id = shift || &prompt({prompt=>'Which print did you sell?', type=>'integer'});
	$data{own} = 0;
	$data{location} = &prompt({prompt=>'What happened to the print?'});
	$data{sold_price} = &prompt({prompt=>'What price was the print sold for?', type=>'decimal'});
	&updaterecord({db=>$db, data=>\%data, table=>'PRINT', where=>"print_id=$print_id"});
}

sub print_order {
	my $db = shift;
	my %data;
	my $neg_id = &chooseneg({db=>$db});
	$data{negative_id} = &prompt({default=>$neg_id, prompt=>'Negative ID to print from', type=>'integer'});
	$data{height} = &prompt({prompt=>'Height of the print (inches)', type=>'integer'});
	$data{width} = &prompt({prompt=>'Width of the print (inches)', type=>'integer'});
	$data{recipient} = &prompt({prompt=>'Who is the print for?'});
	$data{added} = &prompt({default=>&today($db), prompt=>'Date that this order was placed', type=>'date'});
	my $orderid = &newrecord({db=>$db, data=>\%data, table=>'TO_PRINT'});
}

sub print_archive {
	# Archive a print for storage
	my $db = shift;
	my %data;
	my $print_id = shift || &prompt({prompt=>'Which print did you archive?', type=>'integer'});
	$data{archive_id} = &listchoices({db=>$db, cols=>['archive_id as id', 'name as opt'], table=>'ARCHIVE', where=>{'archive_type_id'=>3, 'sealed'=>0}, inserthandler=>\&archive_add});
	$data{own} = 1;
	$data{location} = 'Archive',
	&updaterecord({db=>$db, data=>\%data, table=>'PRINT', where=>"print_id=$print_id"});
}

sub print_locate {
	my $db = shift;
	my $print_id = &prompt({prompt=>'Which print do you want to locate?', type=>'integer'});

	if (my $archiveid = &lookupval({db=>$db, col=>'archive_id', table=>'PRINT', where=>{print_id=>$print_id}})) {
		my $archive = &lookupval({db=>$db, col=>"concat(name, ' (', location, ')') as archive", table=>'ARCHIVE', where=>{archive_id=>$archiveid}});
		print "Print #${print_id} is in $archive\n";
	} elsif (my $location = &lookupval({db=>$db, col=>'location', table=>'PRINT', where=>{print_id=>$print_id}})) {
		if (my $own = &lookupval({db=>$db, col=>'own', table=>'PRINT', where=>{print_id=>$print_id}})) {
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
	my $print_id = &prompt({prompt=>'Which print do you want to reprint?', type=>'integer'});
	my $negative = &lookupval({db=>$db, col=>"concat(film_id, '/', frame) as negative", table=>'PRINT join NEGATIVE on PRINT.negative_id=NEGATIVE.negative_id', where=>{print_id=>$print_id}});
	my $caption = &lookupval({db=>$db, col=>"description", table=>'PRINT join NEGATIVE on PRINT.negative_id=NEGATIVE.negative_id', where=>{print_id=>$print_id}});
	print "\tPrint #${print_id} was made from Negative $negative \"$caption\"\n";

	my $size = &lookupval({db=>$db, col=>"concat(width,'x',height,'\"') as size", table=>'PRINT', where=>{print_id=>$print_id}});
	my $paper = &lookupval({db=>$db, query=>"select concat(manufacturer, ' ', PAPER_STOCK.name) as paper from PRINT, PAPER_STOCK, MANUFACTURER where print_id = $print_id and PRINT.paper_stock_id = PAPER_STOCK.paper_stock_id and PAPER_STOCK.manufacturer_id=MANUFACTURER.manufacturer_id"});
	print "\tIt was made on $paper at size $size\n";

	# enlarger, lens
	my $enlarger = &lookupval({db=>$db, query=>"select concat(manufacturer, ' ', enlarger) as enlarger from PRINT, ENLARGER, MANUFACTURER where print_id=$print_id and PRINT.enlarger_id=ENLARGER.enlarger_id and ENLARGER.manufacturer_id = MANUFACTURER.manufacturer_id"});
	my $lens = &lookupval({db=>$db, query=>"select concat(manufacturer, ' ', model) as lens from PRINT, LENS, MANUFACTURER where print_id=$print_id and PRINT.lens_id=LENS.lens_id and LENS.manufacturer_id = MANUFACTURER.manufacturer_id"});
	print "\tIt was made with the $enlarger enlarger and $lens lens\n";
	if (&lookupval({db=>$db, col=>'ENLARGER.lost', table=>'PRINT join ENLARGER on PRINT.enlarger_id=ENLARGER.enlarger_id', where=>{print_id=>$print_id}})) {
		print "\tYou no longer own the $enlarger, so the exposure information may be useless!\n";
	}

	# time & aperture
	my $time = &lookupval({db=>$db, col=>'exposure_time', table=>'PRINT', where=>{print_id=>$print_id}});
	my $aperture = &lookupval({db=>$db, col=>'aperture', table=>'PRINT', where=>{print_id=>$print_id}});
	print "\tExposure was ${time}s at f/${aperture}\n";

	# multigrade filter
	if (my $grade = &lookupval({db=>$db, col=>'filtration_grade', table=>'PRINT', where=>{print_id=>$print_id}})) {
		print "\tFiltration grade was $grade\n";
	} else {
		print "\tPrint was unfiltered\n";
	}
	# toner
	if (&lookupval({db=>$db, col=>'toner_id', table=>'PRINT', where=>{print_id=>$print_id}})) {
		# at least one toner
		my $firsttoner = &lookupval({db=>$db, query=>"select concat(manufacturer, ' ', toner, if(toner_dilution is not null, concat(' (', toner_dilution, ')'), ''), if(toner_time is not null, concat(' for ', toner_time), '')) as toner from PRINT, TONER, MANUFACTURER where PRINT.toner_id=TONER.toner_id and TONER.manufacturer_id=MANUFACTURER.manufacturer_id"});
		if (&lookupval({db=>$db, col=>'2nd_toner_id', table=>'PRINT', where=>{print_id=>$print_id}})) {
			# 2 toners
			my $secondtoner = &lookupval({db=>$db, query=>"select concat(manufacturer, ' ', toner, if(2nd_toner_dilution is not null, concat(' (', 2nd_toner_dilution, ')'), ''), if(2nd_toner_time is not null, concat(' for ', 2nd_toner_time), '')) as toner from PRINT, TONER, MANUFACTURER where PRINT.2nd_toner_id=TONER.toner_id and TONER.manufacturer_id=MANUFACTURER.manufacturer_id"});
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
	$data{print_id} = &prompt({prompt=>'Which print do you want to exhibit?', type=>'integer'});
	$data{exhibition_id} = &listchoices({db=>$db, cols=>['exhibition_id as id', 'title as opt'], table=>'EXHIBITION', inserthandler=>\&exhibition_add});
	my $id = &newrecord({db=>$db, data=>\%data, table=>'EXHIBIT'});
	return $id;
}

sub print_label {
	my $db = shift;
	my $print_id = &prompt({prompt=>'Which print do you want to label?', type=>'integer'});
	my $data = &lookupcol({db=>$db, table=>'print_info', where=>{print_id=>$print_id}});
	my $row = @$data[0];
	print "\t#$row->{'print_id'} $row->{'description'}\n" if ($row->{print_id} && $row->{description});
	print "\tPhotographed $row->{photo_date}\n" if ($row->{photo_date});
	print "\tPrinted $row->{print_date}\n" if ($row->{print_date});
	print "\tby $row->{name}\n" if ($row->{name});
}

sub print_worklist {
	my $db = shift;
	my $data = &lookupcol({db=>$db, table=>'choose_todo'});

	foreach my $row (@$data) {
		print "\t$row->{opt}\n";
        }
}

sub paperstock_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{name} = &prompt({prompt=>'What model is the paper?'});
	$data{resin_coated} = &prompt({prompt=>'Is this paper resin-coated?', type=>'boolean'});
	$data{tonable} = &prompt({prompt=>'Is this paper tonable?', type=>'boolean'});
	$data{colour} = &prompt({prompt=>'Is this a colour paper?', type=>'boolean'});
	$data{finish} = &prompt({prompt=>'What surface finish does this paper have?'});
	my $paperstockid = &newrecord({db=>$db, data=>\%data, table=>'PAPER_STOCK'});
	return $paperstockid;
}

sub developer_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{name} = &prompt({prompt=>'What model is the developer?'});
	$data{for_paper} = &prompt({prompt=>'Is this developer suitable for paper?', type=>'boolean'});
	$data{for_film} = &prompt({prompt=>'Is this developer suitable for film?', type=>'boolean'});
	$data{chemistry} = &prompt({prompt=>'What type of chemistry is this developer based on?'});
	my $developerid = &newrecord({db=>$db, data=>\%data, table=>'DEVELOPER'});
	return $developerid;
}

sub mount_add {
	my $db = shift;
	my %data;
	$data{mount} = &prompt({prompt=>'What is the name of this lens mount?'});
	$data{fixed} = &prompt({default=>'no', prompt=>'Is this a fixed mount?', type=>'boolean'});
	$data{shutter_in_lens} = &prompt({default=>'no', prompt=>'Does this mount contain the shutter in the lens?', type=>'boolean'});
	$data{type} = &prompt({prompt=>'What type of mounting does this mount use? (e.g. bayonet, screw, etc)'});
	$data{purpose} = &prompt({default=>'camera', prompt=>'What is the intended purpose of this mount? (e.g. camera, enlarger, projector, etc)'});
	$data{digital_only} = &prompt({default=>'no', prompt=>'Is this a digital-only mount?', type=>'boolean'});
	$data{notes} = &prompt({prompt=>'Notes about this mount'});
	my $mountid = &newrecord({db=>$db, data=>\%data, table=>'MOUNT'});
	return $mountid;
}

sub mount_view {
	my $db = shift;
	my $mountid = &listchoices({db=>$db, cols=>['mount_id as id', 'mount as opt'], table=>'MOUNT'});
	my $mountname = &lookupval({db=>$db, col=>'mount', table=>'MOUNT', where=>{mount_id=>${mountid}}});
	print "Showing data for $mountname mount\n";
	&printlist({db=>$db, msg=>"cameras with $mountname mount", query=>"select C.camera_id as id, concat(M.manufacturer, ' ', C.model) as opt from CAMERA as C, MANUFACTURER as M where C.manufacturer_id=M.manufacturer_id and own=1 and mount_id=$mountid order by opt"});
	&printlist({db=>$db, msg=>"lenses with $mountname mount", query=>"select lens_id as id, concat(manufacturer, ' ', model) as opt from LENS, MANUFACTURER where mount_id=$mountid and LENS.manufacturer_id=MANUFACTURER.manufacturer_id and own=1 order by opt"});
}

sub toner_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{toner} = &prompt({prompt=>'What is the name of this toner?'});
	$data{formulation} = &prompt({prompt=>'What is the chemical formulation of this toner?'});
	$data{stock_dilution} = &prompt({prompt=>'What is the stock dilution of this toner?'});
	my $tonerid = &newrecord({db=>$db, data=>\%data, table=>'TONER'});
	return $tonerid;
}

sub filmstock_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{name} = &prompt({prompt=>'What is the name of this filmstock?'});
	$data{iso} = &prompt({prompt=>'What is the box ISO/ASA speed of this filmstock?', type=>'integer'});
	$data{colour} = &prompt({prompt=>'Is this a colour film?', type=>'boolean'});
	if ($data{colour} == 1) {
		$data{panchromatic} = 1;
	} else {
		$data{panchromatic} = &prompt({default=>'yes', prompt=>'Is this a panchromatic film?', type=>'boolean'});
	}
	$data{process_id} = &listchoices({db=>$db, cols=>['process_id as id', 'name as opt'], table=>'PROCESS', inserthandler=>\&process_add});
	my $filmstockid = &newrecord({db=>$db, data=>\%data, table=>'FILMSTOCK'});
	return $filmstockid;
}

sub teleconverter_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{model} = &prompt({prompt=>'What is the model of this teleconverter?'});
	$data{factor} = &prompt('', 'What is the magnification factor of this teleconverter?', 'decimal');
	$data{mount_id} = &listchoices({db=>$db, cols=>['mount_id as id', 'mount as opt'], table=>'MOUNT', where=>{'purpose'=>'Camera'}, inserthandler=>\&mount_add});
	$data{elements} = &prompt({prompt=>'How many elements does this teleconverter have?', type=>'integer'});
	$data{groups} = &prompt({prompt=>'How many groups are the elements arranged in?', type=>'integer'});
	$data{multicoated} = &prompt({prompt=>'Is this teleconverter multicoated?', type=>'boolean'});
	my $teleconverterid = &newrecord({db=>$db, data=>\%data, table=>'TELECONVERTER'});
	return $teleconverterid;
}

sub filter_add {
	my $db = shift;
	my %data;
	$data{type} = &prompt({prompt=>'What type of filter is this?'});
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{attenuation} = &prompt({prompt=>'What attenutation (in stops) does this filter have?', type=>'decimal'});
	$data{thread} = &prompt({prompt=>'What diameter mounting thread does this filter have?', type=>'decimal'});
	$data{qty} = &prompt({default=>1, prompt=>'How many of these filters do you have?', type=>'integer'});
	my $filterid = &newrecord({db=>$db, data=>\%data, table=>'FILTER'});
	return $filterid;
}

sub process_add {
	my $db = shift;
	my %data;
	$data{name} = &prompt({prompt=>'What is the name of this film process?'});
	$data{colour} = &prompt({prompt=>'Is this a colour process?', type=>'boolean'});
	$data{positive} = &prompt({prompt=>'Is this a reversal process?', type=>'boolean'});
	my $processid = &newrecord({db=>$db, data=>\%data, table=>'PROCESS'});
	return $processid;
}

sub filter_adapt {
	my $db = shift;
	my %data;
	$data{camera_thread} = &prompt({prompt=>'What diameter thread faces the camera on this filter adapter?', type=>'decimal'});
	$data{filter_thread} = &prompt({prompt=>'What diameter thread faces the filter on this filter adapter?', type=>'decimal'});
	my $filteradapterid = &newrecord({db=>$db, data=>\%data, table=>'FILTER_ADAPTER'});
	return $filteradapterid;
}

sub manufacturer_add {
	my $db = shift;
	my %data;
	$data{manufacturer} = &prompt({prompt=>'What is the name of the manufacturer?'});
	$data{country} = &prompt({prompt=>'What country is the manufacturer based in?'});
	$data{city} = &prompt({prompt=>'What city is the manufacturer based in?'});
	$data{url} = &prompt({prompt=>'What is the main website of the manufacturer?'});
	$data{founded} = &prompt({prompt=>'When was the manufacturer founded?', type=>'integer'});
	$data{dissolved} = &prompt({prompt=>'When was the manufacturer dissolved?', type=>'integer'});
	my $manufacturerid = &newrecord({db=>$db, data=>\%data, table=>'MANUFACTURER'});
	return $manufacturerid;
}

sub accessory_add {
	my $db = shift;
	my %data;
	$data{accessory_type_id} = &listchoices({db=>$db, cols=>['accessory_type_id as id', 'accessory_type as opt'], table=>'ACCESSORY_TYPE', inserthandler=>\&accessory_type});
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{model} = &prompt({prompt=>'What is the model of this accessory?'});
	$data{acquired} = &prompt({default=>&today($db), prompt=>'When was this accessory acquired?', type=>'date'});
	$data{cost} = &prompt({prompt=>'What did this accessory cost?', type=>'decimal'});
	my $accessoryid = &newrecord({db=>$db, data=>\%data, table=>'ACCESSORY'});

	if (&prompt({default=>'yes', prompt=>'Add camera compatibility info for this accessory?', type=>'boolean'})) {
		while (1) {
			my %compatdata;
			$compatdata{accessory_id} = $accessoryid;
			$compatdata{camera_id} = &listchoices({db=>$db, table=>'choose_camera'});
			&newrecord({db=>$db, data=>\%compatdata, table=>'ACCESSORY_COMPAT'});
			if (!&prompt({default=>'yes', prompt=>'Add another compatible camera?', type=>'boolean'})) {
				last;
			}
		}
	}
	if (&prompt({default=>'yes', prompt=>'Add lens compatibility info for this accessory?', type=>'boolean'})) {
		while (1) {
			my %compatdata;
			$compatdata{accessory_id} = $accessoryid;
			$compatdata{lens_id} = &listchoices({db=>$db, table=>'choose_lens'});
			&newrecord({db=>$db, data=>\%compatdata, table=>'ACCESSORY_COMPAT'});
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
	$data{accessory_type} = &prompt({prompt=>'What type of accessory do you want to add?'});
	my $accessorytypeid = &newrecord({db=>$db, data=>\%data, table=>'ACCESSORY_TYPE'});
	return $accessorytypeid;
}

sub enlarger_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{enlarger} = &prompt({prompt=>'What is the model of this enlarger?'});
	$data{negative_size_id} = &listchoices({db=>$db, cols=>['negative_size_id as id', 'negative_size as opt'], table=>'NEGATIVE_SIZE', inserthandler=>\&negativesize_add});
	$data{introduced} = &prompt({prompt=>'What year was this enlarger introduced?', type=>'integer'});
	$data{discontinued} = &prompt({prompt=>'What year was this enlarger discontinued?', type=>'integer'});
	$data{acquired} = &prompt({default=>&today($db), prompt=>'Purchase date', type=>'date'});
	$data{cost} = &prompt({prompt=>'Purchase price', type=>'decimal'});
	my $enlarger_id = &newrecord({db=>$db, data=>\%data, table=>'ENLARGER'});
	return $enlarger_id;
}

sub enlarger_sell {
	my $db = shift;
	my %data;
	my $enlarger_id = shift || &listchoices({db=>$db, table=>'choose_enlarger'});
	$data{lost} = &prompt({default=>&today($db), prompt=>'What date was this enlarger sold?', type=>'date'});
	$data{lost_price} = &prompt({prompt=>'How much did this enlarger sell for?', type=>'decimal'});
	&updaterecord({db=>$db, data=>\%data, table=>'ENLARGER', where=>"enlarger_id=$enlarger_id"});
}

sub flash_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{model} = &prompt({prompt=>'What is the model of this flash?'});
	$data{guide_number} = &prompt({prompt=>'What is the guide number of this flash?', type=>'integer'});
	$data{gn_info} = &prompt({default=>'ISO 100', prompt=>'What are the conditions of the guide number?'});
	$data{battery_powered} = &prompt({default=>'yes', prompt=>'Is this flash battery-powered?', type=>'boolean'});
	if ($data{battery_powered} == 1) {
		$data{battery_type_id} = &listchoices({db=>$db, keyword=>'battery type', table=>'choose_battery', inserthandler=>\&battery_add});
		$data{battery_qty} = &prompt({prompt=>'How many batteries does this flash need?', type=>'integer'});
	}
	$data{pc_sync} = &prompt({default=>'yes', prompt=>'Does this flash have a PC sync socket?', type=>'boolean'});
	$data{hot_shoe} = &prompt({default=>'yes', prompt=>'Does this flash have a hot shoe connector?', type=>'boolean'});
	$data{light_stand} = &prompt({default=>'yes', prompt=>'Can this flash be fitted onto a light stand?', type=>'boolean'});
	$data{manual_control} = &prompt({default=>'yes', prompt=>'Does this flash have manual power control?', type=>'boolean'});
	$data{swivel_head} = &prompt({default=>'yes', prompt=>'Does this flash have a left/right swivel head?', type=>'boolean'});
	$data{tilt_head} = &prompt({default=>'yes', prompt=>'Does this flash have an up/down tilt head?', type=>'boolean'});
	$data{zoom} = &prompt({default=>'yes', prompt=>'Does this flash have a zoom head?', type=>'boolean'});
	$data{dslr_safe} = &prompt({default=>'yes', prompt=>'Is this flash safe to use on a DSLR?', type=>'boolean'});
	$data{ttl} = &prompt({default=>'yes', prompt=>'Does this flash support TTL metering?', type=>'boolean'});
	if ($data{ttl} == 1) {
		$data{flash_protocol_id} = &listchoices({db=>$db, table=>'choose_flash_protocol'});
	}
	$data{trigger_voltage} = &prompt({prompt=>'What is the measured trigger voltage?', type=>'decimal'});
	$data{own} = 1;
	$data{acquired} = &prompt({default=>&today($db), prompt=>'When was it acquired?', type=>'date'});
	$data{cost} = &prompt({prompt=>'What did this flash cost?', type=>'decimal'});
	my $flashid = &newrecord({db=>$db, data=>\%data, table=>'FLASH'});
	return $flashid;
}

sub battery_add {
	my $db = shift;
	my %data;
	$data{battery_name} = &prompt({prompt=>'What is the name of this battery?'});
	$data{voltage} = &prompt({prompt=>'What is the nominal voltage of this battery?', type=>'decimal'});
	$data{chemistry} = &prompt({prompt=>'What type of chemistry is this battery based on?'});
	$data{other_names} = &prompt({prompt=>'Does this type of battery go by any other names?'});
	my $batteryid = &newrecord({db=>$db, data=>\%data, table=>'BATTERY'});
	return $batteryid;
}

sub format_add {
	my $db = shift;
	my %data;
	$data{format} = &prompt({prompt=>'What is the name of this film format?'});
	$data{digital} = &prompt({default=>'no', prompt=>'Is this a digital format?', type=>'boolean'});
	my $formatid = &newrecord({db=>$db, data=>\%data, table=>'FORMAT'});
	return $formatid;
}

sub negativesize_add {
	my $db = shift;
	my %data;
	$data{negative_size} = &prompt({prompt=>'What is the name of this negative size?'});
	$data{width} = &prompt({prompt=>'What is the width of this negative size in mm?', type=>'decimal'});
	$data{height} = &prompt({prompt=>'What is the height of this negative size in mm?', type=>'decimal'});
	if ($data{width} > 0 && $data{height} > 0) {
		$data{crop_factor} = round(sqrt($data{width}*$data{width} + $data{height}*$data{height}) / sqrt(36*36 + 24*24), 2);
		$data{area} = $data{width} * $data{height};
		$data{aspect_ratio} = round($data{width} / $data{height}, 2);
	}
	my $negativesizeid = &newrecord({db=>$db, data=>\%data, table=>'NEGATIVE_SIZE'});
	return $negativesizeid;
}

sub mount_adapt {
	my $db = shift;
	my %data;
	$data{lens_mount} = &listchoices({db=>$db, keyword=>'lens-facing mount', cols=>['mount_id as id', 'mount as opt'], table=>'MOUNT', where=>{'purpose'=>'Camera'}, inserthandler=>\&mount_add});
	$data{camera_mount} = &listchoices({db=>$db, keyword=>'camera-facing mount', cols=>['mount_id as id', 'mount as opt'], table=>'MOUNT', where=>{'purpose'=>'Camera'}, inserthandler=>\&mount_add});
	$data{has_optics} = &prompt({prompt=>'Does this mount adapter have corrective optics?', type=>'boolean'});
	$data{infinity_focus} = &prompt({prompt=>'Does this mount adapter have infinity focus?', type=>'boolean'});
	$data{notes} = &prompt({prompt=>'Notes'});
	my $mountadapterid = &newrecord({db=>$db, data=>\%data, table=>'MOUNT_ADAPTER'});
	return $mountadapterid;
}

sub lightmeter_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{model} = &prompt({prompt=>'What is the model of this light meter?'});
	$data{metering_type} = &listchoices({db=>$db, cols=>['metering_type_id as id', 'metering as opt'], table=>'METERING_TYPE', inserthandler=>\&meteringtype_add});
	$data{reflected} = &prompt({prompt=>'Can this meter take reflected light readings?', type=>'boolean'});
	$data{incident} = &prompt({prompt=>'Can this meter take incident light readings?', type=>'boolean'});
	$data{spot} = &prompt({prompt=>'Can this meter take spot readings?', type=>'boolean'});
	$data{flash} = &prompt({prompt=>'Can this meter take flash readings?', type=>'boolean'});
	$data{min_asa} = &prompt({prompt=>'What\'s the lowest ISO/ASA setting this meter supports?', type=>'integer'});
	$data{max_asa} = &prompt({prompt=>'What\'s the highest ISO/ASA setting this meter supports?', type=>'integer'});
	$data{min_lv} = &prompt({prompt=>'What\'s the lowest light value (LV) reading this meter can give?', type=>'integer'});
	$data{max_lv} = &prompt({prompt=>'What\'s the highest light value (LV) reading this meter can give?', type=>'integer'});
	my $lightmeterid = &newrecord({db=>$db, data=>\%data, table=>'LIGHT_METER'});
	return $lightmeterid;
}

sub camera_addbodytype {
	my $db = shift;
	my %data;
	$data{body_type} = &prompt({prompt=>'Enter new camera body type'});
	my $bodytypeid = &newrecord({db=>$db, data=>\%data, table=>'BODY_TYPE'});
	return $bodytypeid;
}

sub archive_add {
	my $db = shift;
	my %data;
	$data{archive_type_id} = &listchoices({db=>$db, cols=>['archive_type_id as id', 'archive_type as opt'], table=>'ARCHIVE_TYPE'});
	$data{name} = &prompt({prompt=>'What is the name of this archive?'});
	$data{max_width} = &prompt({prompt=>'What is the maximum width of media that this archive can accept (if applicable)?'});
	$data{max_height} = &prompt({prompt=>'What is the maximum height of media that this archive can accept (if applicable)?'});
	$data{location} = &prompt({prompt=>'What is the location of this archive?'});
	$data{storage} = &prompt({prompt=>'What is the storage type of this archive? (e.g. box, folder, ringbinder, etc)'});
	$data{sealed} = &prompt({default=>'no', prompt=>'Is this archive sealed (closed to new additions)?', type=>'boolean'});
	my $archiveid = &newrecord({db=>$db, data=>\%data, table=>'ARCHIVE'});
	return $archiveid;
}

sub archive_films {
	my $db = shift;
	my %data;
	my $minfilm = &prompt({prompt=>'What is the lowest film ID in the range?', type=>'integer'});
	my $maxfilm = &prompt({prompt=>'What is the highest film ID in the range?', type=>'integer'});
	if (($minfilm =~ m/^\d+$/) && ($maxfilm =~ m/^\d+$/)) {
		if ($maxfilm le $minfilm) {
			print "Highest film ID must be higher than lowest film ID\n";
			exit;
		}
	} else {
		print "Must provide highest and lowest film IDs\n";
		exit;
	}
	$data{archive_id} = &listchoices({db=>$db, cols=>['archive_id as id', 'name as opt'], table=>'ARCHIVE', where=>'archive_type_id in (1,2) and sealed = 0', inserthandler=>\&archive_add});
	&updaterecord({db=>$db, data=>\%data, table=>'FILM', where=>"film_id >= $minfilm and film_id <= $maxfilm and archive_id is null"});
}

sub archive_list {
	my $db = shift;
	my $archive_id = &listchoices({db=>$db, cols=>['archive_id as id', 'name as opt'], table=>'ARCHIVE'});
	my $archive_name = &lookupval({db=>$db, col=>'name', table=>'ARCHIVE', where=>{archive_id=>$archive_id}});
	my $query = "select * from (select concat('Film #', film_id) as id, notes as opt from FILM where archive_id=$archive_id union select concat('Print #', print_id) as id, description as opt from PRINT, NEGATIVE where PRINT.negative_id=NEGATIVE.negative_id and archive_id=$archive_id) as test order by id;";
	&printlist({db=>$db, msg=>"items in archive $archive_name", query=>$query});
}

sub archive_seal {
	my $db = shift;
	my %data;
	my $archive_id = &listchoices({db=>$db, cols=>['archive_id as id', 'name as opt'], table=>'ARCHIVE', where=>{sealed=>0}});
	$data{sealed} = 1;
	&updaterecord({db=>$db, data=>\%data, table=>'ARCHIVE', where=>"archive_id = $archive_id"});
}

sub archive_unseal {
	my $db = shift;
	my %data;
	my $archive_id = &listchoices({db=>$db, cols=>['archive_id as id', 'name as opt'], table=>'ARCHIVE', where=>{sealed=>1}});
	$data{sealed} = 0;
	&updaterecord({db=>$db, data=>\%data, table=>'ARCHIVE', where=>"archive_id = $archive_id"});
}

sub archive_move {
	my $db = shift;
	my %data;
	my $archive_id = shift || &listchoices({db=>$db, cols=>['archive_id as id', 'name as opt'], table=>'ARCHIVE'});
	my $oldlocation = &lookupval({db=>$db, col=>'location', table=>'ARCHIVE', where=>{archive_id=>$archive_id}});
	$data{location} = &prompt({default=>$oldlocation, prompt=>'What is the new location of this archive?'});
	&updaterecord({db=>$db, data=>\%data, table=>'ARCHIVE', where=>"archive_id = $archive_id"});
}

sub shuttertype_add {
	my $db = shift;
	my %data;
	$data{shutter_type} = &prompt({prompt=>'What type of shutter do you want to add?'});
	my $id = &newrecord({db=>$db, data=>\%data, table=>'SHUTTER_TYPE'});
	return $id;
}

sub focustype_add {
	my $db = shift;
	my %data;
	$data{focus_type} = &prompt({prompt=>'What type of focus system do you want to add?'});
	my $id = &newrecord({db=>$db, data=>\%data, table=>'FOCUS_TYPE'});
	return $id;
}

sub flashprotocol_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{name} = &prompt({prompt=>'What flash protocol do you want to add?'});
	my $id = &newrecord({db=>$db, data=>\%data, table=>'FLASH_PROTOCOL'});
	return $id;
}

sub meteringtype_add {
	my $db = shift;
	my %data;
	$data{metering} = &prompt({prompt=>'What type of metering system do you want to add?'});
	my $id = &newrecord({db=>$db, data=>\%data, table=>'METERING_TYPE'});
	return $id;
}

sub shutterspeed_add {
	my $db = shift;
	my %data;
	$data{shutter_speed} = &prompt({prompt=>'What shutter speed do you want to add?'});
	if ($data{shutter_speed} =~ m/1\/(\d+)/) {
		$data{duration} = 1 / $1;
	} elsif ($data{shutter_speed} =~ m/((0\.)?\d+)/) {
		$data{duration} = $1;
	}
	my $id = &newrecord({db=>$db, data=>\%data, table=>'SHUTTER_SPEED'});
	return $id;
}

sub person_add {
	my $db = shift;
	my %data;
	$data{name} = &prompt({prompt=>'What is this person\'s name?'});
	my $id = &newrecord({db=>$db, data=>\%data, table=>'PERSON'});
	return $id;
}

sub projector_add {
	my $db = shift;
	my %data;
	$data{manufacturer_id} = &choose_manufacturer({db=>$db});
	$data{model} = &prompt({prompt=>'What is the model of this projector?'});
	$data{mount_id} = &listchoices({db=>$db, cols=>['select mount_id as id', 'mount as opt'], table=>'MOUNT', where=>{'purpose'=>'Projector'}, inserthandler=>\&mount_add});
	$data{negative_size_id} = &listchoices({db=>$db, cols=>['negative_size_id as id', 'negative_size as opt'], table=>'NEGATIVE_SIZE', inserthandler=>\&negativesize_add});
	$data{own} = 1;
	$data{cine} = &prompt({prompt=>'Is this a cine/movie projector?', type=>'boolean'});
	my $id = &newrecord({db=>$db, data=>\%data, table=>'PROJECTOR'});
	return $id;
}

sub movie_add {
	my $db = shift;
	my %data;
	$data{title} = &prompt({prompt=>'What is the title of this movie?'});
	$data{camera_id} = &listchoices({db=>$db, table=>'choose_movie_camera'});
	if (&lookupval({db=>$db, col=>'fixed_mount', table=>'CAMERA', where=>{camera_id=>$data{camera_id}}})) {
		$data{lens_id} = &lookupval({db=>$db, col=>'lens_id', table=>'CAMERA', where=>{camera_id=>$data{camera_id}}});
	} else {
		$data{lens_id} = &listchoices({db=>$db, table=>'choose_lens'});
	}
	$data{format_id} = &listchoices({db=>$db, cols=>['format_id as id', 'format as opt'], table=>'FORMAT', inserthandler=>\&format_add});
	$data{sound} = &prompt({prompt=>'Does this movie have sound?', type=>'boolean'});
	$data{fps} = &prompt({prompt=>'What is the framerate of this movie in fps?', type=>'integer'});
	$data{filmstock_id} = &listchoices({db=>$db, table=>'choose_filmstock', inserthandler=>\&filmstock_add});
	$data{feet} = &prompt({prompt=>'What is the length of this movie in feet?', type=>'integer'});
	$data{date_loaded} = &prompt({default=>&today($db), prompt=>'What date was the film loaded?', type=>'date'});
	$data{date_shot} = &prompt({default=>&today($db), prompt=>'What date was the movie shot?', type=>'date'});
	$data{date_processed} = &prompt({default=>&today($db), prompt=>'What date was the movie processed?', type=>'date'});
	$data{process_id} = &listchoices({db=>$db, keyword=>'process', cols=>['process_id as id', 'name as opt'], table=>'PROCESS', inserthandler=>\&process_add});
	$data{description} = &prompt({prompt=>'Please enter a description of the movie'});
	my $id = &newrecord({db=>$db, data=>\%data, table=>'MOVIE'});
}

sub audit_shutterspeeds {
	my $db = shift;
	my $cameraid = &listchoices({db=>$db, keyword=>'camera without shutter speed data', table=>'choose_camera_without_shutter_data'});
	 &camera_shutterspeeds($db, $cameraid);
}

sub audit_exposureprograms {
	my $db = shift;
	my $cameraid = &listchoices({db=>$db, keyword=>'camera without exposure program data', table=>'choose_camera_without_exposure_programs'});
	 &camera_exposureprogram($db, $cameraid);
}

sub audit_meteringmodes {
	my $db = shift;
	my $cameraid = &listchoices({db=>$db, keyword=>'camera without metering mode data', table=>'choose_camera_without_metering_data'});
	&camera_meteringmode($db, $cameraid);
}

sub exhibition_add {
	my $db = shift;
	my %data;
	$data{title} = &prompt({prompt=>'What is the title of this exhibition?'});
	$data{location} = &prompt({prompt=>'Where is this exhibition?'});
	$data{start_date} = &prompt({prompt=>'What date does the exhibition start?', type=>'date'});
	$data{end_date} = &prompt({prompt=>'What date does the exhibition end?', type=>'date'});
	my $id = &newrecord({db=>$db, data=>\%data, table=>'EXHIBITION'});
}

sub exhibition_review {
	my $db = shift;
	my $exhibition_id = &listchoices({db=>$db, cols=>['exhibition_id as id', 'title as opt'], table=>'EXHIBITION'});
	my $title = &lookupval({db=>$db, col=>'title', table=>'EXHIBITION', where=>{exhibition_id=>$exhibition_id}});

	&printlist({db=>$db, msg=>"prints exhibited at $title", table=>'exhibits', where=>{exhibition_id=>$exhibition_id}});
}

sub task_run {
	my $db = shift;

	my @tasks = @queries::tasks;
	for my $i (0 .. $#tasks) {
		print "\t$i\t$tasks[$i]{desc}\n";
	}

	# Wait for input
	my $input = &prompt({prompt=>'Please select a task', type=>'integer'});

	my $sql = $tasks[$input]{'query'};
	my $rows = &updatedata($db, $sql);
	print "Updated $rows rows\n";
}

# Select a manufacturer using the first initial
sub choose_manufacturer {
	my $href = $_[0];
	my $db = $href->{db};
	my $default = $href->{default};

	if ($default) {
		my $manufacturer = &lookupval({db=>$db, col=>'manufacturer', table=>'MANUFACTURER', where=>{manufacturer_id=>$default}});
		return $default if (!&prompt({prompt=>"Current manufacturer is $manufacturer. Change this?", type=>'boolean', default=>'no'}));
	}

        # Loop until we get valid input
        my $initial;
        do {
                $initial = &prompt({prompt=>'Enter the first initial of the manufacturer', type=>'text'});
        } while (!($initial =~ m/^[a-z]$/i || $initial eq ''));
        $initial = lc($initial);
        my $manufacturer = &listchoices({db=>$db, cols=>['manufacturer_id as id', 'manufacturer as opt'], table=>'MANUFACTURER', where=>{'lower(left(manufacturer, 1))'=>$initial}, inserthandler=>\&handlers::manufacturer_add});
        return $manufacturer;
}

# This ensures the lib loads smoothly
1;
