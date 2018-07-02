PhotoDB
=======

PhotoDB is an attempt to create a database for film photography that can be used to track
cameras, lenses, films and negatives to fully catalogue a collection of cameras, lenses,
accessories as well as negatives and prints that are made with them.

At the moment, the PhotoDB project is unfinished and the code continues to change unpredictably.
Look for a tagged release in the future!

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
    * [Upgrading](#upgrading)
2. [Usage](#usage)

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

### Configure database connection

The app and accessory scripts need to know how to connect to the database. Copy the sample config file,
`photodb.ini` to `/etc/photodb.ini` and edit it to include the connection details for your database.

### Upgrading

Upgrading to a new version of the schema is tricky. You can of course do a `git pull` to get the
latest schema files and then execute `mysql -p photography < *.sql` again, but this will discard
all of your data. The only real upgrade path at the moment is to back up your data, drop and create
the new schema, and re-import your data, taking account of schema changes. I hope to provide a more
robust upgrade path after the first tagged release of this project.

## Usage

This section of the documentation focuses on using the command-line application to drive the database.
Every command invokes the application by name and provides a command a subcommand, e.g.

```
photodb camera add
```

After providing a command and subcommand, the application then asks relevant questions interactively.

### Command reference

### `film`
#### `add`
#### `load`
#### `develop`

### `camera`
#### `add`
#### `display-lens`
#### `show-lenses`

### `negative`
#### `add`
#### `bulk-add`

### `lens`
#### `add`

### `print`
#### `add`
#### `tone`
#### `sell`

### `paperstock`
#### `add`

### `developer`
#### `add`

### `task`
#### `run`

### `help`
