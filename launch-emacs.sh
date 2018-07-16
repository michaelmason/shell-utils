#!/bin/bash

# ----------------------------------------------------------------------------
# font_name="-misc-fixed-bold-r-normal--18-120-100-100-c-90-iso8859-1"
# emacs -fn $font_name --geometry 80x40
# ----------------------------------------------------------------------------

NUM_ARGS=1
n=1

if [ $# -eq $NUM_ARGS ]
then
    n=$1
fi

for i in `seq $n`
do
    # emacs_exe=/usr/local/bin/emacs
    # emacs -fn "-misc-fixed-bold-r-normal--18-120-100-100-c-90-iso8859-1" &
    #
    # emacs -fn "-misc-fixed-bold-r-normal--18-120-100-100-c-90-iso8859-1" \
    #       --geometry 80x40 > /dev/null 2>&1 &
    #
    emacs --geometry 80x40 > /dev/null 2>&1 &

done
