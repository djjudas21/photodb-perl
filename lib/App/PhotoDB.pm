package App::PhotoDB;

=head1 NAME

App::PhotoDB - App to manage a collection of film cameras & lenses

=head1 SYNOPSIS

All usage of PhotoDB is via the interactive command line, which is launched by running

    photodb

=head1 DESCRIPTION

PhotoDB is an attempt to create a database for film photography that can be used to track
cameras, lenses, accessories, films, negatives and prints, to fully catalogue a collection of
photographic equipment as well as the pictures that are made with them. Read the
L<Concepts|docs/CONCEPTS.md> document for full details on the capabilities of PhotoDB.

PhotoDB can also write EXIF tags to scanned images taken with film cameras, so they appear in
your digital photo library with the correct metadata (time, date, focal length, geotag, etc).

At the moment, the PhotoDB project is unfinished and the code continues to change unpredictably.
Look for a tagged release in the future!

The heart of PhotoDB is the MySQL/MariaDB backend database schema. This is the most complete
part of the project and describes all the data that is recorded.

The application is an interactive command-line tool to make it easier to add and edit data in
the database. It is not a graphical interface or web application (but someone with the right
enthusiasm and skills could use the logic I've already written to make a basic graphical
interface quite quickly).

PhotoDB runs only on Linux systems and there are L<installation instructions|docs/INSTALL.md>
for Fedora and Ubuntu Linux. However it should be able to run on pretty much any Linux
distribution and MacOS as the Perl dependencies are portable. Soon there will be Docker support
which will simplify installation and allow PhotoDB to run anywhere, including on Windows.

The application is not *quite* feature-complete, so for now you may also need to edit parts of
the database directly in some circumstances. You can access the raw database using the MySQL
command line, by using an application such as L<MySQL Workbench|http://www.mysql.com/products/workbench/>
or L<phpMyAdmin|http://www.phpmyadmin.net/home_page/index.php> to obtain a GUI for manipulating
the tables.

=head1 BUGS/CAVEATS/etc

Report bugs in the L<Github issue tracker|https://github.com/djjudas21/photography-database/issues>

=head1 AUTHOR

Jonathan Gazeley

=head1 SEE ALSO

=over

=item * L<Installing PhotoDB|docs/INSTALL.md>

=item * L<Using PhotoDB|docs/USAGE.md>

=item * L<Developing PhotoDB|docs/CONTRIBUTING.md>

=item * L<Schema description|docs/SCHEMA.md>

=item * L<Concepts|docs/CONCEPTS.md>

=back

=head1 COPYRIGHT and LICENSE

=cut

use strict;
use warnings;
binmode(STDOUT, ":encoding(UTF-8)");
binmode(STDIN, ":encoding(utf8)");

use App::PhotoDB::funcs qw(/./);
use App::PhotoDB::handlers;
use App::PhotoDB::commands;

# Authoritative distro version
our $VERSION = '0.00';

sub main {

	# Define handlers for each command
	my %handlers = %App::PhotoDB::commands::handlers;

	# Check if any args were passed in
	if (defined($ARGV[0])) {
		# We got at least one cmdline arg, so we run in one-shot mode

		# Read in and verify command
		my $command = $ARGV[0];
		if ((!defined $command) || (!exists $handlers{$command})) {
			&nocommand(\%handlers);
			exit;
		}

		# Read in and verify subcommand
		my $subcommand = $ARGV[1];
		if ((!defined $subcommand) || (!exists $handlers{$command}{$subcommand})) {
			&nosubcommand(\%{$handlers{$command}}, $command);
			exit;
		}

		# Connect to the database
		my $db = &db;

		# Execute chosen handler
		if (&prompt({prompt=>"$handlers{$command}{$subcommand}{'desc'}. Continue?", type=>'boolean', default=>'yes'})) {
			$handlers{$command}{$subcommand}{'handler'}->($db);
		}

		# Exit after one job
		exit;
	} else {
		# No cmdline args, so enter interactive prompt and loop until exited by user
		&welcome;
		while (1) {
			my $rv = &prompt({prompt=>'photodb', type=>'text', showtype=>0, showdefault=>0, char=>'>'});
			# Trap important keywords first
			if ($rv eq 'exit' || $rv eq 'quit') {
				exit;
			} elsif ($rv =~ /^(\w+) ?([\w-]+)?$/) {
				# Match a command and an optional subcommand
				# Check if the command is defined in the handlers
				my $command = $1;
				if (!exists $handlers{$command}) {
					&nocommand(\%handlers);
					next;
				}

				# Check if the subcommand is defined in the handlers
				my $subcommand = $2;
				if (!exists $handlers{$command}{$subcommand}) {
					&nosubcommand(\%{$handlers{$command}}, $command);
					next;
				}

				# Connect to the database
				my $db = &db;

				# Execute chosen handler
				if (&prompt({prompt=>"$handlers{$command}{$subcommand}{'desc'}. Continue?", type=>'boolean', default=>'yes'})) {
					$handlers{$command}{$subcommand}{'handler'}->($db);
				}
			} else {
				# Print list of commands if unknown input is entered
				if ($rv ne '') {
					&nocommand(\%handlers);
				}
			}
		}
	}
	return;
}

# This ensures the lib loads smoothly
1;
