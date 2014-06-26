#!/bin/sh

echo "<ul>"
lsstaging.sh | cut -d " " -f 4,1 | sed 's@^\([^ ]*\) \(.*\)$@<li><a href="\2">\1</a></li>@'
echo "</ul>"
