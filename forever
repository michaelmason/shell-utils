#!/bin/bash

NUM_ARGS=1
E_BADARGS=65

if [ $# -ne $NUM_ARGS ]
then
    echo "Usage: `basename $0` <quoted-cmd>"
    echo "  <quoted-cmd>    command to execute forever"
fi

cmd=$1

while true;
do
    eval $cmd
done

exit 0

