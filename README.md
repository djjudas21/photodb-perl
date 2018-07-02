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
The `film` command provides subcommands for working with individual rolls (or sets of sheets) of film.
#### `add`
`film add` adds a new film to the database, e.g. when it is purchased.
#### `load`
`film load` is used when a film is loaded into a camera.
#### `develop`
`film develop` is used when a film is developed/processed into negatives/slides.

### `camera`
The `camera` command provides subcommands for working with cameras.
#### `add`
`camera add` adds a new cameras to the database, e.g. when it is purchased.
#### `display-lens`
`camera display-lens` sets a "display lens" that the camera should be displayed with when on the shelf.
#### `show-lenses`
`camera show-lenses` shows all lenses which are compatible with a camera.

### `negative`
The `negative` command provides subcommands for working with negatives (or slides, etc) which are part of a film.
#### `add`
`negative add` registers a new negative to an existing film, and collects full data about the negative.
#### `bulk-add`
`negative bulk-add` registers a number of negatives to an existing film, but doesn't collect any data.
It is useful only for blocking out e.g. 24 negatives for a 24-exp film. They will need to have data added later.

### `lens`
The `lens` command provides subcommands for working with lenses (for cameras and enlargers).
#### `add`
`lens add` adds a new lens to the database.

### `print`
The `print` command provides subcommands for working with prints which have been made from negatives.
#### `add`
`print add` registers a new print which has been made from a negative (or slide).
#### `tone`
`print tone` adds information about toning to an existing print.
#### `sell`
`print sell` adds information when an existing print is sold or given away.

### `paperstock`
The `paperstock` command provides subcommands for working with paper stock (different types of darkroom paper).
#### `add`
`paperstock add` adds a new paper stock to the database, so it can be used to register prints.

### `developer`
The `developer` command provides subcommands for working with developer chemistry.
#### `add`
`developer add` adds a new developer to the database, so it can be used for developing film and prints.

### `task`
The `task` command provides a set of useful tasks for automatically setting/fixing/cleaning data in the database.
#### `run`

### `help`
