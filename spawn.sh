#!/bin/sh
#
#  sh spawn.sh "brew cask install" Brewfile
#
if [ $# -ne 2 ]; then
    echo "Usage: $0 <COMMAND> <FILE>";
    exit 1;
fi

FILE=$2
COMMAND=$1

LINES=`cat $2 | wc -l`

LINES_DIV_FOUR=$(($LINES/4));

FROM=1
TO=$LINES_DIV_FOUR
for x in `seq 1 4`; do
    echo "${FROM} --> ${TO}";

    FROM=$(($FROM+$LINES_DIV_FOUR))
    TO=$(($FROM+$LINES_DIV_FOUR))

    (setsid $COMMAND `cat $FILE | sed "${FROM},${TO}!d"` &)
done
