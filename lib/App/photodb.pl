#!/usr/bin/env perl

package App::photodb;

# Interactive user interface for interacting with the PhotoDB database backend

use strict;
use warnings;
binmode(STDOUT, ":encoding(UTF-8)");
binmode(STDIN, ":encoding(utf8)");

use App::photodb::funcs qw(/./);
use App::photodb::handlers;
use App::photodb::commands;

# Define handlers for each command
my %handlers = %photodb::commands::handlers;

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
