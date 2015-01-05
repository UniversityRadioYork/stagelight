#!/bin/sh

# bashstaging.sh - fire up GNU Bash inside a staging website's virtualenv
#
# usage: bashstaging.sh SITENAME

. stagelight.inc.sh

SL_check_name_argument $# "${1}" # -> name, file, url
SL_probe_config "${file}"        # -> port, dir

cd "${dir}"
bash --rcfile bin/activate
