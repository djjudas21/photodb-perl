#!/usr/bin/perl -w

use strict;
use warnings;
use lib 'lib';
use funcs;

# Default to a clean return code
my $return = 0;

# Filename of FUNCS doc
my $docs = 'docs/FUNCTIONS.md';

# Filename of FUNCS module
my $funcs = 'lib/funcs.pm';

# List all funcs in the module
my @funclist = `grep ^sub $funcs`;

foreach my $func (@funclist) {
	# Strip grep output to get real func name
	$func =~ m/^sub (\w+) \{$/;
	my $funcname = $1;

	# Test if func exists in docs
	# search for heading
	# ## `annotatefilm`
	if (system(qq{grep -q "^## \\`$funcname\\`" $docs})) {
		$return = 1;
		print "Could not find documentation for function \"$funcname\"\n";
	}
}

if ($return == 0) {
	print "Documentation seems to contain a section for every function\n";
}
exit $return;
