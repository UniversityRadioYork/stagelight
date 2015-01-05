#!/bin/sh

# numstaging.sh - prints number of staging websites
#
# usage: numstaging.sh

. stagelight.inc.sh

ls -1 "${STAGING_D}"  | # List number of staging config files, one per line
wc -l                 | # Count number of lines
tr -cd "0123456789\n"   # Remove anything that isn't the number or newline
