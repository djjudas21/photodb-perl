# This set of tests runs PhotoDB against a dummy local database
# and attempts to run real commands

use Test::Expect;
use Test::More tests => 7;

# Local test database credentials
my $host = 'localhost';
my $schema = 'photodb';
my $user = 'photodb';
my $pass = 'photodb';

# Start up PhotoDB, connected to local db
expect_run(
  command => ["bin/photodb -h $host -s $schema -u $user -p $pass --skipmigrations"],
  prompt  => ['photodb> ', -re => '^.+: '],
  quit    => 'exit',
);

# run migrations - run migrations to configure schema
expect_send("run migrations", 'run migrations');
# Run migrations to upgrade the database schema to the latest version. Continue? (boolean) [yes]:
expect_send('yes', 'yes');
expect_like(qr/Applied migration|Up to date/, 'migrations complete');

# db test - test db connectivity
expect_send("db test", 'db test');
#Test database connectivity. Continue? (boolean) [yes]:
expect_send('yes', 'yes');
expect_like(qr/Connected to /, 'connected');

#mount info - test searching data
#expect_send("mount info", 'mount info');
#View compatible cameras and lenses for a mount. Continue? (boolean) \[yes\]: "
#expect_send('yes', 'yes');
#Please select a mount from the list (text) \[\]: "
#expect_send('1', 'mount_id 1');
#expect_like(qr/Now showing/, 'now showing');

# Future handler placeholders
#accessory info
#accessory search
#archive info
#archive list
#camera choose
#camera display-lens
#camera info
#camera search
#camera show-lenses
#db logs
#db stats YES
#db upgrade
#enlarger info
#exhibition info
#film current
#film info
#film locate
#film search
#film stocks
#lens info
#lens search
#movie info
#negative info
#negative prints
#negative search
#print info
#print label
#print locate
#print worklist
#scan search
#run report
