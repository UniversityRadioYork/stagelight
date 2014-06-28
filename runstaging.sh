#!/bin/sh

. stagelight.inc.sh

SL_check_name_argument $# "${1}" # -> name, file, url
SL_dir_from_file "${file}"       # -> dir
cd "${dir}"
./scripts/run-development.sh
