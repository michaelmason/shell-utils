#!/bin/bash

NUM_ARGS=1
n=1

if [ $# -eq $NUM_ARGS ]
then
    n=$1
fi

for i in `seq $n`
do
    TERM=xterm-256color emacs -nw
done
