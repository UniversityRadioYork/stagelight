#!/bin/sh

. stagelight.inc.sh

for f in ${STAGING_D}/*
do
  SL_name_from_file "${f}"    # -> name
  SL_unprefix_name  "${name}" # -> uname
  SL_url_from_name  "${name}" # -> url

  if grep -q "mkstaging" "${f}"
  then
    SL_probe_config "${f}"    # -> port, dir
    SL_test_site_up "${url}" # -> status

    echo "${uname} valid ${port} ${dir} ${status}"
  else
    echo "${uname} invalid"
  fi
done
