# Installing PhotoDB

## Table of Contents

2. [Install database backend](#install-database-backend)
    * [Install MySQL](#install-mysql)
    * [Create a user](#create-a-user)
3. [Install application frontend](#install-application-frontend)
4. [Configure database connection](#configure-database-connection)

## Install database backend

### Install MySQL
A pre-requisite for PhotoDB is a functioning MySQL or MariaDB database instance. If you have access to an existing
MySQL server, e.g. at a hosting provider, note down the details for connecting (hostname or IP address, username, password).

Otherwise, consider installing a MySQL server locally on your computer. If you do this, the hostname will be `localhost`.

### Create a user
Create a database user with a password for PhotoDB

## Install application frontend

There are several different ways to install the application. Choose your favourite.
Install PhotoDB from CPAN or from a source tarball.

### From CPAN

1. Use the `cpan` client (or an alternative, such as `cpanm`) to install directly:
```
cpan App::PhotoDB
```
or
```
cpanm App::PhotoDB
```

### From source

1. Grab the latest release tarball from the [Releases page](https://github.com/djjudas21/photography-database/releases).
It's the one with a name like `App-PhotoDB-0.00.tar.gz`.

2. Install it with `cpanm`:
```
cpanm /path/tp/App-PhotoDB-0.00.tar.gz
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
