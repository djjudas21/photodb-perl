use Test::Expect;
use Test::More tests => 3;

expect_run(
  command => ["bin/photodb -h localhost -s photodb -u photodb -p photodb --skipmigrations"],
  prompt  => 'photodb> ',
  quit    => 'exit',
);

expect_send("run migrations\n", "run migrations");
expect_like(qr/Applied migration /, "applied migrations");
