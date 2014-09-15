photography-database
====================

MySQL schema for a film photography database. This database schema can track cameras, lenses, films and negatives
to fully catalogue a collection of camera, lenses, accessories as well as negatives and prints.

This project is just the schema - no application is included. You can use the raw database using the MySQL command
line, or by using an application such as [MySQL Workbench](http://www.mysql.com/products/workbench/) or
[phpMyAdmin](http://www.phpmyadmin.net/home_page/index.php) to obtain a GUI for manipulating the tables.

## Table of Contents

1. [Usage](#usage)
    * [Installation](#installation)
    * [Sample data](#sample-data)
    * [Upgrading](#upgrading)
    * [Altering the schema](#altering-the-schema)
2. [Reference](#reference)
    * [BACK](#back)
    * [BATTERY](#battery)
    * [BODY_TYPE](#body_type)
    * [CAMERA](#camera)
    * [CONDITION](#condition)
    * [DEVELOPER](#developer)
    * [DEV_BATCH](#dev_batch)
    * [ENLARGER](#enlarger)
    * [FILM](#film)
    * [FILMSTOCK](#filmstock)
    * [FILTER](#filter)
    * [FILTER_ADAPTER](#filter_adapter)
    * [FLASH](#flash)
    * [FOCUS_TYPE](#focus_type)
    * [FORMAT](#format)
    * [LENS](#lens)
    * [LENS_TYPE](#lens_type)
    * [LIGHT_METER](#light_meter)
    * [LOCATION](#location)
    * [MANUFACTURER](#manufacturer)
    * [METERING_PATTERN](#metering_pattern)
    * [METERING_TYPE](#metering_type)
    * [MOTION_PICTURE_FILM](#motion_picture_film)
    * [MOUNT](#mount)
    * [MOUNT_ADAPTER](#mount_adapter)
    * [NEGATIVE](#negative)
    * [NEGATIVE_SIZE](#negative_size)
    * [PAPER_STOCK](#paper_stock)
    * [PHOTOGRAPHER](#photographer)
    * [PRINT](#print)
    * [PROCESS](#process)
    * [PROJECTOR](#projector)
    * [REPAIR](#repair)
    * [SHUTTER_TYPE](#shutter_type)
    * [TELECONVERTER](#teleconverter)
    * [TONER](#toner)


## Usage

### Installation

This is just a set of SQL files that describe the schema for a photographic database. Import them
into your MySQL or MariaDB instance by running the following command to create the database and tables.

```
mysql -p < *.sql
```

### Sample data

Some of the tables in this schema contain sample data which could be useful and is not site-specific.
This includes data like common manufacturers, lens mounts and film types. Toimport the sample data,
first install the schema and then execute:

```
mysql -p photography < sample-data
```

### Upgrading

Upgrading to a new version of the schema is tricky. You can of course do a `git pull` to get the
latest schema files and then execute `mysql -p photography < *.sql` again, but this will discard
all of your data. The only real upgrade path is to back up your data, drop and create the new schema,
and re-import your data.

### Altering the schema

This section describes how to alter the schema, and document the changes.

Make your edits to the schema using any tool you prefer (I like MySQL Workbench). Then use
the included Perl script `dump-schema.pl` to export the dump files in the right format.

You'll need the following CPAN modules on your system:
 * `Getopt::Long`
 * `Term::ReadKey`
 * `DBI`
 * `DBD::MySQL`

`Getopt::Long` seems to be standard in the Red Hat distribution of Perl but you'll need
to install the others by doing:

```
yum install perl-TermReadKey perl-DBI perl-DBD-MySQL
```

Change into the working directory of the script and do the following:

```
./dump-schema.pl --hostname 192.168.0.1 --database photography --username joebloggs

# Default values:
# hostname = localhost
# database = photography
# username = whoever is currently logged in
```

The script **will delete all existing SQL dump files and write them out again**. Do not run
this in random paths on your system!

After running the script, check which files have been added, removed or changed, and then commit
the diffs with a meaningful commit message.


## Reference

These subheadings are for each table, and sub-subheadings are for each field.

### `BACK`

Inventory of interchangeable film backs, for cameras that can use them.

### `BATTERY`

Inventory of types of battery commonly used in photography.

### `BODY_TYPE`

Inventory of types of camera body (e.g. SLR, TLR, compact, etc).

### `CAMERA`

Inventory of cameras.

#### `camera_id`
Integer. PK auto-increment.
#### `manufacturer_id`
Integer. FK on `MANUFACTURER`, denotes the manufacturer of the camera.
#### `model`
String. The model name of the camera.
#### `mount_id`
Integer. FK on `MOUNT`, denotes the lens mount of the camera if it is an interchangeable-lens camera.
#### `format_id`
Integer. FK on `FORMAT`, denotes the film format of the camera.
#### `focus_type_id`
Integer. FK on `FOCUS_TYPE`, denotes the focus type of the camera.
#### `metering`
Boolean. Whether the camera has built-in metering.
#### `coupled_metering`
Boolean. Whether the camera's meter is coupled automatically.
#### `metering_pattern_id`
Integer. FK on `METERING_PATTERN`, denotes the meter's sensitivity pattern.
#### `metering_type_id`
Integer. FK on `METERING_TYPE`, denotes the technology used in the meter.
#### `body_type_id`
Integer. FK on `BODY_TYPE`, denotes the style of camera body.
#### `weight`
Integer. Weight of the camera body (without lens or batteries) in grammes (g).
#### `acquired`
Date. Date on which the camera was acquired.
#### `cost`
Decimal. Price paid for the camera, in local currency units.
#### `introduced`
Integer. Year in which the camera model was introduced.
#### `discontinued`
Integer. Year in which the camera model was discontinued.
#### `serial`
String. Serial number of the camera.
#### `datecode`
String. Date code of the camera, if different from the serial number.
#### `manufactured`
Integer. Year of manufacture of the camera.
#### `own`
Boolean. Whether the camera is currently owned.
#### `negative_size_id`
Integer. FK on `NEGATIVE_SIZE`, denotes the size of negative made by the camera.
#### `shutter_type_id`
Integer. FK on `SHUTTER_TYPE`, denotes type of shutter.
#### `cable_release`
Boolean. Whether the camera has the facility for a remote cable release.
#### `viewfinder_coverage`
Integer. Percentage coverage of the viewfinder. Mostly applicable to SLRs.
#### `power_drive`
Boolean. Whether the camera has integrated motor drive.
#### `continuous_fps`
Decimal. The maximum rate at which the camera can shoot, in frames per second.
#### `video`
Boolean. Whether the camera can take video/movie.
#### `digital`
Boolean. Whether this is a digital camera.
#### `fixed_mount`
Boolean. Whether the camera has a fixed lens.
#### `lens_id`
Integer. If `fixed_mount` is true, specify the `lens_id`. FK on `LENS`.
#### `battery_qty`
Integer. Quantity of batteries needed.
#### `battery_type`
Integer. FK on `BATTERY`, denotes type of battery needed
#### `notes`
Text. Freeform text field for extra notes.
#### `lost`
Date. Date on which the camera was lost/sold/etc.
#### `lost_price`
Decimal. Price at which the camera was sold.
#### `source`
String. Where the camera was obtained.
#### `M`
Boolean. Whether the camera supports full manual exposure.
#### `Av`
Boolean. Whether the camera supports aperture-priority exposure.
#### `Tv`
Boolean. Whether the camera supports shutter-priority exposure.
#### `P`
Boolean. Whether the camera supports program/auto exposure.
#### `min_shutter`
String. Fastest available shutter speed, expressed like `1/400`.
#### `max_shutter`
String. Slowest available shutter speed, expressed like `30"`.
#### `bulb`
Boolean. Whether the camera supports bulb (B) exposure.
#### `time`
Boolean. Whether the camera supports time (T) exposure.
#### `min_iso`
Integer. Minimum ISO the camera will accept for metering.
#### `max_iso`
Integer. Maximum ISO the camera will accept for metering.
#### `af_points`
Interger. Number of autofocus points.
#### `int_flash`
Boolean. Whether the camera has an integrated flash.
#### `ext_flash`
Boolean. Whether the camera supports an external flash.
#### `pc_sync`
Boolean. Whether the camera has a PC sync socket for flash.
#### `hotshoe`
Boolean. Whether the camera has a hotshoe.
#### `coldshoe`
Boolean. Whether the camera has a coldshoe or accessory shoe.
#### `x_sync`
String. X-sync shutter speed, expressed like `1/125`.
#### `meter_min_ev`
Integer. Lowest EV/LV the built-in meter supports.
#### `meter_max_ev`
Integer. Highest EV/LV the built-in meter supports.
#### `condition_id`
Integer. FK on `CONDITION`, denotes the cosmetic condition of the camera.

### `CONDITION`

List of types of cosmetic condition ranking.

### `DEVELOPER`

Inventory of types of photographic developer.

### `DEV_BATCH`

Inventory of batches of developer that have been prepared.

### `ENLARGER`

Inventory of photographic enlargers.

### `FILM`

Inventory of rolls/sheets of film that have been exposed and developed.

### `FILMSTOCK`

Inventory of types of film stock available.

### `FILTER`

Inventory of photographic filters.

### `FILTER_ADAPTER`

Inventory of screw-thread filter adapters.

### `FLASH`

Inventory of external flash units.

### `FOCUS_TYPE`

List of types of focus system (e.g. SLR, rangefinder, etc)

### `FORMAT`

List of film formats.

### `LENS`

Inventory of lenses, including interchangeable camera lenses, fixed lenses in compact
cameras and enlarger lenses.

### `LENS_TYPE`

Categories of lenses based on field of view.

### `LIGHT_METER`

Inventory of light meters.

### `LOCATION`

List of locations (places) where photographs have been taken.

### `MANUFACTURER`

List of manufacturers of photographic equipment.

### `METERING_PATTERN`

List of metering modes (e.g. spot, centre, average).

### `METERING_TYPE`

List of technologies that can be used in light metering (e.g. selenium, CdS, etc)

### `MOTION_PICTURE_FILM`

Inventory of motion picture (movie) films that have been exposed and developed.

### `MOUNT`

Inventory of lens mount systems (e.g. Canon FD, Nikon F, etc)

### `MOUNT_ADAPTER`

Inventory of lens mount adapters which can be used to mount lenses on other camera systems.

### `NEGATIVE`

Inventory of negatives (and slides) that have been exposed and developed.

### `NEGATIVE_SIZE`

List of negative sizes that can be made.

### `PAPER_STOCK`

Inventory of photographic paper stock

### `PHOTOGRAPHER`

List of people who have taken photographs that are catalogued in this database.

### `PRINT`

Inventory of photographic prints made from negatives that are catalogued in the `NEGATIVE` table.

### `PROCESS`

List of chemical photographic processes (e.g. C-41, E-6, etc)

### `PROJECTOR`

Inventory of projectors for slides and motion picture films.

### `REPAIR`

Log of repairs performed on cameras and lenses in this database.

### `SHUTTER_TYPE`

List of shutter types (e.g. leaf, focal plane, etc)

### `TELECONVERTER`

Inventory of teleconverters.

### `TONER`

Inventory of chemical toners for use when printing.
