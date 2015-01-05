#!/bin/sh

# runstaging.sh - run staging website in foreground
#
# usage: runstaging.sh SITENAME

. stagelight.inc.sh

SL_check_name_argument $# "${1}" # -> name, file, url
SL_dir_from_file "${file}"       # -> dir
cd "${dir}"
./"${WEBSITE_RUN}"
