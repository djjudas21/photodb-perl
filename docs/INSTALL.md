# Installing PhotoDB

## Table of Contents

1. [Requirements](#requirements)
2. [Install database backend](#install-database-backend)
    * [Install MySQL](#install-mysql)
    * [Create a user](#create-a-user)
    * [Import the schema](#import-the-schema)
    * [Import sample data](#import-sample-data)
    * [Upgrading](#upgrading)
3. [Install application frontend](#install-application-frontend)
4. [Configure database connection](#configure-database-connection)
    * [Fedora](#fedora)
    * [Ubuntu or Debian](#ubuntu-or-debian)
    * [Other Linux](#other-linux)
    * [Docker](#docker)

## Requirements

### Database backend

The database backend can be run anywhere that supports MySQL or MariaDB. It does not have to be
on the same system as the frontend.

### Application frontend

The application frontend requires Linux. It has been developed and tested on Fedora, but it should
support Ubuntu. It is very hard to get to work on CentOS, due to the difficulty of building CPAN modules.

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
sudo systemctl start mariadb
sudo systemctl enable mariadb
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

There are several different ways to install the application. Choose your favourite.

### Fedora

Run on Fedora or compatible RPM-based Linux, and install dependencies with dnf/yum. Unfortunately,
CentOS does not package all the perl modules required.

1. Install all of the deps in one go
```
sudo dnf install "perl(Config::IniHash)" "perl(YAML)" "perl(DBD::mysql)" "perl(DBI)" \
"perl(Exporter)" "perl(Getopt::Long)" "perl(Image::ExifTool)" "perl(SQL::Abstract)" \
"perl(strict)" "perl(Term::ReadKey)" "perl(warnings)" \
"perl(Perl::Critic)" "perl(experimental)" "perl(Path::Iterator::Rule)" "perl(Array::Utils)"
```

2. Check out the PhotoDB application code directly from git

```
git clone https://github.com/djjudas21/photography-database.git
```

3. You can run the application directly from its current location but it is recommended to symlink it
into your path, for ease of use.
```
ln -s /home/you/photography-database/photodb /usr/local/bin/photodb
```

### Ubuntu or Debian

Run on Ubuntu or Debian compatible DEB-based Linux, and install dependencies with apt

1. Install all of the deps in one go
```
sudo apt-get install libconfig-inihash-perl libdbd-mysql-perl libdbi-perl \
libgetopt-long-descriptive-perl libimage-exiftool-perl libsql-abstract-perl \
libterm-readkey-perl libimage-exiftool-location-perl libperl-critic-perl \
libpath-iterator-rule-perl libarray-utils-perl libyaml-libyaml-perl \
libfindbin-libs-perl
```

2. Check out the PhotoDB application code directly from git

```
git clone https://github.com/djjudas21/photography-database.git
```

3. You can run the application directly from its current location but it is recommended to symlink it
into your path, for ease of use.
```
ln -s /home/you/photography-database/photodb /usr/local/bin/photodb
```

### Other Linux

Run on any Linux distribution and install dependencies with cpanm

1. Install cpanm with your package manager or directly from the repo

2. Check out the PhotoDB application code directly from git

```
git clone https://github.com/djjudas21/photography-database.git
```

3. Install dependencies
```
cd photography-database
cpanm install .
```

4. You can run the application directly from its current location but it is recommended to symlink it
into your path, for ease of use.

```
ln -s /home/you/photography-database/photodb /usr/local/bin/photodb
```

### Docker

Run PhotoDB on any platform, with Docker

1. Fetch the Docker image
```
docker pull djjudas21/photodb
```
2. Run the image
```
docker run -it --rm -v ~/.photodb:/root/.photodb --name photodb photodb
```

### Set up autocomplete

PhotoDB ships with Bash completion. Enable it by

```
echo "source photodb-completion.bash" >> ~/.bash_profile
```

## Configure database connection

There are three methods for connecting to the database:
1. Database and application on same computer
2. Database and application on different computers, connect via native MySQL
3. Database and application on different computers, connect via SSH tunnel

The app and accessory scripts need to know how to connect to the database. The first time you run
PhotoDB, you will be prompted to enter connection details for the database backend. If you need to
edit the config in future, the config file is created at `/etc/photodb.ini`.

### Tunnelling

If the database is on a remote server and does not have the MySQL port (3306) open to receive connections,
you will need to set up a tunnel. Run the command below, substituting in the correct hostname and
username for the database server.

```
ssh -L 3306:localhost:3306 -N <username>@<database.example.com>
```

Once the tunnel is established, you should be able to connect to the database on `127.0.0.1:3306` and
your connection will be tunnelled. Configure PhotoDB in the same way as if the database was local.
You will need to re-establish the tunnel each time you wish to use PhotoDB.

### Test the connection

Test the database connection by running the application with no arguments. If you see a help message,
then everything is working. If you see an error message the database, the config file or any Perl
module then something has gone wrong.
