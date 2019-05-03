#!/bin/sh

# Build the app
perl Build.PL
./Build
./Build install

# Configure PhotoDB
mkdir -p ~/.photodb
cat <<EOT >> ~/.photodb/photodb.ini
[database]
user=photodb
schema=photodb
pass=photodb
host=localhost
EOT

# Run Photodb to trigger migrations
# Exit straight away, but this still runs migrations
sudo apt-get install -y expect
./tests/migrations.exp

# Test all views by selecting from them
./tests/test-views.pl
