#!/usr/bin/perl -wT

use DB::SQL::Migrations;
use DBI;
use DBD::mysql;

my $hostname = $ENV{'DBHOST'};
my $database = $ENV{'DBNAME'};
my $username = $ENV{'DBUSER'};
my $password = $ENV{'DBPASS'};

my $dbh = DBI->connect("DBI:mysql:database=$database;host=$hostname", $username, $password,
	{
		# Required for updates to work properly
		mysql_client_found_rows => 0,
		# Required to print symbols
		mysql_enable_utf8mb4 => 1,
	}
) or die "Couldn't connect to database: " . DBI->errstr;

my $migrator = DB::SQL::Migrations->new(dbh=>$dbh, migrations_directory=>'migrations');

# Creates migrations table if it doesn't exist
$migrator->create_migrations_table();

# Run migrations
$migrator->apply();
