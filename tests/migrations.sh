#!/bin/sh

# Build the app
perl Build.PL
./Build
./Build install

# Install DB
sudo apt-get update && sudo apt-get install mysql-server-5.6
mysql -uroot -e "create schema photodb; GRANT ALL PRIVILEGES ON photodb.* TO photodb@localhost IDENTIFIED BY 'photodb'"

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
photodb
