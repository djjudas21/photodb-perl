# Function reference

Note that some of these functions take traditional argument lists which must
be in order, while the more complex functions take a hashref of arguments
which can be passed in any order. Examples of each function are given

---
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


---
## `basepath`
Returns filesystem basepath which contains scans
#### Usage
```perl
my $basepath = &basepath;
```
#### Arguments
None
#### Returns
Path to directory which contains scans


---
## `call`
Call a stored procedure from the database
#### Usage
```perl
&call({db=>$db, procedure=>'print_unarchive', args=>['123']});
```
#### Arguments
* `$db` DB handle
* `$procedure` name of the database stored procedure to call
* `$args` arrayref of arguments to pass to the stored procedure
####
Number of affected rows


---
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


---
## `choosescan`
Select a scan by specifying a filename. Allows user to pick if there are multiple matching filenames.
#### Usage
```perl
my $id = &choosescan($db);
```
#### Arguments
* `$db` variable containing database handle as returned by `&db`
#### Returns
Integer representing the scan ID


---
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


---
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


---
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


---
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


---
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


---
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


---
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
* `$table` table to run query against. Part of the SQL::Abstract tuple
* `$cols` columns to select for the ID and the description. Defaults to `('id', 'opt)`. Part of the SQL::Abstract tuple
* `$where` where clause passed in as a hash, e.g. `{'field'=>'value'}`. Part of the SQL::Abstract tuple
* `$keyword` keyword to describe the thing being chosen, e.g. `camera`. Defaults to attempting to figure it out with `&keyword`
* `$required` whether this is a required choice, or whether we allow the user to enter an empty input. Defaults to `0`
* `$char` character to use to signal that you want to enter a new row, if `inserthandler` is set. Defaults to `+`
#### Returns
ID of the selected option


---
## `logger`
Record a database event in the log
#### Usage
```perl
&logger({db=>$db, type=>$type, message=>$message});
```
#### Arguments
* `$db` DB handle
* `$type` Type of log message. Currently `ADD` or `EDIT` to reflect database changes.
* `$message` Message to write to the log file
#### Returns
ID of the log message


---
## `lookupcol`
Return values from an arbitrary column from database as an arrayref
#### Usage
```perl
my $existing = &lookupcol({db=>$db, table=>'CAMERA', where=>{camera_id=>$camera_id}});
```
#### Arguments
* `$db` DB handle
* `$query` (legacy) bare SQL query to run
* `$table` table to run query against. Part of the SQL::Abstract tuple
* `$cols` columns to select for the ID and the description. Defaults to `*`. Part of the SQL::Abstract tuple
* `$where` where clause passed in as a hash, e.g. `{'field'=>'value'}`. Part of the SQL::Abstract tuple
#### Returns
An arrayref containing a hashref of columns and values


---
## `lookuplist`
Return multiple values from a single database column as an arrayref
#### Usage
```perl
my $values = &lookuplist({db=>$db, col=>$column, table=>$table, where{key=>value}});
```
#### Arguments
* `$db` DB handle
* `$table` table to run query against. Part of the SQL::Abstract tuple
* `$col` column to select. Part of the SQL::Abstract tuple
* `$where` where clause passed in as a hash, e.g. `{'field'=>'value'}`. Part of the SQL::Abstract tuple
#### Returns
An arreyref containing a list of values


---
## `lookupval`
Return arbitrary single value from database
#### Usage
```perl
my $info = &lookupval({db=>$db, col=>'notes', table=>'FILM', where=>{film_id=>$film_id}});
```
#### Arguments
* `$db` DB handle
* `$query` (legacy) bare SQL query to run
* `$table` table to run query against. Part of the SQL::Abstract tuple
* `$col` column to select. Part of the SQL::Abstract tuple
* `$where` where clause passed in as a hash, e.g. `{'field'=>'value'}`. Part of the SQL::Abstract tuple
#### Returns
Single value from the database


---
## `newrecord`
Insert a record into any table
#### Usage
```perl
my $id = &newrecord({db=>$db, data=>\%data, table=>'FILM'});
```
#### Arguments
* `$db` DB handle
* `$data` reference to hash of new values to insert
* `$table` Name of table to insert into
* `$silent` Suppress user output and don't ask for confirmation. Defaults to `0`.
* `$log` Write an event to the database log. Defaults to `1`.
#### Returns
Primary key of inserted row


