# Roadmap

This is a list of high-level goals for the PhotoDB project. For specific issues,
bugs, feature requests, etc, please see the
[issue tracker](https://github.com/djjudas21/photography-database/issues).

## Docker support

Being a Perl application with quite a few dependencies, PhotoDB can be tricky to
install. I propose creating a Docker image that contains the app and all of the
dependencies, ready to use.

The tricky question is whether to bundle MySQL/MariaDB in with the Perl app, or
support having an external database.

We could also consider creating a pair of Docker images for the database and app
and bundle it with a Helm chart for deployment in Kubernetes.

## GUI

The app is currently command line only. I would be interested in adding a web
interface to ease the user experience and enable it to work on a phone.

There isn't an API as such so at the present time the GUI would have to be a set
of Perl CGIs that tap into the existing handlers and functions.

## Multi-user support

The app can currently track one collection of camera/lenses/photos. I would like
to add multi-user functionality so the app can be run as a service and multiple
people can log in and have their own collections.
