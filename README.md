# stagelight

A collection of scripts to ease making testing/staging websites on
the URY development server.

This is currently URY-private, but could be generalised and made
free and public later.


## The Frontends

### stagelight-panel.sh

* **Usage**: stagelight-panel.sh

This is a ``dialog``-based text user interface for Stagelight,
exposing the features of the scripts in a slightly prettier manner.

It will ask for a sudo password when doing superuser-level actions.


## The Scripts

### cfgstaging.sh

* **Usage**: cfgstaging.sh ``NAME``
* **Example**: cfgstaging.sh mattbw

Opens the ``development.ini`` Pyramid configuration for a staging
website in a text editor.  This respects the ``VISUAL`` and ``EDITOR``
environment variables, but defaults to ``nano`` if those are not
set.

### chkstaging.sh

* **Usage**: chkstaging.sh ``NAME``
* **Example**: chkstaging.sh mattbw

This prints out some information about the named staging site, and
goes into slightly more detail than ``lsstaging``.

### lsstaging.sh

* **Usage**: lsstaging.sh

This lists all current staging websites, their ports, and their
working directories.

### mkstaging.sh

* **Usage**: sudo mkstaging.sh ``NAME`` ``PORT`` ``DIR``
* **Example**: sudo mkstaging.sh mattbw 8000 ~/2013site

This creates a staging website entry in the Apache configuration,
exposing a test website residing at ``DIR`` on the file-system and
running on ``PORT`` as https://urybsod.york.ac.uk/2013site- ``NAME``.
It will warn you if the name or port is already in use.

You will need to make sure that your website copy is configured to
launch on ``PORT`` and prefix its URLs with 2013site-``NAME``.

### runstaging.sh

* **Usage**: sudo runstaging.sh ``NAME``
* **Example**: sudo runstaging.sh mattbw

Starts the development server for the given staging entry, inside
its configured virtualenv.

### rmstaging.sh

* **Usage**: sudo rmstaging.sh ``NAME``
* **Example**: sudo rmstaging.sh mattbw

Removes the named staging entry.

### ulstaging.sh

* **Usage**: ulstaging.sh

As lsstaging.sh, but processes the information into a HTML
snippet that can be included (eg. via server-side includes) into a
Web page.


## Installation

Either add the stagelight directory to your PATH, or (as root):
``sudo make install``

## TODO

* Higher-level interface, including Apache restarting
* Generalisation/cleanup
* Open-sourcing (MIT licence?)
