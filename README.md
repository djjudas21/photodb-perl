PhotoDB
=======

PhotoDB is an attempt to create a database for film photography that can be used to track
cameras, lenses, films and negatives to fully catalogue a collection of cameras, lenses,
accessories as well as negatives and prints.

At the moment, the PhotoDB project is unfinished and the code continues to change unpredictably.

#### The schema

The heart of PhotoDB is the MySQL/MariaDB database schema. This is the most complete
part of the project.

#### The application

The application is a relatively new addition to the project. It is currently an interactive
command-line tool to make it easier to add and edit data in the database. It is not a graphical
interface or web application.

It is not feature-complete, so for now you will also need to edit parts of the database directly.
You can use the raw database using the MySQL command line, or by using an application such as
[MySQL Workbench](http://www.mysql.com/products/workbench/) or
[phpMyAdmin](http://www.phpmyadmin.net/home_page/index.php) to obtain a GUI for manipulating the tables.

## Table of Contents

1. [Installation](#installation)
    * [Install MySQL](#install-mysql)
    * [Create a user](#create-a-user)
    * [Import the schema](#import-the-schema)
    * [Import sample data](#import-sample-data)
2. [Usage](#usage)
    * [Upgrading](#upgrading)
    * [Altering the schema](#altering-the-schema)
3. [Reference](#reference)
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

## Installation

### Install MySQL
A pre-requisite for PhotoDB is a functioning MySQL or MariaDB database instance. If you have access to an existing
MySQL server, e.g. at a hosting provider, note down the details for connecting (hostname or IP address, username, password).

Otherwise, consider installing a MySQL server locally on your computer. If you do this, the hostname will be `localhost`.

CentOS / Red Hat:
```
sudo yum install mysql-server
sudo chkconfig mysqld on
sudo service mysqld start
```

Fedora:
```
sudo yum install mariadb-server
sudo systemctl mariadb on
sudo systemctl mariadb start
```

Ubuntu:
```
sudo apt-get install mysql-server
# enable on boot
# start service
```

### Create a user
Create a database user with a password for PhotoDB

### Import the schema
Import the schema into your MySQL or MariaDB instance by running the following command to create the database and tables.

```
mysql -p < schema/*.sql
```

### Import sample data

Some of the tables in this schema contain sample data which could be useful and is not site-specific.
This includes data like common manufacturers, lens mounts and film types. To import the sample data,
first [install the schema](#installation) and then execute:

```
mysql -p photography < sample-data/*.sql
```

## Usage

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

These subheadings are for each table, and the data about the tables was generated automagically by
executing

```sql
SELECT concat('`', COLUMN_NAME, '`') as COLUMN_NAME, concat('`', COLUMN_TYPE, '`') as COLUMN_TYPE, COLUMN_COMMENT FROM information_schema.columns WHERE table_name = 'CAMERA';
```

### `BACK`

Inventory of interchangeable film backs, for cameras that can use them.

| COLUMN_NAME        | COLUMN_TYPE   | COLUMN_COMMENT                                   |
|--------------------|---------------|--------------------------------------------------|
| `back_id`          | `int(11)`     | Unique ID for the film back                      |
| `manufacturer_id`  | `int(11)`     | Denotes the manufacturer of the camera           |
| `format_id`        | `int(11)`     | Denotes the film format that the back accepts    |
| `negative_size_id` | `int(11)`     | Denotes the negative size that the back produces |
| `back_mount_id`    | `int(11)`     |                                                  |
| `model`            | `varchar(45)` | Model name of the film back                      |
| `qty_shots`        | `int(11)`     | Number of exposures this back can hold           |
| `qty_backs`        | `int(11)`     | Quantity of backs like this that you own         |

### `BATTERY`

Inventory of types of battery commonly used in photography.

| COLUMN_NAME    | COLUMN_TYPE    | COLUMN_COMMENT                                  |
|----------------|----------------|-------------------------------------------------|
| `battery_type` | `int(11)`      | Unique battery ID                               |
| `battery_name` | `varchar(45)`  | Common name of the battery                      |
| `voltage`      | `decimal(4,2)` | Nominal voltage of the battery                  |
| `chemistry`    | `varchar(45)`  | Battery chemistry (e.g. Alkaline, Lithium, etc) |

### `BODY_TYPE`

Inventory of types of camera body (e.g. SLR, TLR, compact, etc).

| COLUMN_NAME    | COLUMN_TYPE   | COLUMN_COMMENT                                    |
|----------------|---------------|---------------------------------------------------|
| `body_type_id` | `int(11)`     | Unique body type ID                               |
| `body_type`    | `varchar(45)` | Name of camera body type (e.g. SLR, compact, etc) |

### `CAMERA`

Inventory of cameras.

| COLUMN_NAME           | COLUMN_TYPE    | COLUMN_COMMENT                                                               |
|-----------------------|----------------|------------------------------------------------------------------------------|
| `camera_id`           | `int(11)`      | Auto-incremented camera ID                                                   |
| `manufacturer_id`     | `int(11)`      | Denotes the manufacturer of the camera.                                      |
| `model`               | `varchar(45)`  | The model name of the camera                                                 |
| `mount_id`            | `int(11)`      | Denotes the lens mount of the camera if it is an interchangeable-lens camera |
| `format_id`           | `int(11)`      | Denotes the film format of the camera                                        |
| `focus_type_id`       | `int(11)`      | Denotes the focus type of the camera                                         |
| `metering`            | `tinyint(1)`   | Whether the camera has built-in metering                                     |
| `coupled_metering`    | `tinyint(1)`   | Whether the camera's meter is coupled automatically                          |
| `metering_pattern_id` | `int(11)`      | Denotes the meter's sensitivity pattern                                      |
| `metering_type_id`    | `int(11)`      | Denotes the technology used in the meter                                     |
| `body_type_id`        | `int(11)`      | Denotes the style of camera body                                             |
| `weight`              | `int(11)`      | Weight of the camera body (without lens or batteries) in grammes (g)         |
| `acquired`            | `date`         | Date on which the camera was acquired                                        |
| `cost`                | `decimal(6,2)` | Price paid for the camera, in local currency units                           |
| `introduced`          | `smallint(6)`  | Year in which the camera model was introduced                                |
| `discontinued`        | `smallint(6)`  | Year in which the camera model was discontinued                              |
| `serial`              | `varchar(45)`  | Serial number of the camera                                                  |
| `datecode`            | `varchar(12)`  | Date code of the camera, if different from the serial number                 |
| `manufactured`        | `smallint(6)`  | Year of manufacture of the camera                                            |
| `own`                 | `tinyint(1)`   | Whether the camera is currently owned                                        |
| `negative_size_id`    | `int(11)`      | Denotes the size of negative made by the camera                              |
| `shutter_type_id`     | `int(11)`      | Denotes type of shutter                                                      |
| `cable_release`       | `tinyint(1)`   | Whether the camera has the facility for a remote cable release               |
| `viewfinder_coverage` | `int(11)`      | Percentage coverage of the viewfinder. Mostly applicable to SLRs.            |
| `power_drive`         | `tinyint(1)`   | Whether the camera has integrated motor drive                                |
| `continuous_fps`      | `decimal(3,1)` | The maximum rate at which the camera can shoot, in frames per second         |
| `video`               | `tinyint(1)`   | Whether the camera can take video/movie                                      |
| `digital`             | `tinyint(1)`   | Whether this is a digital camera                                             |
| `fixed_mount`         | `tinyint(1)`   | Whether the camera has a fixed lens                                          |
| `lens_id`             | `int(11)`      | If fixed_mount is true, specify the lens_id                                  |
| `battery_qty`         | `int(11)`      | Quantity of batteries needed                                                 |
| `battery_type`        | `int(11)`      | Denotes type of battery needed                                               |
| `notes`               | `text`         | Freeform text field for extra notes                                          |
| `lost`                | `date`         | Date on which the camera was lost/sold/etc                                   |
| `lost_price`          | `decimal(6,2)` | Price at which the camera was sold                                           |
| `source`              | `varchar(150)` | Where the camera was acquired from                                           |
| `M`                   | `tinyint(1)`   | Whether the camera supports full manual exposure                             |
| `Av`                  | `tinyint(1)`   | Whether the camera supports aperture-priority exposure                       |
| `Tv`                  | `tinyint(1)`   | Whether the camera supports shutter-priority exposure                        |
| `P`                   | `tinyint(1)`   | Whether the camera supports program/auto exposure                            |
| `min_shutter`         | `varchar(6)`   | Fastest available shutter speed, expressed like 1/400                        |
| `max_shutter`         | `varchar(6)`   | Slowest available shutter speed, expressed like 30"                          |
| `bulb`                | `tinyint(1)`   | Whether the camera supports bulb (B) exposure                                |
| `time`                | `tinyint(1)`   | Whether the camera supports time (T) exposure                                |
| `min_iso`             | `int(11)`      | Minimum ISO the camera will accept for metering                              |
| `max_iso`             | `int(11)`      | Maximum ISO the camera will accept for metering                              |
| `af_points`           | `tinyint(4)`   | Number of autofocus points                                                   |
| `int_flash`           | `tinyint(1)`   | Whether the camera has an integrated flash                                   |
| `ext_flash`           | `tinyint(1)`   |  Whether the camera supports an external flash                               |
| `pc_sync`             | `tinyint(1)`   | Whether the camera has a PC sync socket for flash                            |
| `hotshoe`             | `tinyint(1)`   | Whether the camera has a hotshoe                                             |
| `coldshoe`            | `tinyint(1)`   | Whether the camera has a coldshoe or accessory shoe                          |
| `x_sync`              | `varchar(6)`   | X-sync shutter speed, expressed like 1/125                                   |
| `meter_min_ev`        | `tinyint(4)`   | Lowest EV/LV the built-in meter supports                                     |
| `meter_max_ev`        | `tinyint(4)`   | Highest EV/LV the built-in meter supports                                    |
| `condition_id`        | `int(11)`      | Denotes the cosmetic condition of the camera                                 |
| `oem_case`            | `tinyint(1)`   | Whether the camera has an original case included                             |

### `CONDITION`

List of types of cosmetic condition ranking.

| COLUMN_NAME    | COLUMN_TYPE    | COLUMN_COMMENT                                                |
|----------------|----------------|---------------------------------------------------------------|
| `condition_id` | `int(11)`      | Unique condition ID                                           |
| `code`         | `varchar(6)`   | Condition shortcode (e.g. EXC)                                |
| `name`         | `varchar(45)`  | Full name of condition (e.g. Excellent)                       |
| `min_rating`   | `int(11)`      | The lowest percentage rating that encompasses this condition  |
| `max_rating`   | `int(11)`      | The highest percentage rating that encompasses this condition |
| `description`  | `varchar(300)` | Longer description of condition                               |

### `DEVELOPER`

Inventory of types of photographic developer.

| COLUMN_NAME       | COLUMN_TYPE   | COLUMN_COMMENT                                                      |
|-------------------|---------------|---------------------------------------------------------------------|
| `developer_id`    | `int(11)`     | Unique developer ID                                                 |
| `manufacturer_id` | `int(11)`     | Denotes the manufacturer ID                                         |
| `name`            | `varchar(45)` | Name of the developer                                               |
| `for_paper`       | `tinyint(1)`  | Whether this developer can be used with paper                       |
| `for_film`        | `tinyint(1)`  | Whether this developer can be used with film                        |
| `chemistry`       | `varchar(45)` | The key chemistry on which this developer is based (e.g. phenidone) |

### `DEV_BATCH`

Inventory of batches of developer that have been prepared.

| COLUMN_NAME    | COLUMN_TYPE   | COLUMN_COMMENT                                                   |
|----------------|---------------|------------------------------------------------------------------|
| `dev_batch_id` | `int(11)`     | Unique developer batch ID                                        |
| `developer_id` | `int(11)`     | Denotes the developer used to make this batch                    |
| `dilution`     | `varchar(45)` | The dilution of the developer in this batch (e.g. 1|0, 1|1, etc) |
| `prepared`     | `date`        | Date that this batch was prepared                                |

### `ENLARGER`

Inventory of photographic enlargers.

| COLUMN_NAME        | COLUMN_TYPE    | COLUMN_COMMENT                                               |
|--------------------|----------------|--------------------------------------------------------------|
| `enlarger_id`      | `int(11)`      | Unique enlarger ID                                           |
| `manufacturer_id`  | `int(11)`      | Manufacturer ID of the enlarger                              |
| `enlarger`         | `varchar(45)`  | Name/model of the enlarger                                   |
| `negative_size_id` | `int(11)`      | ID of the largest negative size that the enlarger can handle |
| `acquired`         | `date`         | Date on which the enlarger was acquired                      |
| `lost`             | `date`         | Date on which the enlarger was lost/sold                     |
| `introduced`       | `year(4)`      | Year in which the enlarger was introduced                    |
| `discontinued`     | `year(4)`      | Year in which the enlarger was discontinued                  |
| `cost`             | `decimal(6,2)` | Purchase cost of the enlarger                                |
| `lost_price`       | `decimal(6,2)` | Sale price of the enlarger                                   |

### `FILM`

Inventory of rolls/sheets of film that have been exposed and developed.

| COLUMN_NAME         | COLUMN_TYPE    | COLUMN_COMMENT                                                        |
|---------------------|----------------|-----------------------------------------------------------------------|
| `film_id`           | `int(11)`      | Unique ID of the film                                                 |
| `filmstock_id`      | `int(11)`      | ID of the filmstock used                                              |
| `exposed_at`        | `int(11)`      | ISO at which the film was exposed                                     |
| `format_id`         | `int(11)`      | ID of the film format                                                 |
| `date_loaded`       | `date`         | Date when the film was loaded into a camera                           |
| `date`              | `date`         | Date when the film was processed                                      |
| `camera_id`         | `int(11)`      | ID of the camera that exposed this film                               |
| `notes`             | `varchar(145)` | Title of the film                                                     |
| `frames`            | `int(11)`      | Expected (not actual) number of frames from the film                  |
| `developer_id`      | `int(11)`      | ID of the developer used to process this film                         |
| `directory`         | `varchar(100)` | Name of the directory that contains the scanned images from this film |
| `photographer_id`   | `int(11)`      | ID of the photographer who took these pictures                        |
| `dev_uses`          | `int(11)`      | Numnber of previous uses of the developer                             |
| `dev_time`          | `time`         | Duration of development                                               |
| `dev_temp`          | `decimal(3,1)` | Temperature of development                                            |
| `dev_n`             | `int(11)`      | Number of the Push/Pull rating of the film, e.g. N|1, N-2             |
| `development_notes` | `varchar(200)` | Extra freeform notes about the development process                    |
| `film_batch`        | `varchar(45)`  | Batch number of the film                                              |
| `film_expiry`       | `date`         | Expiry date of the film                                               |

### `FILMSTOCK`

Inventory of types of film stock available.

| COLUMN_NAME       | COLUMN_TYPE   | COLUMN_COMMENT                         |
|-------------------|---------------|----------------------------------------|
| `filmstock_id`    | `int(11)`     | Unique ID of the filmstock             |
| `manufacturer_id` | `int(11)`     | ID of the manufacturer of the film     |
| `name`            | `varchar(45)` | Name of the film                       |
| `iso`             | `int(11)`     | Nominal ISO speed of the film          |
| `colour`          | `tinyint(1)`  | Whether the film is colour             |
| `process_id`      | `int(11)`     | ID of the normal process for this film |
| `panchromatic`    | `tinyint(1)`  | Whether this film is panchromatic      |

### `FILTER`

Inventory of photographic filters.

| COLUMN_NAME   | COLUMN_TYPE    | COLUMN_COMMENT                              |
|---------------|----------------|---------------------------------------------|
| `filter_id`   | `int(11)`      | Unique filter ID                            |
| `thread`      | `decimal(4,1)` | Diameter of screw thread in mm              |
| `type`        | `varchar(45)`  | Filter type (e.g. Red, CPL, UV)             |
| `attenuation` | `decimal(2,1)` | Attenuation of this filter in decimal stops |
| `qty`         | `int(11)`      | Quantity of these filters available         |

### `FILTER_ADAPTER`

Inventory of screw-thread filter adapters.

| COLUMN_NAME         | COLUMN_TYPE    | COLUMN_COMMENT                               |
|---------------------|----------------|----------------------------------------------|
| `filter_adapter_id` | `int(11)`      | Unique ID of filter adapter                  |
| `camera_thread`     | `decimal(3,1)` | Diameter of camera-facing screw thread in mm |
| `filter_thread`     | `decimal(3,1)` | Diameter of filter-facing screw thread in mm |

### `FLASH`

Inventory of external flash units.

| COLUMN_NAME         | COLUMN_TYPE    | COLUMN_COMMENT                                              |
|---------------------|----------------|-------------------------------------------------------------|
| `flash_id`          | `int(11)`      | Unique ID of external flash unit                            |
| `manufacturer_id`   | `int(11)`      | Manufacturer ID of the flash                                |
| `model`             | `varchar(45)`  | Model name/number of the flash                              |
| `guide_number`      | `int(11)`      | Guide number of the flash                                   |
| `gn_info`           | `varchar(45)`  | Extra freeform info about how the guide number was measured |
| `battery_powered`   | `tinyint(1)`   | Whether this flash takes batteries                          |
| `pc_sync`           | `tinyint(1)`   | Whether the flash has a PC sync socket                      |
| `hot_shoe`          | `tinyint(1)`   | Whether the flash has a hot shoe connection                 |
| `light_stand`       | `tinyint(1)`   | Whether the flash can be used on a light stand              |
| `battery_type`      | `varchar(45)`  | Type of battery needed in this flash                        |
| `battery_qty`       | `varchar(45)`  | Quantity of batteries needed in this flash                  |
| `manual_control`    | `tinyint(1)`   | Whether this flash offers manual power control              |
| `swivel_head`       | `tinyint(1)`   | Whether this flash has a horizontal swivel head             |
| `tilt_head`         | `tinyint(1)`   | Whether this flash has a vertical tilt head                 |
| `zoom`              | `tinyint(1)`   | Whether this flash can zoom                                 |
| `dslr_safe`         | `tinyint(1)`   | Whether this flash is safe to use with a digital camera     |
| `ttl`               | `tinyint(1)`   | Whether this flash supports TTL metering                    |
| `ttl_compatibility` | `varchar(45)`  | Compatibility of this flash's TTL system                    |
| `trigger_voltage`   | `decimal(4,1)` | Trigger voltage of the flash, in Volts                      |
| `own`               | `tinyint(1)`   | Whether we currently own this flash                         |

### `FOCUS_TYPE`

List of types of focus system (e.g. SLR, rangefinder, etc)

| COLUMN_NAME     | COLUMN_TYPE   | COLUMN_COMMENT          |
|-----------------|---------------|-------------------------|
| `focus_type_id` | `int(11)`     | Unique ID of focus type |
| `focus_type`    | `varchar(45)` | Name of focus type      |

### `FORMAT`

List of film formats.

| COLUMN_NAME | COLUMN_TYPE   | COLUMN_COMMENT                      |
|-------------|---------------|-------------------------------------|
| `format_id` | `int(11)`     | Unique ID for this format           |
| `format`    | `varchar(45)` | The name of this film/sensor format |
| `digital`   | `tinyint(1)`  | Whether this is a digital format    |

### `LENS`

Inventory of lenses, including interchangeable camera lenses, fixed lenses in compact
cameras and enlarger lenses.

| COLUMN_NAME              | COLUMN_TYPE    | COLUMN_COMMENT                                                                                                                               |
|--------------------------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| `lens_id`                | `int(11)`      | Unique ID for this lens                                                                                                                      |
| `mount_id`               | `int(11)`      | Denotes the ID of the lens mount, if this is an interchangeable lens                                                                         |
| `zoom`                   | `tinyint(1)`   | Whether this is a zoom lens                                                                                                                  |
| `min_focal_length`       | `int(11)`      | Shortest focal length of this lens, in mm                                                                                                    |
| `max_focal_length`       | `int(11)`      | Longest focal length of this lens, in mm                                                                                                     |
| `manufacturer_id`        | `int(11)`      | ID of the manufacturer of this lens                                                                                                          |
| `model`                  | `varchar(45)`  | Model name of this lens                                                                                                                      |
| `closest_focus`          | `int(11)`      | The closest focus possible with this lens, in cm                                                                                             |
| `max_aperture`           | `decimal(4,1)` | Maximum (widest) aperture available on this lens (numerical part only, e.g. 2.8)                                                             |
| `min_aperture`           | `decimal(4,1)` | Minimum (narrowest) aperture available on this lens (numerical part only, e.g. 22)                                                           |
| `elements`               | `int(11)`      | Number of optical lens elements                                                                                                              |
| `groups`                 | `int(11)`      | Number of optical groups                                                                                                                     |
| `weight`                 | `int(11)`      | Weight of this lens, in grammes (g)                                                                                                          |
| `nominal_min_angle_diag` | `int(11)`      | Nominal minimum diagonal field of view from manufacturer's specs                                                                             |
| `nominal_max_angle_diag` | `int(11)`      | Nominal maximum diagonal field of view from manufacturer's specs                                                                             |
| `calc_min_angle_diag`    | `smallint(6)`  | Minimum diagonal field of view, calculated from focal length and film format                                                                 |
| `calc_max_angle_diag`    | `smallint(6)`  | Maximum diagonal field of view, calculated from focal length and film format                                                                 |
| `calc_min_angle_horiz`   | `smallint(6)`  | Minimum horizontal field of view, calculated from focal length and film format                                                               |
| `calc_min_angle_vert`    | `smallint(6)`  | Minimum vertical field of view, calculated from focal length and film format                                                                 |
| `calc_max_angle_horiz`   | `smallint(6)`  | Maximum horizontal field of view, calculated from focal length and film format                                                               |
| `calc_max_angle_vert`    | `smallint(6)`  | Maximum vertical field of view, calculated from focal length and film format                                                                 |
| `aperture_blades`        | `int(11)`      | Number of aperture blades                                                                                                                    |
| `autofocus`              | `tinyint(1)`   | Whether this lens has autofocus capability                                                                                                   |
| `filter_thread`          | `decimal(4,1)` | Diameter of lens filter thread, in mm                                                                                                        |
| `magnification`          | `decimal(5,3)` | Maximum magnification ratio of the lens, expressed like 0.765                                                                                |
| `url`                    | `varchar(145)` | URL to more information about this lens                                                                                                      |
| `serial`                 | `varchar(45)`  | Serial number of this lens                                                                                                                   |
| `date_code`              | `varchar(45)`  | Date code of this lens, if different from the serial number                                                                                  |
| `introduced`             | `year(4)`      | Year in which this lens model was introduced                                                                                                 |
| `discontinued`           | `year(4)`      | Year in which this lens model was discontinued                                                                                               |
| `manufactured`           | `year(4)`      | Year in which this specific lens was manufactured                                                                                            |
| `negative_size_id`       | `int(11)`      | ID of the negative size which this lens is designed for                                                                                      |
| `acquired`               | `date`         | Date on which this lens was acquired                                                                                                         |
| `cost`                   | `decimal(6,2)` | Price paid for this lens in local currency units                                                                                             |
| `fixed_mount`            | `tinyint(1)`   | Whether this is a fixed lens (i.e. on a compact camera)                                                                                      |
| `notes`                  | `text`         | Freeform notes field                                                                                                                         |
| `own`                    | `tinyint(1)`   | Whether we currently own this lens                                                                                                           |
| `lost`                   | `date`         | Date on which lens was lost/sold/disposed                                                                                                    |
| `lost_price`             | `decimal(6,2)` | Price for which the lens was sold                                                                                                            |
| `source`                 | `varchar(150)` | Place where the lens was acquired from                                                                                                       |
| `coating`                | `varchar(45)`  | Notes about the lens coating type                                                                                                            |
| `hood`                   | `varchar(45)`  | Model number of the compatible lens hood                                                                                                     |
| `exif_lenstype`          | `varchar(45)`  | EXIF LensID integer, if this lens has one officially registered. See documentation at http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/ |
| `rectilinear`            | `tinyint(1)`   | Whether this is a rectilinear lens                                                                                                           |
| `length`                 | `int(11)`      | Length of lens in mm                                                                                                                         |
| `diameter`               | `int(11)`      | Width of lens in mm                                                                                                                          |
| `condition_id`           | `int(11)`      | Denotes the cosmetic condition of the camera                                                                                                 |
| `image_circle`           | `int(11)`      | Diameter of image circle projected by lens, in mm                                                                                            |
| `formula`                | `varchar(45)`  | Neme of the type of lens formula (e.g. Tessar)                                                                                               |

### `LENS_TYPE`

Categories of lenses based on field of view.

| COLUMN_NAME          | COLUMN_TYPE   | COLUMN_COMMENT                                               |
|----------------------|---------------|--------------------------------------------------------------|
| `lens_type_id`       | `int(11)`     | Unique ID for the type of lens                               |
| `diagonal_angle_min` | `int(11)`     | Minimum diagonal angle of view to quality for this lens type |
| `diagonal_angle_max` | `int(11)`     | Maximum diagonal angle of view to quality for this lens type |
| `lens_type`          | `varchar(45)` | Name of the lens type (e.g. Wide Angle, Telephoto, etc)      |

### `LIGHT_METER`

Inventory of light meters.

| COLUMN_NAME       | COLUMN_TYPE   | COLUMN_COMMENT                                                     |
|-------------------|---------------|--------------------------------------------------------------------|
| `light_meter_id`  | `int(11)`     | Unique ID for this light meter                                     |
| `manufacturer_id` | `int(11)`     | Denotes ID of manufacturer of the light meter                      |
| `model`           | `varchar(45)` | Model name or number of the light meter                            |
| `metering_type`   | `int(11)`     | ID of metering technology used in this light meter                 |
| `reflected`       | `tinyint(1)`  | Whether the meter is capable of reflected-light metering           |
| `incident`        | `tinyint(1)`  | Whether the meter is capable of incident-light metering            |
| `flash`           | `tinyint(1)`  | Whether the meter is capable of flash metering                     |
| `spot`            | `tinyint(1)`  | Whether the meter is capable of spot metering                      |
| `min_asa`         | `int(11)`     | Minimum ISO/ASA that this meter is capable of handling             |
| `max_asa`         | `int(11)`     | Maximum ISO/ASA that this meter is capable of handling             |
| `min_lv`          | `int(11)`     | Minimum light value (LV/EV) that this meter is capable of handling |
| `max_lv`          | `int(11)`     | Maximum light value (LV/EV) that this meter is capable of handling |

### `LOCATION`

List of locations (places) where photographs have been taken.

| COLUMN_NAME   | COLUMN_TYPE    | COLUMN_COMMENT            |
|---------------|----------------|---------------------------|
| `loc_id`      | `int(11)`      | Unique ID of a location   |
| `description` | `varchar(45)`  | Name of the location      |
| `latitude`    | `decimal(9,6)` | Latitude of the location  |
| `longitude`   | `decimal(9,6)` | Longitude of the location |

### `MANUFACTURER`

List of manufacturers of photographic equipment.

| COLUMN_NAME       | COLUMN_TYPE   | COLUMN_COMMENT                               |
|-------------------|---------------|----------------------------------------------|
| `manufacturer_id` | `int(11)`     | Unique ID of the manufacturer                |
| `manufacturer`    | `varchar(45)` | Name of the manufacturer                     |
| `city`            | `varchar(45)` | City in which the manufacturer is based      |
| `country`         | `varchar(45)` | Country in which the manufacturer is based   |
| `url`             | `varchar(45)` | URL to the manufacturer's main website       |
| `founded`         | `smallint(6)` | Year in which the manufacturer was founded   |
| `dissolved`       | `smallint(6)` | Year in which the manufacturer was dissolved |

### `METERING_PATTERN`

List of metering modes (e.g. spot, centre, average).

| COLUMN_NAME           | COLUMN_TYPE   | COLUMN_COMMENT                                           |
|-----------------------|---------------|----------------------------------------------------------|
| `metering_pattern_id` | `int(11)`     | Unique ID of the metering pattern                        |
| `metering_pattern`    | `varchar(45)` | Name of the metering mode/pattern (e.g. Centre-weighted) |

### `METERING_TYPE`

List of technologies that can be used in light metering (e.g. selenium, CdS, etc)

| COLUMN_NAME        | COLUMN_TYPE   | COLUMN_COMMENT                            |
|--------------------|---------------|-------------------------------------------|
| `metering_type_id` | `int(11)`     | Unique ID of the metering type            |
| `metering`         | `varchar(45)` | Name of the metering type (e.g. Selenium) |

### `MOTION_PICTURE_FILM`

Inventory of motion picture (movie) films that have been exposed and developed.

| COLUMN_NAME      | COLUMN_TYPE   | COLUMN_COMMENT                                     |
|------------------|---------------|----------------------------------------------------|
| `mp_film_id`     | `int(11)`     | Unique ID for this motion picture film / movie     |
| `title`          | `varchar(45)` | Title of this movie                                |
| `camera_id`      | `int(11)`     | ID of the camera used to shoot this movie          |
| `lens_id`        | `int(11)`     | ID of the lens used to shoot this movie            |
| `format_id`      | `int(11)`     | ID of the film format on which this movie was shot |
| `sound`          | `tinyint(1)`  | Whether this movie has sound                       |
| `fps`            | `int(11)`     | Frame rate of thsi movie, in fps                   |
| `filmstock_id`   | `int(11)`     | ID of the filmstock used to shoot this movie       |
| `feet`           | `int(11)`     | Length of this movie in feet                       |
| `date_loaded`    | `date`        | Date on which this movie was loaded                |
| `date_shot`      | `date`        | Date on which this movie was shot                  |
| `date_processed` | `date`        | Date on which this movie was processed             |
| `process_id`     | `int(11)`     | ID of the process used to develop this film        |
| `description`    | `varchar(45)` | Freeform text description of this movie            |

### `MOUNT`

Inventory of lens mount systems (e.g. Canon FD, Nikon F, etc)

| COLUMN_NAME       | COLUMN_TYPE   | COLUMN_COMMENT                                                             |
|-------------------|---------------|----------------------------------------------------------------------------|
| `mount_id`        | `int(11)`     | Unique ID of this lens mount                                               |
| `mount`           | `varchar(45)` | Name of this lens mount (e.g. Canon FD)                                    |
| `fixed`           | `tinyint(1)`  | Whether this is a fixed (non-interchangable) lens mount                    |
| `shutter_in_lens` | `tinyint(1)`  | Whether this lens mount system incorporates the shutter into the lens      |
| `type`            | `varchar(25)` | The physical mount type of this lens mount (e.g. Screw, Bayonet, etc)      |
| `purpose`         | `varchar(25)` | The intended purpose of this lens mount (e.g. camera, enlarger, projector) |
| `notes`           | `varchar(45)` | Freeform notes field                                                       |
| `digital_only`    | `tinyint(1)`  | Whether this mount is intended only for digital cameras                    |

### `MOUNT_ADAPTER`

Inventory of lens mount adapters which can be used to mount lenses on other camera systems.

| COLUMN_NAME        | COLUMN_TYPE  | COLUMN_COMMENT                                          |
|--------------------|--------------|---------------------------------------------------------|
| `mount_adapter_id` | `int(11)`    | Unique ID of lens mount adapter                         |
| `lens_mount`       | `int(11)`    | ID of the mount used between the adapter and the lens   |
| `camera_mount`     | `int(11)`    | ID of the mount used between the adapter and the camera |
| `has_optics`       | `tinyint(1)` | Whether this adapter includes optical elements          |
| `infinity_focus`   | `tinyint(1)` | Whether this adapter allows infinity focus              |
| `notes`            | `varchar(45) | Freeform notes field                                    |

### `NEGATIVE`

Inventory of negatives (and slides) that have been exposed and developed.

| COLUMN_NAME        | COLUMN_TYPE    | COLUMN_COMMENT                                                |
|--------------------|----------------|---------------------------------------------------------------|
| `negative_id`      | `int(11)`      | Unique ID of this negative                                    |
| `film_id`          | `int(11)`      | ID of the film that this negative belongs to                  |
| `frame`            | `varchar(5)`   | Frame number or code of this negative                         |
| `description`      | `varchar(145)` | Caption of this picture                                       |
| `date`             | `date`         | Date on which this picture was taken                          |
| `lens_id`          | `int(11)`      | ID of lens used to take this picture                          |
| `shutter_speed`    | `varchar(45)`  | Shutter speed used to take this picture                       |
| `aperture`         | `decimal(4,1)` | Aperture used to take this picture (numerical part only)      |
| `filter_id`        | `int(11)`      | ID of filter used to take this picture                        |
| `teleconverter_id` | `int(11)`      | ID of teleconverter used to take this picture                 |
| `notes`            | `text`         | Extra freeform notes about this exposure                      |
| `mount_adapter_id` | `int(11)`      | ID of lens mount adapter used to take this pciture            |
| `focal_length`     | `int(11)`      | If a zoom lens was used, specify the focal length of the lens |
| `latitude`         | `decimal(9,6)` | Latitude of the location where the picture was taken          |
| `longitude`        | `decimal(9,6)` | Longitude of the location where the picture was taken         |
| `filename`         | `varchar(100)` | Filename of the scanned image file from this negative         |

### `NEGATIVE_SIZE`

List of negative sizes that can be made.

| COLUMN_NAME        | COLUMN_TYPE    | COLUMN_COMMENT                                                                                    |
|--------------------|----------------|---------------------------------------------------------------------------------------------------|
| `negative_size_id` | `int(11)`      | Unique ID of negative size                                                                        |
| `width`            | `decimal(4,1)` | Width of the negative size in mm                                                                  |
| `height`           | `decimal(4,1)` | Height of the negative size in mm                                                                 |
| `negative_size`    | `varchar(45)`  | Common name of the negative size (e.g. 35mm, 6x7, etc)                                            |
| `crop_factor`      | `decimal(4,2)` | Crop factor of this negative size                                                                 |
| `area`             | `int(11)`      | Area of this negative size in sq. mm                                                              |
| `aspect_ratio`     | `decimal(4,2)` | Aspect ratio of this negative size, expressed as a single decimal. (e.g. 3:2 is expressed as 1.5) |

### `PAPER_STOCK`

Inventory of photographic paper stock

| COLUMN_NAME       | COLUMN_TYPE   | COLUMN_COMMENT                             |
|-------------------|---------------|--------------------------------------------|
| `paper_stock_id`  | `int(11)`     | Unique ID of this paper stock              |
| `name`            | `varchar(45)` | Name of this paper stock                   |
| `manufacturer_id` | `int(11)`     | ID of the manufacturer of this paper stock |
| `resin_coated`    | `tinyint(1)`  | Whether the paper is resin-coated          |
| `tonable`         | `tinyint(1)`  | Whether this paper accepts chemical toning |
| `colour`          | `tinyint(1)`  | Whether this is a colour paper             |

### `PHOTOGRAPHER`

List of people who have taken photographs that are catalogued in this database.

| COLUMN_NAME       | COLUMN_TYPE   | COLUMN_COMMENT                 |
|-------------------|---------------|--------------------------------|
| `photographer_id` | `int(11)`     | Unique ID for the photographer |
| `name`            | `varchar(45)` | Name of the photographer       |

### `PRINT`

Inventory of photographic prints made from negatives that are catalogued in the `NEGATIVE` table.

| COLUMN_NAME        | COLUMN_TYPE    | COLUMN_COMMENT                                                          |
|--------------------|----------------|-------------------------------------------------------------------------|
| `print_id`         | `int(11)`      | Unique ID for the print                                                 |
| `negative_id`      | `int(11)`      | ID of the negative that this print was made from                        |
| `date`             | `date`         | The date that the print was made                                        |
| `paper_stock_id`   | `int(11)`      | ID of the paper stock used                                              |
| `height`           | `decimal(4,1)` | Height of the print in inches                                           |
| `width`            | `decimal(4,1)` | Width of the print in inches                                            |
| `toner_id`         | `int(11)`      | ID of the toner used to make this print                                 |
| `toner_dilution`   | `varchar(6)`   | Dilution of the toner used to make this print                           |
| `toner_time`       | `time`         | Duration of toning                                                      |
| `own`              | `tinyint(1)`   | Whether we currently own this print                                     |
| `location`         | `varchar(45)`  | The place where this print is currently                                 |
| `enlarger_id`      | `int(11)`      | ID of the enlarger used to make this print                              |
| `lens_id`          | `int(11)`      | ID of the lens used to make this print                                  |
| `developer_id`     | `int(11)`      | ID of the developer used to develop this print                          |
| `aperture`         | `decimal(3,1)` | Aperture used to make this print (numerical part only, e.g. 5.6)        |
| `exposure_time`    | `decimal(4,1)` | Exposure time of this print in seconds                                  |
| `development_time` | `int(11)`      | Development time of this print in seconds                               |
| `filtration_grade` | `decimal(2,1)` | Contrast grade of paper used                                            |
| `fine`             | `tinyint(1)`   | Whether this is a fine print                                            |
| `notes`            | `text`         | Freeform notes about this print, e.g. dodging, burning & complex toning |
| `filename`         | `varchar(100)` | The filename of the image scanned from this print                       |

### `PROCESS`

List of chemical photographic processes (e.g. C-41, E-6, etc)

| COLUMN_NAME  | COLUMN_TYPE   | COLUMN_COMMENT                                     |
|--------------|---------------|----------------------------------------------------|
| `process_id` | `int(11)`     | ID of this development process                     |
| `name`       | `varchar(12)` | Name of this developmenmt process (e.g. C-41, E-6) |
| `colour`     | `tinyint(1)`  | Whether this is a colour process                   |
| `positive`   | `tinyint(1)`  | Whether this is a positive/reversal process        |

### `PROJECTOR`

Inventory of projectors for slides and motion picture films.

| COLUMN_NAME        | COLUMN_TYPE   | COLUMN_COMMENT                                                           |
|--------------------|---------------|--------------------------------------------------------------------------|
| `projector_id`     | `int(11)`     | Unique ID of this projector                                              |
| `manufacturer_id`  | `int(11)`     | ID of the manufacturer of this projector                                 |
| `model`            | `varchar(45)` | Model name of this projector                                             |
| `mount_id`         | `int(11)`     | ID of the lens mount of this projector, if it has interchangeable lenses |
| `negative_size_id` | `int(11)`     | ID of the largest negative size that this projector can handle           |
| `own`              | `tinyint(1)`  | Whether we currently own this projector                                  |
| `cine`             | `tinyint(1)`  | Whether this is a cine (movie) projector                                 |

### `REPAIR`

Log of repairs performed on cameras and lenses in this database.

| COLUMN_NAME   | COLUMN_TYPE    | COLUMN_COMMENT                                            |
|---------------|----------------|-----------------------------------------------------------|
| `repair_id`   | `int(11)`      | Unique ID for the repair job                              |
| `oid`         | `int(11)`      | ID of the camera or lens that was repaired                |
| `object_type` | `varchar(45)`  | Type of object that was repaired (e.g. Camera, Lens, etc) |
| `date`        | `date`         | The date of the repair                                    |
| `summary`     | `varchar(100)` | Brief summary of the repair                               |
| `description` | `varchar(500)` | Longer description of the repair                          |

### `SHUTTER_TYPE`

List of shutter types (e.g. leaf, focal plane, etc)

| COLUMN_NAME       | COLUMN_TYPE   | COLUMN_COMMENT                                         |
|-------------------|---------------|--------------------------------------------------------|
| `shutter_type_id` | `int(11)`     | Unique ID of the shutter type                          |
| `shutter_type`    | `varchar(45)` | Name of the shutter type (e.g. Focal plane, Leaf, etc) |

### `TELECONVERTER`

Inventory of teleconverters.

| COLUMN_NAME        | COLUMN_TYPE    | COLUMN_COMMENT                                                             |
|--------------------|----------------|----------------------------------------------------------------------------|
| `teleconverter_id` | `int(11)`      | Unique ID of this teleconverter                                            |
| `mount_id`         | `int(11)`      | ID of the lens mount used by this teleconverter                            |
| `factor`           | `decimal(4,2)` | Magnification factor of this teleconverter (numerical part only, e.g. 1.4) |
| `manufacturer_id`  | `int(11)`      | ID of the manufacturer of this teleconverter                               |
| `model`            | `varchar(45)`  | Model name of this teleconverter                                           |
| `elements`         | `tinyint(4)`   | Number of optical elements used in this teleconverter                      |
| `groups`           | `tinyint(4)`   | Number of optical groups used in this teleconverter                        |
| `multicoated`      | `tinyint(1)`   | Whether this teleconverter is multi-coated                                 |

### `TONER`

Inventory of chemical toners for use when printing.

| COLUMN_NAME       | COLUMN_TYPE   | COLUMN_COMMENT                      |
|-------------------|---------------|-------------------------------------|
| `toner_id`        | `int(11)`     | Unique ID of the toner              |
| `manufacturer_id` | `int(11)`     | ID of the manufacturer of the toner |
| `toner`           | `varchar(45)` | Name of the toner                   |
| `formulation`     | `varchar(45)` | Chemical formulation of the toner   |
