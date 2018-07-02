## Table of Contents

1. [Requirements](#requirements)
2. [Install database backend](#install-database-backend)
    * [Install MySQL](#install-mysql)
    * [Create a user](#create-a-user)
    * [Import the schema](#import-the-schema)
    * [Import sample data](#import-sample-data)
    * [Upgrading](#upgrading)
3. [Install application frontend](#install-application-frontend)

## Requirements

### Database backend

The database backend can be run anywhere that supports MySQL or MariaDB.

### Application frontend

The application frontend requires Linux. It has been developed on Fedora, should support Ubuntu but is very hard to get to
work on CentOS, due to the difficulty of building CPAN modules.

## Install database backend

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
sudo dnf install mariadb-server
sudo systemctl mariadb on
sudo systemctl mariadb start
```

Ubuntu:
```
sudo apt-get install mysql-server
sudo systemctl start mysql
sudo systemctl enable mysql
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

### Upgrading

Upgrading to a new version of the schema is tricky. You can of course do a `git pull` to get the
latest schema files and then execute `mysql -p photography < *.sql` again, but **this will discard
all of your data**. The only real upgrade path at the moment is to back up your data, drop and create
the new schema, and re-import your data, taking account of schema changes. I hope to provide a more
robust upgrade path after the first tagged release of this project.

## Install application frontend

### Install dependencies

The application is written in Perl so we need to install some Perl modules.

Fedora:
```
# Set up a new yum repo to provide one package
curl -s https://packagecloud.io/install/repositories/jgazeley/perl-modules/script.rpm.sh | sudo bash
# Install all of the deps in one go
sudo dnf install "perl(Config::IniHash)" "perl(Data::Dumper)" "perl(DBD::mysql)" "perl(DBI)" \
"perl(Exporter)" "perl(Getopt::Long)" "perl(Image::ExifTool)" "perl(Image::ExifTool::Location)" \
"perl(SQL::Abstract)" "perl(strict)" "perl(Switch)" "perl(Term::ReadKey)" "perl(warnings)"
```

### Check out the code

Check out the application code directly from git

```
git clone https://github.com/djjudas21/photography-database.git
```

You can run the application directly from its current location but it is recommended to symlink it
into your path, for ease of use.

```
ln -s /home/you/photography-database/photodb /usr/local/bin/photodb
```

### Configure database connection

The app and accessory scripts need to know how to connect to the database. Copy the sample config file,
`photodb.ini` to `/etc/photodb.ini` and edit it to include the connection details for your database.
You should have written these details down when you set up the database.

### Test the connection

Test the database connection by running the application with no arguments. If you see a help message,
then everything is working. If you see an error message the database, the config file or any Perl
module then something has gone wrong.
