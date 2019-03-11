use Module::Build;
my $build = Module::Build->new (
	module_name => 'App::PhotoDB',
	dist_author => 'Jonathan Gazeley <me@jonathangazeley.com>',
	license  => 'perl',
	requires => {
		'Config::IniHash' => 0,
		'DBD::mysql' => 0,
		'DBI' => 0,
		'Exporter' => 0,
		'Image::ExifTool' => 0,
		'SQL::Abstract' => 0,
		'strict' => 0,
		'warnings' => 0,
		'YAML' => 0,
		'Perl::Critic' => 0,
		'experimental' => 0,
		'Path::Iterator::Rule' => 0,
		'Array::Utils' => 0,
		'File::Basename' => 0,
		'Text::TabularDisplay' => 0,
		'Getopt::Long' => 0,
		'Term::ReadKey' => 0,
	},
	test_requires => {
		'Test::More' => '0.47',
		'Test::Perl::Critic' => 0,
		'Test::Compile' => 0,
	},
);
$build->create_build_script;
