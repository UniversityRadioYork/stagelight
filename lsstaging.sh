#!/bin/sh

STAGING_D=/usr/local/etc/apache24/staging.d

for f in ${STAGING_D}/*
do
  NAME=`basename ${f} | sed "s/.conf//"`

  if grep -q "mkstaging" "${f}"
  then
    PORT=`egrep -o 'https?:.*:[0-9]+' ${f} | cut -f 3 -d: | head -n 1`
    DIR=`egrep -o '^# *DIR *.+' ${f} | sed 's/# *DIR *//'`
    echo "${NAME} valid ${PORT} ${DIR}"
  else
    echo "${NAME} invalid"
  fi
done
