use strict;
use warnings;
use Test::More;
use DBI;

SKIP: {
	# Only execute this set if we have a test DB
	my $dbh = DBI->connect('DBI:mysql:photodb:localhost', 'photodb', 'photodb');
	skip 'Could not connect to database', 1 if (!$dbh);

	# Get a list of all views
	my $query = "SHOW FULL TABLES WHERE TABLE_TYPE LIKE 'VIEW'";
	my $sth = $dbh->prepare($query) or die "Can't prepare $query: $dbh->errstr\n";
	my $rv = $sth->execute or die "can't execute the query: $sth->errstr";

	my @views;
	while (my @row = $sth->fetchrow_array) {
		push(@views, $row[0]);
	}

	my $numviews = scalar @views;
	#	print "Found $numviews views\n";
	plan tests => $numviews;

	# Test each view
	my @passes;
	my @failures;
	foreach my $view (@views) {
		ok(!&test_view($dbh, $view), "view $view");
		#		if (my $error = &test_view($view)) {
		#			# fail
		#			print "$view is broken: $error\n";
		#			push(@failures, $view);
		#		} else {
		#			# pass
		#			push(@passes, $view);
		#		}
		#	}

		#	my $numpasses = scalar @passes;
		#	my $numfailures = scalar @failures;

		#	print "$numpasses views passed\n";
		#	print "$numfailures views failed\n";

		#	if ($numfailures > 0) {
		#		exit 1;
		#	} else {
		#		exit 0;
	}
}

# Test a view
# Returns 0 for OK, error message if not
sub test_view {
	my $dbh = shift;
	my $view = shift;
	my $sth2 = $dbh->prepare("select * from $view") or return $dbh->errstr;
	my $rv2 = $sth2->execute or return $sth2->errstr;
	return 0;
}
