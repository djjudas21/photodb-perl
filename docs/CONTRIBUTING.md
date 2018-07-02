# Contributing to PhotoDB

### Altering the schema

This section describes how to alter the schema, and document the changes.

Make your edits to the schema using any tool you prefer (I like MySQL Workbench). Then use
the included Perl script `dump-schema.pl` to export the dump files in the right format.

You'll need the following CPAN modules on your system:
 * `Getopt::Long`
 * `Term::ReadKey`
 * `DBI`
 * `DBD::MySQL`

`Getopt::Long` seems to be standard in the Red Hat distribution of Perl but you'll need
to install the others by doing:

```
yum install perl-TermReadKey perl-DBI perl-DBD-MySQL
```

Change into the working directory of the script and do the following:

```
./dump-schema.pl --hostname 192.168.0.1 --database photography --username joebloggs

# Default values:
# hostname = localhost
# database = photography
# username = whoever is currently logged in
```

The script **will delete all existing SQL dump files and write them out again**. Do not run
this in random paths on your system!

After running the script, check which files have been added, removed or changed, and then commit
the diffs with a meaningful commit message.
