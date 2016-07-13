#!/usr/bin/env bash

PROJECT=$(dirname `readlink -f "$0"`)/..

if [[ -n "$1" ]]; then
  export FILES="$1"
elif [[ -n "$FILES" ]]; then
  echo "Using $FILES"
else
  export FILES="sites/**/*.robot"
fi

ls -lah $PROJECT/$FILES

source $PROJECT/bin/activate

export REPORTDIR="$PROJECT/var/www"
test -n "$2" && export REPORTDIR="$2"

DATE=$(date +"%d-%m-%Y_%T-%z")
mkdir -p "$REPORTDIR/$DATE"

$PROJECT/bin/robot --outputdir="$REPORTDIR/$DATE" \
  $PROJECT/$FILES 2>&1 | tee $PROJECT/var/log/sites.log

ln -sf $REPORTDIR/$DATE/* $REPORTDIR/

chmod -R +xr $PROJECT/var/www

# delete old
find $PROJECT/var/www -mtime +10 -type f -delete
