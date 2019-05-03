use strict;
use warnings;
use Test::More tests => 2;
use Expect;

# Create an Expect object by spawning PhotoDB
my $exp;
ok($exp = Expect->spawn('bin/photodb'), 'spawn PhotoDB');

# Wait for PhotoDB to give us the prompt (i.e. it has completed migrations)
# We allow 60 seconds in case the DB is slow
$exp->send("\n");
ok($exp->expect(60, 'photodb>'), 'migrations');

# Issue the command to exit
$exp->send("exit\n");

# do a soft_close to nicely shut down the command
$exp->soft_close();
