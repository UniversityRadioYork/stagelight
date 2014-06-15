# stagelight

A collection of scripts to ease making testing/staging websites on
the URY development server.

This is currently URY-private, but could be generalised and made
free and public later.

## The Scripts

### mkstaging.sh

* **Usage**: sudo mkstaging.sh ``NAME`` ``PORT``
* **Example**: sudo mkstaging.sh mattbw 8000

This creates a staging website entry in the Apache configuration,
exposing a test website on ``PORT`` as
https://urybsod.york.ac.uk/2013site- ``NAME``.  It will warn you if
the name or port is already in use.

You will need to make sure that your website copy is configured to
launch on ``PORT`` and prefix its URLs with 2013site-``NAME``.

### lsstaging.sh

* **Usage**: lsstaging.sh

This lists all current staging websites and their ports.

## TODO

* Higher-level interface, including Apache restarting
* Generalisation/cleanup
* Installation
* Open-sourcing (MIT licence?)