---
## `nocommand`
Print list of available op-level command
#### Usage
```perl
&nocommand(\%handlers);
```
#### Arguments
* `$handlers` reference to hash of handlers from `handlers.pm`
#### Returns
Nothing


---
## `nosubcommand`
Print list of available subcommands for a given command
#### Usage
```perl
&nosubcommand(\%{$handlers{$command}}, $command);
```
#### Arguments
* `$command` name of command whose subcommands you want
* `$handlers` reference to hash slice of handlers from `handlers.pm`
#### Returns
Nothing


---
## `notimplemented`
Print a warning that this command/subcommand is not yet implemented
#### Usage
```perl
&notimplemented
```
#### Arguments
None
#### Returns
Nothing


---
## `now`
Return an SQL-formatted timestamp for the current time
#### Usage
```perl
my $time = &now($db);
```
#### Arguments
* `$db` Database handle
#### Returns
String containing the current time, formatted `YYYY-MM-DD HH:MM:SS`


---
## `pad`
Pad a string with spaces up to a fixed length, to make it easier to print fixed-width tables
#### Usage
```perl
my $paddedstring = &pad('Hello', 8);
```
#### Arguments
* `$string` Text to pad
* `$totallength` Total number of characters to pad to, defaults to `18`
#### Returns
Padded string


---
## `parselensmodel`
Parse lens model name to guess some data about the lens. Either specify which parameter you want
to be returned as a string, or expect a hashref of all params to be returned. Currently supports guessing
`minfocal` (minimum focal length), `maxfocal` (maximum focal length), `zoom` (whether this is a zoom lens)
and `aperture` (maximum aperture of lens).
#### Usage
```perl
my $aperture = &parselensmodel($model, 'aperture');
my $lensparams = &parselensmodel($model);
```
#### Arguments
* `$model` Model name of the lens
* `$param` The name of the desired parameter. Optional, choose from `minfocal`, `maxfocal`, `zoom` or `aperture`.
#### Returns
* If `$param` is specified, returns the value of this parameter as a string
* If `$param` is undefined, returns a hashref of all parameters


---
## `printbool`
Translate numeric bools to strings for friendly printing of user messages
#### Usage
```perl
my $string = &printbool($bool);
```
#### Arguments
* `$bool` boolean value to rewrite
#### Returns
Returns `yes` if `$bool` is true and `no` if `$bool` is false.


---
## `printlist`
Print arbitrary rows from the database as an easy way of displaying data
#### Usage
```perl
&printlist({db=>$db, msg=>"prints from negative $neg_id", table=>'info_print', where=>{'`Negative ID`'=>$neg_id}});
```
#### Arguments
* `$db` DB handle
* `$msg` Message to display to user to describe what is being displayed. Shows up as `Now showing $msg\n`
* `$table` Table to select from. Part of the SQL::Abstract tuple
* `$cols` Columns to display. Defaults to `(id, opt)`. Part of the SQL::Abstract tuple
* `$where` Where clause for the query. Part of the SQL::Abstract tuple
* `$order` Order by clause for the query. Part of the SQL::Abstract tuple
#### Returns
Nothing


---
## `prompt`
Prompt the user for an arbitrary value. Has various options for data validation and customisation of the prompt.
If the provided input fails validation, or if a blank string is given when `required=1` then the prompt is
repeated.
#### Usage
```perl
my $camera = &prompt({prompt=>'What model is the camera?', required=>1, default=>$$defaults{model}, type=>'text'});
```
would give a prompt like
```
What model is the camera? (text) []: 
```
#### Arguments
* `$default` Default value that will be used if no input from user. Default empty string.
* `$prompt` Prompt message for the user
* `$type` Data type that this input expects, out of `text`, `integer`, `boolean`, `date`, `decimal`, `time`
* `$required` Whether this input is required, or whether it can return an empty value. Default `0`
* `$showtype` Whether to show the user what data type is expected, in parentheses. Default `1`
* `$showdefault` Whether to show the user what the default value is set to, in square brackets. Default `1`
* `$char` Character to print at the end of the prompt. Defaults to `:`
#### Returns
The value the user provided


