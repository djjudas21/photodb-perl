package App::PhotoDB::commands;

# This package contains the authoritative list of commands and subcommands
# It is used by the app and also to generate docs
# Please keep this list alphabetised!

use strict;
use warnings;

use App::PhotoDB::handlers qw(/./);

# Define handlers for each command
our %handlers = (
	accessory => {
		'add'           => { 'handler' => \&accessory_add,      'desc' => 'Add a new general accessory to the database' },
		'battery'       => { 'handler' => \&battery_add,        'desc' => 'Add a new type of battery to the database' },
		'filter'        => { 'handler' => \&filter_add,         'desc' => 'Add a new (optical) filter to the database' },
		'filteradapter' => { 'handler' => \&filter_adapt,       'desc' => 'Add a filter adapter to the database' },
		'flash'         => { 'handler' => \&flash_add,          'desc' => 'Add a new flash to the database' },
		'info'          => { 'handler' => \&accessory_info,     'desc' => 'Display info about an accessory' },
		'meter'         => { 'handler' => \&lightmeter_add,     'desc' => 'Add a new light meter to the database' },
		'mountadapter'  => { 'handler' => \&mount_adapt,        'desc' => 'Add a new mount adapter to the database' },
		'projector'     => { 'handler' => \&projector_add,      'desc' => 'Add a new projector to the database' },
		'teleconverter' => { 'handler' => \&teleconverter_add,  'desc' => 'Add a new teleconverter to the database' },
		'category'      => { 'handler' => \&accessory_category, 'desc' => 'Add a new category of general accessory to the database' },
	},
	archive => {
		'add'    => { 'handler' => \&archive_add,    'desc' => 'Add a new physical archive for prints or films' },
		'films'  => { 'handler' => \&archive_films,  'desc' => 'Bulk-add multiple films to an archive' },
		'info'   => { 'handler' => \&archive_info,   'desc' => 'Show information about an archive'},
		'list'   => { 'handler' => \&archive_list,   'desc' => 'List the contents of an archive' },
		'move'   => { 'handler' => \&archive_move,   'desc' => 'Move an archive to a new location' },
		'seal'   => { 'handler' => \&archive_seal,   'desc' => 'Seal an archive and prevent new items from being added to it' },
		'unseal' => { 'handler' => \&archive_unseal, 'desc' => 'Unseal an archive and allow new items to be added to it' },
	},
	audit => {
		'displaylenses'    => { 'handler' => \&audit_displaylenses,    'desc' => 'Audit cameras without display lenses set' },
		'exposureprograms' => { 'handler' => \&audit_exposureprograms, 'desc' => 'Audit cameras without exposure program data' },
		'meteringmodes'    => { 'handler' => \&audit_meteringmodes,    'desc' => 'Audit cameras without metering mode data' },
		'shutterspeeds'    => { 'handler' => \&audit_shutterspeeds,    'desc' => 'Audit cameras without shutter speed data' },
	},
	camera => {
		'accessory'       => { 'handler' => \&camera_accessory,       'desc' => 'Add accessory compatibility info to a camera' },
		'add'             => { 'handler' => \&camera_add,             'desc' => 'Add a new camera to the database' },
		'choose'          => { 'handler' => \&camera_choose,          'desc' => 'Choose a camera based on several criteria' },
		'display-lens'    => { 'handler' => \&camera_displaylens,     'desc' => 'Associate a camera with a lens for display purposes' },
		'edit'            => { 'handler' => \&camera_edit,            'desc' => 'Edit an existing camera' },
		'exposureprogram' => { 'handler' => \&camera_exposureprogram, 'desc' => 'Add available exposure program info to a camera' },
		'info'            => { 'handler' => \&camera_info,            'desc' => 'Show information about a camera' },
		'meteringmode'    => { 'handler' => \&camera_meteringmode,    'desc' => 'Add available metering mode info to a camera' },
		'repair'          => { 'handler' => \&camera_repair,          'desc' => 'Repair a camera' },
		'sell'            => { 'handler' => \&camera_sell,            'desc' => 'Sell a camera' },
		'show-lenses'     => { 'handler' => \&notimplemented,         'desc' => 'Not yet implemented' },
		'shutterspeeds'   => { 'handler' => \&camera_shutterspeeds,   'desc' => 'Add available shutter speed info to a camera' },
	},
	data => {
		'bodytype'      => { 'handler' => \&camera_addbodytype, 'desc' => 'Add a new camera body type' },
		'flashprotocol' => { 'handler' => \&flashprotocol_add,  'desc' => 'Add a new flash protocol to the database' },
		'focustype'     => { 'handler' => \&focustype_add,      'desc' => 'Add a new type of focus system to the database' },
		'format'        => { 'handler' => \&format_add,         'desc' => 'Add a new film format to the database' },
		'manufacturer'  => { 'handler' => \&manufacturer_add,   'desc' => 'Add a new manufacturer to the database' },
		'meteringtype'  => { 'handler' => \&meteringtype_add,   'desc' => 'Add a new type of metering system to the database' },
		'negsize'       => { 'handler' => \&negativesize_add,   'desc' => 'Add a size of negative to the database' },
		'process'       => { 'handler' => \&process_add,        'desc' => 'Add a new development process to the database' },
		'shutterspeed'  => { 'handler' => \&shutterspeed_add,   'desc' => 'Add a new shutter speed to the database' },
		'shuttertype'   => { 'handler' => \&shuttertype_add,    'desc' => 'Add a new type of shutter to the database' },
	},
	db => {
		'backup' => { 'handler' => \&notimplemented, 'desc' => 'Back up the contents of the database' },
		'logs'   => { 'handler' => \&db_logs,        'desc' => 'Show activity logs from the database' },
		'stats'  => { 'handler' => \&db_stats,       'desc' => 'Show statistics about database usage' },
		'test'   => { 'handler' => \&db_test,        'desc' => 'Test database connectivity' },
	},
	enlarger => {
		'add'  => { 'handler' => \&enlarger_add,  'desc' => 'Add a new enlarger to the database' },
		'info' => { 'handler' => \&enlarger_info, 'desc' => 'Show information about an enlarger' },
		'sell' => { 'handler' => \&enlarger_sell, 'desc' => 'Sell an enlarger' },
	},
	exhibition => {
		'add'  => { 'handler' => \&exhibition_add,  'desc' => 'Add a new exhibition to the database' },
		'info' => { 'handler' => \&exhibition_info, 'desc' => 'Show information about an exhibition' },
	},
	film => {
		'add'      => { 'handler' => \&film_add,      'desc' => 'Add a new film to the database' },
		'annotate' => { 'handler' => \&film_annotate, 'desc' => 'Write out a text file with the scans from the film' },
		'archive'  => { 'handler' => \&film_archive,  'desc' => 'Put a film in a physical archive' },
		'bulk'     => { 'handler' => \&film_bulk,     'desc' => 'Add a new bulk film to the database' },
		'current'  => { 'handler' => \&film_current,  'desc' => 'List films that are currently loaded into cameras' },
		'develop'  => { 'handler' => \&film_develop,  'desc' => 'Develop a film' },
		'info'     => { 'handler' => \&film_info,     'desc' => 'Show information about a film' },
		'load'     => { 'handler' => \&film_load,     'desc' => 'Load a film into a camera' },
		'locate'   => { 'handler' => \&film_locate,   'desc' => 'Locate where this film is' },
		'stocks'   => { 'handler' => \&film_stocks,   'desc' => 'List the films that are currently in stock' },
		'tag'      => { 'handler' => \&film_tag,      'desc' => 'Write EXIF tags to scans from a film' },
	},
	lens => {
		'accessory' => { 'handler' => \&lens_accessory, 'desc' => 'Add accessory compatibility info to a lens' },
		'add'       => { 'handler' => \&lens_add,       'desc' => 'Add a new lens to the database' },
		'edit'      => { 'handler' => \&lens_edit,      'desc' => 'Edit an existing lens' },
		'info'      => { 'handler' => \&lens_info,      'desc' => 'Show information about a lens' },
		'repair'    => { 'handler' => \&lens_repair,    'desc' => 'Repair a lens' },
		'sell'      => { 'handler' => \&lens_sell,      'desc' => 'Sell a lens' },
	},
	material => {
		'developer'  => { 'handler' => \&developer_add,  'desc' => 'Add a new developer to the database' },
		'filmstock'  => { 'handler' => \&filmstock_add,  'desc' => 'Add a new type of filmstock to the database' },
		'paperstock' => { 'handler' => \&paperstock_add, 'desc' => 'Add a new type of photo paper to the database' },
		'toner'      => { 'handler' => \&toner_add,      'desc' => 'Add a new chemical toner to the database' },
	},
	mount => {
		'add'  => { 'handler' => \&mount_add,  'desc' => 'Add a new lens mount to the database' },
		'info' => { 'handler' => \&mount_info, 'desc' => 'View compatible cameras and lenses for a mount' },
	},
	movie => {
		'add'  => { 'handler' => \&movie_add,  'desc' => 'Add a new movie to the database' },
		'info' => { 'handler' => \&movie_info, 'desc' => 'Show information about a movie' },
	},
	negative => {
		'add'      => { 'handler' => \&negative_add,     'desc' => 'Add a new negative to the database as part of a film' },
		'bulk-add' => { 'handler' => \&negative_bulkadd, 'desc' => 'Bulk add multiple negatives to the database as part of a film' },
		'info'     => { 'handler' => \&negative_info,    'desc' => 'Show information about a negative' },
		'prints'   => { 'handler' => \&negative_prints,  'desc' => 'Find all prints made from a negative' },
		'tag'      => { 'handler' => \&negative_tag,     'desc' => 'Write EXIF tags to scans from a negative' },
	},
	person => {
		'add' => { 'handler' => \&person_add, 'desc' => 'Add a new person to the database' },
	},
	print => {
		'add'       => { 'handler' => \&print_add,       'desc' => 'Add a new print that has been made from a negative' },
		'archive'   => { 'handler' => \&print_archive,   'desc' => 'Add a print to a physical archive' },
		'exhibit'   => { 'handler' => \&print_exhibit,   'desc' => 'Exhibit a print in an exhibition' },
		'fulfil'    => { 'handler' => \&print_fulfil,    'desc' => 'Fulfil an order for a print' },
		'info'      => { 'handler' => \&print_info,      'desc' => 'Show details about a print' },
		'label'     => { 'handler' => \&print_label,     'desc' => 'Generate text to label a print' },
		'locate'    => { 'handler' => \&print_locate,    'desc' => 'Locate a print in an archive' },
		'tone'      => { 'handler' => \&print_tone,      'desc' => 'Add toning to a print' },
		'order'     => { 'handler' => \&print_order,     'desc' => 'Register an order for a print' },
		'sell'      => { 'handler' => \&print_sell,      'desc' => 'Sell a print' },
		'unarchive' => { 'handler' => \&print_unarchive, 'desc' => 'Remove a print from a physical archive' },
		'worklist'  => { 'handler' => \&print_worklist,  'desc' => 'Display print todo list' },
		'tag'       => { 'handler' => \&print_tag,       'desc' => 'Write EXIF tags to scans from a print' },
	},
	scan => {
		'add'    => { 'handler' => \&scan_add,    'desc' => 'Add a new scan of a negative or print to the database' },
		'edit'   => { 'handler' => \&scan_edit,   'desc' => 'Add a new scan which is a derivative of an existing one' },
		'delete' => { 'handler' => \&scan_delete, 'desc' => 'Delete a scan from the database and optionally from the filesystem' },
		'search' => { 'handler' => \&scan_search, 'desc' => 'Search the filesystem for scans which are not in the database, and import them' },
	},
	run => {
		'task'   => { 'handler' => \&run_task,   'desc' => 'Run a selection of maintenance tasks on the database' },
		'report' => { 'handler' => \&run_report, 'desc' => 'Run a selection of reports on the database' },
	},
);

# This ensures the lib loads smoothly
1;
