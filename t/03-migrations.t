use Test::Expect;
use Test::More tests => 1;
expect_run(
  command => ["bin/photodb -h localhost -s photodb -u photodb -p photodb"],
  prompt  => 'photodb> ',
  quit    => 'exit',
);
#expect_is('photodb> ');
#expect("ping", "pong", "expect");
#expect_send("ping", "expect_send");
#expect_is("* Hi there, to testme", "expect_is");
#expect_like(qr/Hi there, to testme/, "expect_like");
