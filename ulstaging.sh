#!/bin/sh

echo "<ul>"
lsstaging.sh | cut -d " " -f 1,5,6 | sed 's@^\([^ ]*\) \([^ ]*\) \([a-z]*\)@<li><a href="\2">\1 (currently \3)</a></li>@'
echo "</ul>"
