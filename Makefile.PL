use strict;
use warnings;
 
use 5.008004;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME             => 'App::PhotoDB',
  VERSION_FROM     => 'lib/App/photodb.pm',
#  ABSTRACT_FROM    => 'lib/App/foo.pm',
  AUTHOR           => 'Jonathan Gazeley',
  LICENSE          => 'freebsd',
  MIN_PERL_VERSION => '5.008004',
  EXE_FILES        => ['script/photodb'],
  PREREQ_PM        => {
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
  (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? (META_MERGE => {
      'meta-spec' => { version => 2 },
      resources => {
          repository => {
              type => 'git',
              url  => 'https://github.com/djjudas21/photography-database.git',
              web  => 'https://github.com/djjudas21/photography-database',
          },
      }})
   : ()
  ),
);
