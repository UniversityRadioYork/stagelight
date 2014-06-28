#!/bin/sh

. stagelight.inc.sh

SL_check_name_argument $# "${1}" # -> name, file

if [ ! \( "${file}" \) ]
then
  echo "[!] Staging website ${name} does not exist."
  echo "    Please try a different name."
  exit
fi

rm "${file}"

