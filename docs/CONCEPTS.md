# PhotoDB Concepts

## Introduction

PhotoDB is a database and application for cataloguing film cameras, lenses, accessories, films, negatives and prints - as well a range of other information
such as exhibitions, orders, and darkroom chemicals. It is also capable of writing EXIF tags to JPG files scanned from negatives and prints.

PhotoDB is strictly governed by relational database principles which can make it seem fiddly and complicated to use, but this structured data gives PhotoDB
its power.

The data is all stored in a MySQL backend and managed by the PhotoDB app, which does its best to be helpful when adding data and hopefully hide most of the
sharp edges from the user.

This guide tries to explain the key concepts behind PhotoDB. It is not an exhaustive guie to every command available. To list all commands, run `photodb help`.
To list all subcommands available under a command, run (for example) `photodb camera`. Each subcommand has a brief explanation with it.

## User data

Out of the box, PhotoDB is mostly empty, ready for you to enter your own data. However if you install PhotoDB in the recommended way, it comes with some pre-
filled data e.g. about manufacturers, film emulsions, film sizes, metering modes, etc, to get you up and running faster. In many cases you'll want to add to
this data to suit your own needs but you shouldn't need to edit anything that already exists.

The command `photodb data` has subcommands for adding various pieces of data. Normally, you shouldn't need to go out of your way to add this type of data, as
PhotoDB will prompt you if you need to add any while adding cameras, lenses, films, etc.

## Unique identifiers

Every object registered in PhotoDB (e.g. camera, lenses, films, negatives, etc) is allocated a unique ID number, starting at 1 and counting up. This number is
used to reference other objects. This number is often prefixed with a `#` for readability, e.g. _Film #99_.

One exception where alternative naming is also used is for negatives. A negative might have an ID of #100 but it may also be referred to in the format 18/6,
where 18 is the ID number of the film it belongs to, and 6 is the number of the frame, separated by a forward slash. This alternative system makes it easier
to handle negatives in the darkroom. It is accepted in most places in PhotoDB where a negative ID is needed.

## Cameras and lenses

Cameras and lenses are the central component of PhotoDB. Cameras and lenses can relate to each other in one of two ways:
* directly, for fixed-lens cameras (e.g. compacts)
* via a lens mount, for interchangeable-lens cameras (e.g. SLRs)

You will be guided through questions when adding a new camera or lens by running `photodb camera add` or `photodb lens add`. When adding a fixed-lens camera
you will be asked to give details about the lens at the same time, which is then associated only with that camera. When adding an interchangeable-lens camera,
you only specify the lens mount. You can add lenses separately by running `photodb lens add`, which are then available to use with any camera with the same
mount.

Cameras and lenses have properties of different types. Some are text (like the model name), some are numerical (like the maximum aperture of a lens), some are
yes/no (like whether a lens has autofocus) and some are multiple choice (like the different metering modes a camera supports).

## Films and negatives

If you use the cameras and lenses to take photographs, you'll want to start entering information about films and negatives into PhotoDB. The word _negatives_
is a bit misleading as it refers to any image taken with a camera, including slides - which are positive!

PhotoDB lets you record a stash of films by running `photodb film add`, which you can then load into a camera with `photodb film load`. Films are associated
with a camera. They can be developed with `photodb film develop` and archived with `photodb film archive`.

When you take pictures, we recommend you take notes about your exposures using a smartphone app, a piece of paper, or what ever method suits you. Then you can
enter the data into PhotoDB at a later date. Negatives are associated with films and inherit some of their properties from the film they belong to. Negatives
are added by running `photodb negative add`.

Negatives are also associated with a lens, as on many cameras it is possible to change lens between exposures.

## Prints

Whether you have a darkroom, or you get your negatives printed at a lab, PhotoDB can track your prints. Prints are associated with the negative they were made
from. You'll be able to add other info about how the print was made. Prints are added by running `photodb print add`.

You can also record orders for prints with `photodb print order`, view your printing to-do list with `photodb print worklist` and record sales of prints with
`photodb print sell`.

## Scans and tagging

Scans refer to digital versions of negatives, slides or prints that can be made with a scanner or a digital camera. Each negative/slide/print can be scanned
more than once. Each scan must be recorded separately. You can run `photodb scan add` to manually add a scan to the database.

PhotoDB needs you to set a directory on your computer for scans to be saved in. It prefers if its scans are the only thing in that directory. It is strongly
recommended to make a directory just for scans of your negatives and prints, e.g. `/home/you/Pictures/Scans` or similar. If you access PhotoDB on more than one
computer, you can configure a different directory on each computer.

Under this directory, PhotoDB expects there to be a subdirectory for each film. There is no mandatory naming specification, but the preferred convention is
the number of the film ID followed by a brief human-readable title, e.g. `55 Holiday in Rome`.

Inside each subdirectory individual scans should be named `<film_id>-<frame>-<filename>.jpg`, for example `55-3-img123.jpg` or `55-3-Coliseum.jpg` where `55`
is the number of the film ID, `3` is the frame number (as written on the edge of the film) and the rest can be anything you like. The scans should not be put
inside another subdirectory.

PhotoDB does not create these directories or the scans inside them. It is up to you to name the scans this way. However, if you stick to the above naming
convention, PhotoDB will at least record your scans and associate them with the right negative, to save you too much tedious data entry. You can tell PhotoDB
to search for and add scans automatically by running `photodb scan search`.

Once the scanned JPGs have been entered into the database and associated with negatives or prints, you can add EXIF tags to the JPGs - the same as would be
automatically written to JPGs taken by a digital camera. Supported tags include date, caption, geotag, exposure data, etc. This allows you to use almost any
digital photo management app to sort, browse, and view your images with ease.

Use `photodb negative tag` to tag all scans of a single negative or `photodb film tag` to tag all scans from an entire film.

It is safe to run tag commands more than once, as PhotoDB will only add or update tags that have changed.

## Accessories

PhotoDB allows you to track your collection of camera and lens accessories, too. There are several "special" kinds of accessories that have their own
properties, commands and relationships, and there are general accessories with no special properties. You can create your own types of general accessory.

Special types of accessory with their own properties include:
* battery
* filter
* filter adapter
* flash
* meter
* mount adapter
* projector
* teleconverter

All of the above "special" accessories can be added to the database with `photodb accessory <accessory>`.

Types of general accessory with no special properties could include cases or straps. General accessories can be associated with cameras or lenses, or neither.
Add new general accessories with `photodb accessory add` and add new categories of general accessories with `photodb accessory category`.