---
## `resolvenegid`
Get a negative ID either from the neg ID or the film/frame ID
#### Usage
```perl
my $negID = &resolvenegid($db, '10/4');
```
#### Arguments
* `$db` DB handle
* `$string` String to represent a negative ID, either as an integer or in film/frame format, e.g. `10/4`
#### Returns
Integer negative ID


---
## `round`
Round a number to any precision
#### Usage
```perl
my $rounded = &round($num, 3);
```
#### Arguments
* `$num` Number to round
* `$pow10` Number of decimal places to round to. Defaults to `0` i.e. round to an integer
#### Returns
Rounded number


---
## `tag`
This func reads data from PhotoDB and writes EXIF tags
to the JPGs that have been scanned from negatives
#### Usage
```perl
&tag($db, $where);
&tag($db, {film_id=1});
&tag($db, {negative_id=100});
```
#### Arguments
* `$db` DB handle
* `$where` hash to specify which scans should be tagged. Tags all scans if not set!
#### Returns
Nothing


---
## `thin`
Thin out keys with empty values from a sparse hash
#### Usage
```perl
# Delete empty strings from data hash
$data = &thin($data);
```
#### Arguments
* `$data` Hashref containing data to be thinned
#### Returns
Hashref containing thinned data


---
## `today`
Return today's date according to the DB
#### Usage
```perl
my $todaysdate = &today($db);
```
#### Arguments
* `$db` DB handle
#### Returns
Today's date, formatted `YYYY-MM-DD`


---
## `unsetdisplaylens`
Unassociate a display lens from a camera by passing in either the camera ID or
the lens ID. It is not harmful to pass in both, but it is pointless.
#### Usage
```perl
&unsetdisplaylens({db=>$db, camera_id=>$camera_id});
&unsetdisplaylens({db=>$db, lens_id=>$lens_id});
```
#### Arguments
* `$db` DB handle
* `$camera_id` ID of camera whose display lens you want to unassociate
* `$lens_id` ID of lens you want to unassociate
#### Returns
Result of SQL update


---
## `updatedata`
Update data using a bare SQL `UPDATE` statement. Avoid using this if possible,
as it is dangerous. Use `&updaterecord` instead.
#### Usage
```perl
my $rows = &updatedata($db, $sql);
```
#### Arguments
* `$db` DB handle
* `$query` Plain SQL UPDATE query to execute
#### Returns
The number of rows updated


---
## `updaterecord`
Update an existing record in any table
#### Usage
```perl
my $rows = &updaterecord({db=>$db, data=>\%data, table=>'FILM', where=>{film_id=>$film_id}});
```
#### Arguments
* `$db` DB handle
* `$data` Hash of new values to update
* `$table` Name of table to update
* `$where` Where clause, formatted for SQL::Abstract
* `$silent` Suppress output
* `$log` Write an event to the database log. Defaults to `1`.
#### Returns
The number of rows updated


---
## `deleterecord`
Delete an existing record from any table
#### Usage
```perl
my $rows = &deleterecord({db=>$db, table=>'FILM', where=>{film_id=>$film_id}});
```
#### Arguments
* `$db` DB handle
* `$table` Name of table to delete from
* `$where` Where clause, formatted for SQL::Abstract
* `$silent` Suppress output
* `$log` Write an event to the database log. Defaults to `1`.
#### Returns
The number of rows deleted


---
## `validate`
Validate that a value is a certain data type
#### Usage
```perl
my $result = &validate({val => 'hello', type => 'text'});
```
#### Arguments
* `$val` The value to be validated
* `$type` Data type to validate as, out of `text`, `integer`, `boolean`, `date`, `decimal`, `time`. Defaults to `text`.
#### Returns
Returns `1` if the value passes validation as the requested type, and `0` if it doesn't.


---
## `welcome`
Print a friendly welcome message
#### Usage
```perl
&welcome;
```
#### Arguments
None
#### Returns
Nothing


---
## `writeconfig`
Write out an initial config file by prompting the user interactively.
#### Usage
```perl
&writeconfig($path);
```
#### Arguments
* `$path` path to the config file that should be written
#### Returns
Nothing
