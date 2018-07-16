#!/bin/bash

EXP_ARGC=1
E_BADARGS=65

if [ $# -ne $EXP_ARGC ]
then
    echo "Usage: `basename $0` <quoted-command> <logfile>"
    echo "    quoted-command   The command (enclosed in quotes) to be repated"
    # echo "    logfile          File to which all output is written"
    exit $E_BADARGS
fi

cmd=$1
# log=$2

# ----------------------------------------------------------------------------
# name:
#     sep()
#
# description:
#     Prints out a horizontal separator line
#
# parameters:
#     head_chr (arg #1) First character of the separator line     (default: #)
#     line_chr (arg #2) Repeating character of the separator line (default: -)
#
# notes:
#     If no parameters are supplied, the following default values are used:
#         head_chr = '#'
#         line_chr = '-'
#
#    In order for the user to specify line_char, head_chr must also be
#    specified (due to how positional arguments work in Bash)
#
# return:
#     None
# ----------------------------------------------------------------------------
function sep()
{
    # default head character
    head_chr='#'
    if [ $# -ge 1 ]
    then
        # use specified head character
        head_chr=$1
    fi

    # default line separator character
    line_chr='-'
    if [ $# -eq 2 ]
    then
        # use specified separator line character
        line_chr=$2
    fi

    # write out head character (with no newline)
    echo -n "$head_chr "

    # write out repeating line separator character (with no newline)
    for i in `seq 1 76` ;
    do
        echo -n "$line_chr"
    done

    # finally write a newline
    echo
}

while true; do
    $cmd # >> $log
    sleep 30
done
