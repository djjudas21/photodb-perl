#!/usr/bin/perl -w

use strict;
use warnings;
use App::photodb::commands;

# Default to a clean return code
my $return = 0;

# Filename of USAGE doc
my $filename = 'docs/USAGE.md';

# Load command mapping
my %handlers = %commands::handlers;

for my $command (sort keys %handlers) {
	# search for command heading
	# ## `command`
	if (system(qq{grep -q "^## \\`$command\\`" $filename})) {
		$return = 1;
		print "Could not find documentation for command \"$command\"\n";
	}
	for my $subcommand (sort keys %{$handlers{$command}}) {
		# search for subcommand heading
		# ### `command subcommand`
		if (system(qq{grep -q "^### \\`$command $subcommand\\`" $filename})) {
			$return = 1;
			print "Could not find documentation for subcommand \"$command $subcommand\"\n";
		}
	}
}

if ($return == 0) {
	print "Documentation seems to contain a section for every command and subcommand\n";
}
exit $return;
