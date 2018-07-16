#!/bin/bash

ARGC=1
E_BADARGS=65

if [ $# -ne $ARGC ]
then
    echo "Usage:"
    echo "    `basename $0` <logfile>"
    echo
    echo "Arguments:"
    echo "    logfile   Logfile created by memlog.sh"
    echo
    echo "Description:"
    echo "    Extracts the amount of free memory for each timestep contained"
    echo "    in the specified memlog.sh logfile"
    echo
    exit $E_BADARGS
fi

logfile=$1

grep Mem $logfile  | awk '{print $7}'
