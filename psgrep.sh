#!/bin/bash

NUM_ARGS=1
E_BADARGS=65

if [ $# -ne $NUM_ARGS ]
then
    echo "Usage: `basename $0` <process-name>"
    exit $E_BADARGS
fi

tgt_process=$1

ps -Af | grep $tgt_process

exit 0
