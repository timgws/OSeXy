#!/bin/sh
#
#  sh spawn.sh "brew cask install" Brewfile
#
. cecho.sh
if [ $# -ne 2 ]; then
    echo "Usage: $0 <COMMAND> <FILE>";
    exit 1;
fi

FILE=$2
COMMAND=$1

LINES=`cat $2 | wc -l`

PROC_TIMES=5
LINES_DIV=$(($LINES/$PROC_TIMES));

FROM=1
TO=$LINES_DIV
for x in `seq 1 $PROC_TIMES`; do
    if [[ $x == $PROC_TIMES ]]; then TO=$LINES; fi
    APPLICATIONS=`cat $FILE | sed -e "${FROM},${TO}!d" | tr '\n' ' '`
    cecho "Launching ${cyan} $COMMAND ${normal}${bold} for the following applications: ${green}${APPLICATIONS}";

    $COMMAND $APPLICATIONS &

    if [[ $FROM -eq 1 ]]; then FROM=1; LINES_DIV=$((LINES_DIV-1)); else FROM=$(($FROM+1)); fi
    FROM=$(($FROM+$LINES_DIV))
    TO=$(($FROM+$LINES_DIV))
done


for job in `jobs -p`; do
    echo "Waiting for process $job to finish install...";
    wait $job || let "FAIL+=1"
done

