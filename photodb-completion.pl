#!/usr/bin/perl -wT

# Helper script for bash autocomplete that does nothing except
# list commands and subcommands

use strict;
use warnings;

use lib 'lib';
use commands;

my %handlers = %commands::handlers;

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
