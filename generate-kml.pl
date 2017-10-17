#!/usr/bin/perl -wT
# Generate KML file of all locations that film photos have been taken

use strict;
use warnings;
use XML::Generator;
use strict;
use DBI;
use DBD::mysql;

# CONFIG VARIABLES
my $database = 'photography';
my $host = '192.168.0.2';
my $user = 'photography';
my $pw = 'photography';

# PERL DBI CONNECT
my $dsn = "dbi:mysql:$database:$host:3306";
my $db = DBI->connect($dsn, $user, $pw);

# Set up XML object
my $gen = XML::Generator->new(':pretty');

# Create XML global stuff
#print my $headers = $gen->

# SQL query to fetch list of co-ordinates
# For some reason, Google Earth reverses lat/long
my $select_sql = qq{select concat(longitude, ',', latitude) as coords from NEGATIVE where latitude is not null and longitude is not null
};

# Prepare and execute the select SQL
my $select_sth = $db->prepare($select_sql);
$select_sth->execute();

# Now loop round, one row at a time
my @placemarks;
while(my $row = $select_sth->fetchrow_array) {

  my $xml = $gen->Placemark(
#    $gen->name($row),
    $gen->Point(
      $gen->coordinates($row)
    )
  );

  push(@placemarks, $xml)
}

print my $headers = $gen->kml(
  $gen->Document(
    @placemarks
  )
);

#print @placemarks;

# Sample KML
#<?xml version="1.0" encoding="UTF-8"?>
#<kml xmlns="http://www.opengis.net/kml/2.2">
#<Document>
#<Placemark>
#  <name>New York City</name>
#  <description>New York City</description>
#  <Point>
#    <coordinates>-74.006393,40.714172,0</coordinates>
#  </Point>
#</Placemark>
#</Document>
#</kml>

#Because default namespaces inherit, XML::Generator takes care to output the xmlns="URI" attribute as few times as strictly necessary. For example,
#   $xml = $gen->account(
#            $gen->open(['transaction'], 2000),
#            $gen->deposit(['transaction'], { date => '1999.04.03'},
#              $gen->amount(['transaction'], 1500)
#            )
#          );

#This generates:
#   <account>
#     <open xmlns="transaction">2000</open>
#     <deposit xmlns="transaction" date="1999.04.03">
#       <amount>1500</amount>
#     </deposit>
#   </account>
