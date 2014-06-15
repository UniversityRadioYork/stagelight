#!/bin/sh

STAGING_D=/usr/local/etc/apache24/staging.d
PREFIX='2013site-'

if [ \( -z "$1" \) -o \( -z "$2" \) ]
then
  echo "[!] Usage: $0 NAME PORT (eg: $0 mattbw 8000)."
  exit
fi

NAME="${PREFIX}$1"
FILE="${STAGING_D}/${NAME}.conf"
HOST="http://localhost:$2"


if [ -e "${NAME}" ]
then
  echo "[!] Staging website ${NAME} already exists."
  echo "    Please try a different name."
  exit
fi

if grep -q "${HOST}" ${STAGING_D}/*.conf
then
  echo "[!] Host ${HOST} is already in use."
  echo "    Please try a different port number."
  exit
fi


echo "[>] Creating ${NAME} on host ${HOST}."

STANZA="/${NAME} ${HOST} retry=0"

echo "# Autogenerated by mkstaging - do not edit manually" > ${FILE}
echo "ProxyPass ${STANZA}" >> $FILE
echo "ProxyPassReverse ${STANZA}" >> $FILE

