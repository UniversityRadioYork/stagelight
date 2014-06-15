#!/bin/sh

. stagelight.inc.sh

if [ "$#" -ne 1 ]
then
  echo "[!] Usage: $0 NAME."
  echo "    (eg: $0 mattbw)"
  exit
fi

SL_prefix_name    "$1"      # -> name
SL_file_from_name "${name}" # -> file

if [ ! \( "${file}" \) ]
then
  echo "[!] Staging website ${name} does not exist."
  echo "    Please try a different name."
  exit
fi

SL_dir_from_file "${file}" # -> dir
cd "${dir}"
./scripts/run-development.sh
