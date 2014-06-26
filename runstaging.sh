#!/bin/sh

. stagelight.inc.sh

if [ "$#" -ne 1 ]
then
  echo "[!] Usage: $0 NAME."
  echo "    (eg: $0 mattbw)"
  exit 1
fi

SL_check_name_argument $# $1 # -> name, file, url
SL_dir_from_file "${file}" # -> dir
cd "${dir}"
./scripts/run-development.sh
