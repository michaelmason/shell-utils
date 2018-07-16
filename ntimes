#!/bin/bash

NUM_ARGS=2
E_BADARGS=65

if [ $# -ne $NUM_ARGS ]
then
    echo "Usage: `basename $0` <quoted-expr> <num-times>"
    echo "  quoted-expr  expression to be repeated N times"
    echo "  num-lines    number of times to execute command"
    exit $E_BADARGS
fi

expr=$1
ntimes=$2

for i in `seq $ntimes`
do
    eval $expr
done

exit 0
