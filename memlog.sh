#!/bin/bash

REQ_ARGC=0
OPT_ARGC=1
E_BADARGS=65

if [ $# -ne $OPT_ARGC -a $# -ne $REQ_ARGC ]
then
    echo "Usage: `basename $0` [sleep-seconds]"
    echo
    echo "Arguments:"
    echo "    sleep-seconds  [Optional] Sleep time (in seconds) between output"
    echo
    exit E_BADARGS
fi

if [ $# -eq $OPT_ARGC ]
then
    SLEEP_TIME_SEC=$1
    echo "**** using user-defined sleep time: $SLEEP_TIME_SEC seconds"
else
    SLEEP_TIME_SEC=5
    echo "**** using default sleep time: $SLEEP_TIME_SEC seconds"
fi

# ----------------------------------------------------------------------------
# get current date/time in a format that we can use in a filename (in order
# to make sure we generate a unique filename and to avoid overwriting previous
# log files
# ----------------------------------------------------------------------------
DATE=`date '+%Y%m%d%H%M%S'`
LOGFILE=mem_$DATE.log

echo "****"                                    > $LOGFILE
echo "**** beginning memory logging (`date`)" >> $LOGFILE
echo "****"                                   >> $LOGFILE
echo                                          >> $LOGFILE

free -g -s $SLEEP_TIME_SEC >> $LOGFILE
