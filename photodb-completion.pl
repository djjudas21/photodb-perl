#!/usr/bin/perl -wT

# Helper script for bash autocomplete that does nothing except
# list commands and subcommands

use strict;
use warnings;

use App::PhotoDB::commands;

my %handlers = %photodb::commands::handlers;

if ($ARGV[0] && $ARGV[0] ne '') {
	#print subcommands
	if (exists $handlers{$ARGV[0]}) {
		print "$_\n" for sort keys %{$handlers{$ARGV[0]}};
	}
} else {
	#print commands
	print "$_\n" for sort keys %handlers;
}

exit;
