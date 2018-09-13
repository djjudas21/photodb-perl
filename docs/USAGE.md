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
### `film add`
Adds a new film to the database, e.g. when it is purchased.
### `film load`
Load a film into a camera
### `film develop`
Develop a film
### `film tag`
Write EXIF tags to scans from a film
### `film archive`
Put the film in a physical archive
### `film locate`
Locate where this film is
### `film bulk`
Add a new bulk film to the database
### `film annotate`
Create a text file in the film scan directory with summary info about the film & negatives

## `camera`
The `camera` command provides subcommands for working with cameras.
### `camera add`
Add a new camera to the database
### `camera display-lens`
Associate a camera with a lens for display purposes
### `camera show-lenses`
`camera show-lenses` shows all lenses which are compatible with a camera.
### `camera sell`
Sell a camera
### `camera repair`
Repair a camera
### `camera stats`
Show statistics about a camera
### `camera info`
Show information about a camera
### `camera exposureprogram`
Add available exposure program info to a camera
### `camera meteringmode`
Add available metering mode info to a camera
### `camera shutterspeeds`
Add available shutter speed info to a camera
### `camera accessory`
Add accessory compatibility info to a camera
### `camera choose`
Choose a camera based on multiple usage criteria

## `negative`
The `negative` command provides subcommands for working with negatives (or slides, etc) which are part of a film.
### `negative add`
Add a new negative to the database as part of a film
### `negative bulk-add`
`negative bulk-add` registers a number of negatives to an existing film, but doesn't collect any data.
It is useful only for blocking out e.g. 24 negatives for a 24-exp film. They will need to have data added later.
Bulk add multiple negatives to the database as part of a film
### `negative stats`
Show statistics about a negative
### `negative prints`
Find all prints made from a negative

## `movie`
The `movie` command provides subcommands for working with movies (cine films)
### `movie add`
Add a new movie to the database

## `mount`
The `mount` command provides subcommands for working with lens mounts (aka camera systems)
### `mount add`
Add a new lens mount to the database
### `mount view`
View compatible cameras and lenses for a mount

## `lens`
The `lens` command provides subcommands for working with lenses (for cameras, enlargers and projectors).
### `lens add`
Add a new lens to the database
### `lens sell`
Sell a lens
### `lens repair`
Repair a lens
### `lens stats`
Show statistics about a lens
### `lens accessory`
Add accessory compatibility info to a lens
### `lens info`
Show information about a lens

## `print`
The `print` command provides subcommands for working with prints which have been made from negatives.
### `print add`
Add a new print that has been made from a negative
### `print tone`
Add toning to a print
### `print sell`
Sell a print
### `print order`
Register an order for a print
### `print fulfil`
Fulfil an order for a print
### `print archive`
Add a print to a physical archive
### `print locate`
Locate a print in an archive
### `print reprint`
Show details for making another print the same
### `print exhibit`
Exhibit a print at an exhibition

## `material`
The `material` command provides subcommands for adding materials, i.e. film, paper and chemicals to the database.
### `material paperstock`
Add a new type of photo paper to the database
### `material developer`
Add a new developer to the database
### `material toner`
Add a new chemical toner to the database
### `material filmstock`
Add a new type of filmstock to the database

## `accessory`
The `accessory` command provides subcommands for adding photographic accessories to the database.
### `accessory add`
Add a new "other" accessory to the database
### `accessory type`
Add a new type of "other" accessory to the database
### `accessory flash`
Add a new flash to the database
### `accessory battery`
Add a new type of battery to the database
### `accessory meter`
Add a new light meter to the database
### `accessory teleconverter`
Add a new teleconverter to the database
### `accessory filter`
Add a new (optical) filter to the database
### `accessory filteradapter`
Add a filter adapter to the database
### `accessory mountadapter`
Add a new mount adapter to the database
### `accessory projector`
Add a new projector to the database

## `enlarger`
### `enlarger add`
Add a new enlarger to the database
### `enlarger sell`
Sell an enlarger

## `archive`
### `archive add`
Add a new physical archive for prints or films
### `archive list`
List the contents of an archive
### `archive move`
Move an archive to a new location
### `archive films`
Bulk-add multiple films to an archive
### `archive seal`
Seal an archive and prevent new items from being added to it
### `archive unseal`
Unseal an archive and allow new items to be added to it

## `person`
The `person` command provides a set of subcommands for managing data about people (e.g. photographers)
### `person add`
Add a new person to the database

## `data`
The `data` subcommand provides a set of subcommands for entering sundry data. You shouldn't really need these as data can be entered inline at the point of use.
### `data format`
Add a new film format to the database
### `data negsize`
Add a size of negative to the database
### `data process`
Add a new development process to the database
### `data manufacturer`
Add a new manufacturer to the database
### `data bodytype`
Add a new camera body type
### `data shuttertype`
Add a new type of shutter to the database
### `data shutterspeed`
Add a new shutter speed to the database
### `data focustype`
Add a new type of focus system to the database
### `data flashprotocol`
Add a new flash protocol to the database
### `data meteringtype`
Add a new type of metering system to the database

## `task`
The `task` command provides a set of useful tasks for automatically setting/fixing/cleaning data in the database.
### `task run`
Run a selection of maintenance tasks on the database

## `audit`
The `audit` command provides a set of subcommands for checking and entering incomplete data.
### `audit shutterspeeds`
Audit cameras without shutter speed data
### `audit exposureprograms`
Audit cameras without exposure program data
### `audit meteringmodes`
Audit cameras without metering mode data

## `exhibition`
The `exhibition` command provides a set of subcommands for managing exhibitions.
### `exhibition add`
Add a new exhibition to the database
### `exhibition review`
View the prints which were exhibited at an exhibition
