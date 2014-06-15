#!/bin/sh

. stagelight.inc.sh

for f in ${STAGING_D}/*
do
  SL_name_from_file "${f}" # -> name

  if grep -q "mkstaging" "${f}"
  then
    SL_port_from_file "${f}" # -> port
    SL_dir_from_file  "${f}" # -> dir

    echo "${name} valid ${port} ${dir}"
  else
    echo "${name} invalid"
  fi
done
