# Using PhotoDB

This section of the documentation focuses on using the command-line application to drive the database
after it has been installed. Every command invokes the application by name and provides a command
and subcommand, e.g.

```
photodb camera add
```

After providing a command and subcommand, the application then asks relevant questions interactively
with helpful guidance.

## Command reference

## `film`
The `film` command provides subcommands for working with individual rolls (or sets of sheets) of film.
### `add`
Adds a new film to the database, e.g. when it is purchased.
### `load`
Load a film into a camera
### `develop`
Develop a film
### `tag`
Write EXIF tags to scans from a film
### `archive`
Put the film in a physical archive
### `locate`
Locate where this film is
### `bulk`
Add a new bulk film to the database

## `camera`
The `camera` command provides subcommands for working with cameras.
### `add`
Add a new camera to the database
### `display-lens`
Associate a camera with a lens for display purposes
### `show-lenses`
`camera show-lenses` shows all lenses which are compatible with a camera.
### `sell`
Sell a camera
### `repair`
Repair a camera
### `stats`
Show statistics about a camera
### `info`
Show information about a camera
### `exposureprogram`
Add available exposure program info to a camera
### `meteringmode`
Add available metering mode info to a camera
### `shutterspeeds`
Add available shutter speed info to a camera
### `accessory`
Add accessory compatibility info to a camera

## `negative`
The `negative` command provides subcommands for working with negatives (or slides, etc) which are part of a film.
### `add`
Add a new negative to the database as part of a film
### `bulk-add`
`negative bulk-add` registers a number of negatives to an existing film, but doesn't collect any data.
It is useful only for blocking out e.g. 24 negatives for a 24-exp film. They will need to have data added later.
Bulk add multiple negatives to the database as part of a film
### `stats`
Show statistics about a negative
### `prints`
Find all prints made from a negative

## `movie`
The `movie` command provides subcommands for working with movies (cine films)
### `add`
Add a new movie to the database

## `mount`
The `mount` command provides subcommands for working with lens mounts (aka camera systems)
### `add`
Add a new lens mount to the database
### `view`
View compatible cameras and lenses for a mount

## `lens`
The `lens` command provides subcommands for working with lenses (for cameras, enlargers and projectors).
### `add`
Add a new lens to the database
### `sell`
Sell a lens
### `repair`
Repair a lens
### `stats`
Show statistics about a lens
### `accessory`
Add accessory compatibility info to a lens
### `info`
Show information about a lens

## `print`
The `print` command provides subcommands for working with prints which have been made from negatives.
### `add`
Add a new print that has been made from a negative
### `tone`
Add toning to a print
### `sell`
Sell a print
### `order`
Register an order for a print
### `fulfil`
Fulfil an order for a print
### `archive`
Add a print to a physical archive
### `locate`
Locate a print in an archive
### `reprint`
Show details for making another print the same

## `material`
The `material` command provides subcommands for adding materials, i.e. film, paper and chemicals to the database.
### `paperstock`
Add a new type of photo paper to the database
### `developer`
Add a new developer to the database
### `toner`
Add a new chemical toner to the database
### `filmstock`
Add a new type of filmstock to the database

## `accessory`
### `add`
Add a new "other" accessory to the database
### `type`
Add a new type of "other" accessory to the database
### `flash`
Add a new flash to the database
### `battery`
Add a new type of battery to the database
### `meter`
Add a new light meter to the database
### `teleconverter`
Add a new teleconverter to the database
### `filter`
Add a new (optical) filter to the database
### `filteradapter`
Add a filter adapter to the database
### `mountadapter`
Add a new mount adapter to the database
### `projector`
Add a new projector to the database

## `enlarger`
### `add`
Add a new enlarger to the database
### `sell`
Sell an enlarger

## `archive`
### `add`
Add a new physical archive for prints or films
### `list`
List the contents of an archive
### `move`
Move an archive to a new location
### `films`
Bulk-add multiple films to an archive
### `seal`
Seal an archive and prevent new items from being added to it
### `unseal`
Unseal an archive and allow new items to be added to it

## `person`
The `person` command provides a set of subcommands for managing data about people (e.g. photographers)
### `add`
Add a new person to the database

## `data`
The `data` subcommand provides a set of subcommands for entering sundry data. You shouldn't really need these as data can be entered inline at the point of use.
### `format`
Add a new film format to the database
### `negsize`
Add a size of negative to the database
### `process`
Add a new development process to the database
### `manufacturer`
Add a new manufacturer to the database
### `bodytype`
Add a new camera body type
### `shuttertype`
Add a new type of shutter to the database
### `shutterspeed`
Add a new shutter speed to the database
### `focustype`
Add a new type of focus system to the database
### `flashprotocol`
Add a new flash protocol to the database
### `meteringtype`
Add a new type of metering system to the database

## `task`
The `task` command provides a set of useful tasks for automatically setting/fixing/cleaning data in the database.
### `run`
Run a selection of maintenance tasks on the database

## `audit`
The `audit` command provides a set of subcommands for checking and entering incomplete data.
### `shutterspeeds`
Audit cameras without shutter speed data
### `exposureprograms`
Audit cameras without exposure program data
### `meteringmodes`
Audit cameras without metering mode data
