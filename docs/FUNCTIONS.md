# Function reference

Note that some of these functions take traditional argument lists which must
be in order, while the more complex functions take a hashref of arguments
which can be passed in any order. Examples of each function are given


## `annotatefilm`
Write out a text file in the film scans directory
#### Usage
```perl
&annotatefilm($db, $film_id);
```
#### Arguments
* `$db` variable containing database handle as returned by `&db`
* `$film_id` integer variable containing ID of the film to be annotated
#### Returns
Nothing


## `chooseneg`
Select a negative by drilling down
#### Usage
```perl
my $id = &chooseneg({db=>$db, oktoreturnundef=>$oktoreturnundef});
```
#### Arguments
* `$db` variable containing database handle as returned by `&db`
* `$oktoreturnundef` optional boolean to specify whether it is OK to fail to find a negative
#### Returns
Integer representing the negative ID



## `db`
Connect to the database
#### Usage
```perl
my $db = &db;
```
#### Arguments
None
#### Returns
Variable representing the database handle


## `duration`
Calculate duration of a shutter speed from its string representation
#### Usage
```perl
my $duration = &duration($shutter_speed);
```
#### Arguments
* `$shutter_speed` string containing a representation of a shutter speed, e.g. `1/125`, `0.7`, `3`, or `3"`
#### Returns
Numeric representation of the duration of the shutter speed, e.g. `0.05`



## `friendlybool`
Translate "friendly" bools to integers so we can accept human input and map it to binary boolean values
#### Usage
```perl
my $binarybool = &friendlybool($friendlybool);
```
#### Arguments
* `$friendlybool` string representation of a boolean, e.g. `yes`, `y`, `true`, `1`, `no`, `n`, `false`, `0`, etc
#### Returns
`1` if `$bool` represents a true value and `0` if it represents a false value



## `hashdiff`
Compare new and old data to find changed keys.
#### Usage
```perl
my $diff = &hashdiff(\%old, \%new);
my $diff = &hashdiff($old, $new);
```
#### Arguments
* `$old` hashref of old values
* `$new` hashref of new values
#### Returns
Hashref containing values that are new or different.


## `ini`
Find PhotoDB config ini file
#### Usage
```perl
my $ini = &ini;
```
#### Arguments
None
#### Returns
File path to the config ini file


## `keyword`
Figure out the human-readable keyword of an SQL statement, e.g. statements that select from
`CAMERA` or `choose_camera` would return `camera`. Selecting from `CAMERA_MOUNT` or
`choose_camera_mount` would return `camera mount`. This can be helpful when automating
user messages.
#### Usage
```perl
my $keyword = &keyword($query);
```
#### Arguments
* `$query` an SQL statement, e.g. `SELECT * FROM CAMERA;`
#### Returns
A human-readable keyword representing the "subject" of the SQL query



## `listchoices`
List arbitrary choices from the DB and return ID of the selected one
#### Usage
```perl
my $id = &listchoices({db=>$db, table=>$table, where=>$where});
```
#### Arguments
* `$db` DB handle
* `$query` (legacy) the SQL to generate the list of choices
* `$type` Data type of choice to be made. Defaults to `text`
* `$inserthandler` function ref to handler that can be used to insert a new row if necessary
* `$default` ID of default choice
* `$autodefault` if default not set, count number of allowed options and if there's just 1, make it the default
* `$skipok` whether it is ok to return `undef` if there are no options to choose from
* `$table` table to run query again. Part of the SQL::Abstract tuple
* `$cols` columns to select for the ID and the description. Defaults to `('id', 'opt)`. Part of the SQL::Abstract tuple
* `$where` where clause passed in as a hash, e.g. `{'field'=>'value'}`. Part of the SQL::Abstract tuple
* `$keyword` keyword to describe the thing being chosen, e.g. `camera`. Defaults to attempting to figure it out with `&keyword`
* `$required` whether this is a required choice, or whether we allow the user to enter an empty input. Defaults to `0`
* `$char` character to use to signal that you want to enter a new row, if `inserthandler` is set. Defaults to `+`
#### Returns
ID of the selected option


## `lookupcol`
Return values from an arbitrary column from database as an arrayref
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `lookupval`
Return arbitrary value from database
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `newrecord`
Insert a record into any table
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `nocommand`
Print list of commands
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `nosubcommand`
Print list of subcommands for a given command
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `notimplemented`
Print a warning that this command/subcommand is not yet implemented
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `pad`
Pad a string with spaces up to a fixed length
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `parselensmodel`
Parse lens model name to guess some data about the lens
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `printbool`
Translate numeric bools to strings
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `printlist`
List arbitrary rows
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `prompt`
Prompt the user for an arbitrary value
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `resolvenegid`
Get a negative ID either from the neg ID or the film/frame ID
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `round`
Round numbers to any precision
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `tag`
This func reads data from PhotoDB and writes EXIF tags
to the JPGs that have been scanned from negatives
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `thin`
Thin out keys will null values from a sparse hash
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `today`
Return today's date according to the DB
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `unsetdisplaylens`
Unset the display lens from a camera
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `updatedata`
Update data using a bare `UPDATE` statement
Avoid using if possible
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `updaterecord`
Update an existing record in any table
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `validate`
Validate that a value is a certain data type
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `welcome`
Print welcome message
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns



## `writeconfig`
Write out a config file
#### Usage
```perl
&
```
#### Arguments
* `$`
#### Returns

