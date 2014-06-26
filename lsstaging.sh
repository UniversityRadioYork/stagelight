#!/bin/sh

. stagelight.inc.sh

for f in ${STAGING_D}/*
do
  SL_name_from_file "${f}"    # -> name
  SL_unprefix_name  "${name}" # -> uname

  if grep -q "mkstaging" "${f}"
  then
    SL_port_from_file "${f}" # -> port
    SL_dir_from_file  "${f}" # -> dir

    echo "${uname} valid ${port} ${dir}"
  else
    echo "${uname} invalid"
  fi
done
