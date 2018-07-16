#!/bin/bash

# ----------------------------------------------------------------------------
# font="-misc-fixed-bold-r-normal--18-120-100-100-c-90-iso8859-1"
# xterm         \
#     -bg black \
#     -fg white \
#     -fn $font &
# ----------------------------------------------------------------------------

NUM_ARGS=1
n=1

if [ $# -eq $NUM_ARGS ]
then
    n=$1
fi

for i in `seq $n`
do
    xterm_font="-misc-fixed-bold-r-normal--18-120-100-100-c-90-iso8859-1"
    xterm -cr green -bg black -fg white -fn $xterm_font &
done

exit 0
