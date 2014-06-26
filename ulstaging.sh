#!/bin/sh

echo "<ul>"
lsstaging.sh | cut -d " " -f 5,1 | sed 's@^\([^ ]*\) \(.*\)$@<li><a href="\2">\1</a></li>@'
echo "</ul>"
