#!/bin/sh

# Build the app
perl Build.PL
./Build
./Build install

# Run Photodb to trigger migrations
# Exit straight away, but this still runs migrations
./tests/migrations.exp
