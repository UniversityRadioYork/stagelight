#!/bin/sh

. stagelight.inc.sh

SL_check_name_argument $# $1 # -> name, file, url
SL_probe_config ${file}      # -> port, dir
SL_test_site_up ${url}       # -> status

printf "Name:\t%s\nURL:\t%s\nPort:\t%s\nPath:\t%s\nStatus:\t%s\n" \
  ${name} ${url} ${port} ${dir} ${status}
