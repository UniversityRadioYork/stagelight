#!/bin/sh

STAGING_D=/usr/local/etc/apache24/staging.d
PREFIX='2013site-'

if [ "$#" -ne 1 ]
then
  echo "[!] Usage: $0 NAME."
  echo "    (eg: $0 mattbw)"
  exit
fi

NAME="${PREFIX}$1"
FILE="${STAGING_D}/${NAME}.conf"


if [ ! \( "${FILE}" \) ]
then
  echo "[!] Staging website ${NAME} does not exist."
  echo "    Please try a different name."
  exit
fi

rm $FILE

