photography-database
====================

MySQL schema for a film photography database. This database schema can track cameras, lenses, films and negatives.

Some of the tables include sample data which you may wish to keep (e.g. film formats). Others are blank table structures for you to fill with your own data (e.g. cameras).

## Installation

This is just a set of sql files. Import them into your MySQL or MariaDB instance by running

```
mysql -p < *.sql
```

## Reference

These subheadings are for each table, and sub-subheadings are for each field.

### `CAMERA`

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

## Updating the schema

Make your edits to the schema using any tool you prefer (I like MySQL Workbench). Then use
the included script `dump-schema.pl` to export the dump files in the right format.

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
