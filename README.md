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

See also separate docs for [installation](docs/INSTALL.md) and [contributing](docs/CONTRIBUTING.md)

## Table of Contents

2. [Usage](#usage)

## Usage

This section of the documentation focuses on using the command-line application to drive the database.
Every command invokes the application by name and provides a command a subcommand, e.g.

```
photodb camera add
```

After providing a command and subcommand, the application then asks relevant questions interactively.

### Command reference

### `film`
The `film` command provides subcommands related to invidual rolls (or sets of sheets) of film.
#### `add`
`film add` adds a new film to the database, e.g. when it is purchased.
#### `load`
`film load` is used when a film is loaded into a camera.
#### `develop`
`film develop` is used when a film is developed/processed into negatives/slides.

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
