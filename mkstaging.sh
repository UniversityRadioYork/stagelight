#!/bin/sh

. stagelight.inc.sh

if [ "$#" -ne 3 ]
then
  echo "[!] Usage: $0 name PORT DIRECTORY."
  echo "    (eg: $0 mattbw 8000 ~/2013site)"
  exit
fi

SL_prefix_name            "$1"      # -> name
SL_file_from_name_nocheck "${name}" # -> file
SL_host_from_port         "$2"      # -> host
SL_normalise_path         "$3"      # -> path

if [ -e "${file}" ]
then
  echo "[!] Staging website ${name} already exists."
  echo "    Please try a different name."
  exit 1
fi

if grep -q "${host}" ${STAGING_D}/*.conf
then
  echo "[!] Host ${host} is already in use."
  echo "    Please try a different port number."
  exit 3
fi

if [ ! \( -d "${path}" \) ]
then
  echo "[!] ${path} is not a directory."
  exit 4
fi


echo "[>] Creating ${name} for ${path} on host ${host}."

stanza="/${name} ${host} retry=0"

echo "# Autogenerated by mkstaging - do not edit manually" >  ${file}
echo "# DIR ${path}"                                       >> ${file}
echo "ProxyPass ${stanza}"                                 >> ${file}
echo "ProxyPassReverse ${stanza}"                          >> ${file}

