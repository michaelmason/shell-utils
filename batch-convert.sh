#!/bin/bash

NUM_ARGS=1
E_BADARGS=65

if [ $# -ne $NUM_ARGS ]
then
    echo "Usage: `basename $0` <quoted-input-file-glob>"
    exit $E_BADARGS
fi

input_glob=$1

for f in $input_glob;
do
    f_base=${f%.*}
    # echo $f
    # echo $f_base
    convert $f ${f_base}.png
done
