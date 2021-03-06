#!/bin/sh

# cfgstaging.sh - open configuration of given website
#
# usage: cfgstaging.sh SITENAME

. stagelight.inc.sh

SL_check_name_argument $# "${1}" # -> name, file, url
SL_probe_config "${file}"        # -> port, dir

if [ -n "${VISUAL}" ]
then
	edit="${VISUAL}"
elif [ -n "${EDITOR}" ]
then
	edit="${EDITOR}"
else
	edit=nano
fi

${edit} "${dir}/${WEBSITE_CFG}"
