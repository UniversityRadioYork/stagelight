#!/bin/sh

# ulstaging.sh - print HTML list of staging website information
#
# usage: ulstaging.sh

echo "<ul>"

lsstaging.sh        | # Get normal information about all websites
cut -d " " -f 1,5,6 | # Select the URL, name, and up-status
sed 's@^\([^ ]*\) \([^ ]*\) \([a-z]*\).*$@<li><a href="\2">\1 (currently \3)</a></li>@'
# ^-- Format it into a list item

echo "</ul>"
