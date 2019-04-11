package App::PhotoDB;

=head1 NAME

App::PhotoDB - App to manage a collection of film cameras & lenses

=head1 SYNOPSIS

All usage of PhotoDB is via the interactive command line, which is launched by running

    photodb

=head1 DESCRIPTION

PhotoDB is an attempt to create a database for film photography that can be used to track cameras, lenses, accessories, films, negatives and prints, to fully
catalogue a collection of photographic equipment as well as the pictures that are made with them. Read the CONCEPTS section for full details on the
capabilities of PhotoDB.

PhotoDB can also write EXIF tags to scanned images taken with film cameras, so they appear in your digital photo library with the correct metadata (time, date,
focal length, geotag, etc).

At the moment, the PhotoDB project is unfinished and the code continues to change unpredictably. Look for a tagged release in the future!

The heart of PhotoDB is the MySQL/MariaDB backend database schema. This is the most complete part of the project and describes all the data that is recorded.

The application is an interactive command-line tool to make it easier to add and edit data in the database. It is not a graphical interface or web application
(but someone with the right enthusiasm and skills could use the logic I've already written to make a basic graphical interface quite quickly).

PhotoDB should be able to run on pretty much any Linux distribution and MacOS as the Perl dependencies are portable. Soon there will be Docker support which
will simplify installation and allow PhotoDB to run anywhere, including on Windows.

The application is not *quite* feature-complete, so for now you may also need to edit parts of the database directly in some circumstances. You can access the
raw database using the MySQL command line, by using an application such as L<MySQL Workbench|http://www.mysql.com/products/workbench/> or
L<phpMyAdmin|http://www.phpmyadmin.net/home_page/index.php> to obtain a GUI for manipulating the tables.

=head1 CONCEPTS

=head2 Introduction

PhotoDB is a database and application for cataloguing film cameras, lenses, accessories, films, negatives and prints - as well a range of other information
such as exhibitions, orders, and darkroom chemicals. It is also capable of writing EXIF tags to JPG files scanned from negatives and prints.

PhotoDB is strictly governed by relational database principles which can make it seem fiddly and complicated to use, but this structured data gives PhotoDB
its power.

The data is all stored in a MySQL backend and managed by the PhotoDB app, which does its best to be helpful when adding data and hopefully hide most of the
sharp edges from the user.

This guide tries to explain the key concepts behind PhotoDB. It is not an exhaustive guide to every command available. To list all commands, run C<help>. To
list all subcommands available under a command, run (for example) C<camera>. Each subcommand has a brief explanation with it.

=head2 User data

Out of the box, PhotoDB is mostly empty, ready for you to enter your own data. However if you install PhotoDB in the recommended way, it comes with some pre-
filled data e.g. about manufacturers, film emulsions, film sizes, metering modes, etc, to get you up and running faster. In many cases you'll want to add to
this data to suit your own needs but you shouldn't need to edit anything that already exists.

The command C<data> has subcommands for adding various pieces of data. Normally, you shouldn't need to go out of your way to add this type of data, as PhotoDB
will prompt you if you need to add any while adding cameras, lenses, films, etc.

=head3 Unique identifiers

Every object registered in PhotoDB (e.g. camera, lenses, films, negatives, etc) is allocated a unique ID number, starting at 1 and counting up. This number is
used to reference other objects. This number is often prefixed with a C<#> for readability, e.g. _Film #99_.

One exception where alternative naming is also used is for negatives. A negative might have an ID of #100 but it may also be referred to in the format 18/6,
where 18 is the ID number of the film it belongs to, and 6 is the number of the frame, separated by a forward slash. This alternative system makes it easier
to handle negatives in the darkroom. It is accepted in most places in PhotoDB where a negative ID is needed.

=head3 Cameras and lenses

Cameras and lenses are the central component of PhotoDB. Cameras and lenses can relate to each other in one of two ways:
* directly, for fixed-lens cameras (e.g. compacts)
* via a lens mount, for interchangeable-lens cameras (e.g. SLRs)

You will be guided through questions when adding a new camera or lens by running C<camera add> or C<lens add>. When adding a fixed-lens camera you will be
asked to give details about the lens at the same time, which is then associated only with that camera. When adding an interchangeable-lens camera, you only
specify the lens mount. You can add lenses separately by running C<lens add>, which are then available to use with any camera with the same mount.

Cameras and lenses have properties of different types. Some are text (like the model name), some are numerical (like the maximum aperture of a lens), some are
yes/no (like whether a lens has autofocus) and some are multiple choice (like the different metering modes a camera supports).

=head3 Films and negatives

If you use the cameras and lenses to take photographs, you'll want to start entering information about films and negatives into PhotoDB. The word _negatives_
is a bit misleading as it refers to any image taken with a camera, including slides - which are positive!

PhotoDB lets you record a stash of films by running C<film add>, which you can then load into a camera with C<film load>. Films are associated with a camera.
They can be developed with C<film develop> and archived with C<film archive>.

When you take pictures, we recommend you take notes about your exposures using a smartphone app, a piece of paper, or what ever method suits you. Then you can
enter the data into PhotoDB at a later date. Negatives are associated with films and inherit some of their properties from the film they belong to. Negatives
are added by running C<negative add>.

Negatives are also associated with a lens, as on many cameras it is possible to change lens between exposures.

=head3 Prints

Whether you have a darkroom, or you get your negatives printed at a lab, PhotoDB can track your prints. Prints are associated with the negative they were made
from. You'll be able to add other info about how the print was made. Prints are added by running C<print add>.

You can also record orders for prints with C<print order>, view your printing to-do list with C<print worklist> and record sales of prints with C<print sell>.

=head3 Scans and tagging

Scans refer to digital versions of negatives, slides or prints that can be made with a scanner or a digital camera. Each negative/slide/print can be scanned
more than once. Each scan must be recorded separately. You can run C<scan add> to manually add a scan to the database.

PhotoDB needs you to set a directory on your computer for scans to be saved in. It prefers if its scans are the only thing in that directory. It is strongly
recommended to make a directory just for scans of your negatives and prints, e.g. C</home/you/Pictures/Scans> or similar. If you access PhotoDB on more than one
computer, you can configure a different directory on each computer.

Under this directory, PhotoDB expects there to be a subdirectory for each film. There is no mandatory naming specification, but the preferred convention is
the number of the film ID followed by a brief human-readable title, e.g. C<55 Holiday in Rome>.

Inside each subdirectory individual scans should be named C<<film_id>-<frame>-<filename>.jpg>, for example C<55-3-img123.jpg> or C<55-3-Coliseum.jpg> where C<55>
is the number of the film ID, C<3> is the frame number (as written on the edge of the film) and the rest can be anything you like. The scans should not be put
inside another subdirectory.

PhotoDB does not create these directories or the scans inside them. It is up to you to name the scans this way. However, if you stick to the above naming
convention, PhotoDB will at least record your scans and associate them with the right negative, to save you too much tedious data entry. You can tell PhotoDB
to search for and add scans automatically by running C<scan search>.

Once the scanned JPGs have been entered into the database and associated with negatives or prints, you can add EXIF tags to the JPGs - the same as would be
automatically written to JPGs taken by a digital camera. Supported tags include date, caption, geotag, exposure data, etc. This allows you to use almost any
digital photo management app to sort, browse, and view your images with ease.

Use C<negative tag> to tag all scans of a single negative or C<film tag> to tag all scans from an entire film.

It is safe to run tag commands more than once, as PhotoDB will only add or update tags that have changed.

=head3 Accessories

PhotoDB allows you to track your collection of camera and lens accessories, too. There are several "special" kinds of accessories that have their own
properties, commands and relationships, and there are general accessories with no special properties. You can create your own types of general accessory.

Special types of accessory with their own properties include:

=over

=item * battery

=item * filter

=item * filter adapter

=item * flash

=item * meter

=item * mount adapter

=item * projector

=item * teleconverter

=back

All of the above "special" accessories can be added to the database with C<accessory <accessory>>.

Types of general accessory with no special properties could include cases or straps. General accessories can be associated with cameras or lenses, or neither.
Add new general accessories with C<accessory add> and add new categories of general accessories with C<accessory category>.

=head1 Installing PhotoDB

=head2 Install database backend

A pre-requisite for PhotoDB is a functioning MySQL or MariaDB database instance. If you have access to an existing MySQL server, e.g. at a hosting provider,
note down the details for connecting (hostname or IP address, username, password).

Otherwise, consider installing a MySQL server locally on your computer. If you do this, the hostname will be C<localhost>.

Create an empty database schema and database user with a password for PhotoDB with sufficient privileges at least to SELECT, INSERT, UPDATE, DELETE, CREATE and
DROP. Detailed instructions are beyond the scope of this document but a basic setup would be:

    create schema photodb;
    grant all privileges on photodb.* to photodb@localhost identified by 'password';

=head2 Install application frontend

There are several different ways to install the application. Choose your favourite.
Install PhotoDB from CPAN or from a source tarball.

=head3 From CPAN

1. Use the C<cpan> client (or an alternative, such as C<cpanm>) to install directly:

    cpan App::PhotoDB

or

    cpanm App::PhotoDB

=head3 From source

1. Grab the latest release tarball from the [Releases page](https://github.com/djjudas21/photodb/releases).
It's the one with a name like C<App-PhotoDB-0.00.tar.gz>.

2. Install it with C<cpanm>:

    cpanm /path/tp/App-PhotoDB-0.00.tar.gz

=head3 Docker

Run PhotoDB on any platform, with Docker

1. Fetch the Docker image

    docker pull djjudas21/photodb

2. Run the image

    docker run -it --rm -v ~/.photodb:/root/.photodb --name photodb photodb

=head2 Configure database connection

There are three methods for connecting to the database:
1. Database and application on same computer
2. Database and application on different computers, connect via native MySQL
3. Database and application on different computers, connect via SSH tunnel

The app and accessory scripts need to know how to connect to the database. The first time you run PhotoDB, you will be prompted to enter connection details for
the database backend. If you need to edit the config in future, the config file is created at C</etc/photodb.ini>.

=head3 Tunnelling

If the database is on a remote server and does not have the MySQL port (3306) open to receive connections, you will need to set up a tunnel. Run the command
below, substituting in the correct hostname and username for the database server.

    ssh -L 3306:localhost:3306 -N <username>@<database.example.com>

Once the tunnel is established, you should be able to connect to the database on C<127.0.0.1:3306> and your connection will be tunnelled. Configure PhotoDB in
the same way as if the database was local. You will need to re-establish the tunnel each time you wish to use PhotoDB.

=head1 BUGS/CAVEATS/etc

Report bugs in the L<Github issue tracker|https://github.com/djjudas21/photodb/issues>

=head1 AUTHOR

Jonathan Gazeley

=head1 SEE ALSO

=over

=item * L<Developing PhotoDB|docs/CONTRIBUTING.pod>

=item * L<Schema description|docs/SCHEMA.pod>

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
our $VERSION = '0.04';

sub main {

	# Define handlers for each command
	my %handlers = %App::PhotoDB::commands::handlers;

	&welcome;

	# Connect to the database
	my $db = &db;

	# Set up terminal
	my $term = &term;

	# Enter interactive prompt and loop until exited by user
	while (1) {
		my $rv = &prompt({prompt=>'photodb', type=>'text', showtype=>0, showdefault=>0, char=>'>'});
		# Trap important keywords first
		if ($rv eq 'exit' || $rv eq 'quit') {
			last;
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

			# Execute chosen handler
			if (&prompt({prompt=>"$handlers{$command}{$subcommand}{'desc'}. Continue?", type=>'boolean', default=>'yes'})) {
				$handlers{$command}{$subcommand}{'handler'}->({db=>$db});
			}
		} else {
			# Print list of commands if unknown input is entered
			if ($rv ne '') {
				&nocommand(\%handlers);
			}
		}
	}
	$db->disconnect;
	return;
}

# This ensures the lib loads smoothly
1;
