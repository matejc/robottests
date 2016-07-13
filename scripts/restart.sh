#!/usr/bin/env bash

PROJECT=$(dirname `readlink -f "$0"`)/..
FILES="extra/*.robot"

# This will take down the whole process tree on script exit
trap "exit" INT TERM
trap "kill 0" EXIT

while true; do
    NEW_OUTPUT=`find $FILES -exec openssl sha1 {} \; 2>/dev/null`;

    if [ "$NEW_OUTPUT" != "$OLD_OUTPUT" ]
    then
        # output changed
        if [ "$MYPID" ]; then kill -9 $MYPID; fi
        $PROJECT/scripts/start.sh "$FILES" "$PROJECT/var/www/extra" &  # command will output to stdout
        MYPID=$!;
        OLD_OUTPUT="$NEW_OUTPUT";
    fi

    sleep 5;
done
