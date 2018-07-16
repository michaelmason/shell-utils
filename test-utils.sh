#!/bin/bash

# ----------------------------------------------------------------------------
# name:
#     get_datetime
#
# description:
#     Returns (via echo) a string containing the current date/time
#
# usage:
#     dt=`get_datetime`
#
# parameters:
#     None
#
# return:
#     None
# ----------------------------------------------------------------------------
function get_datetime()
{
    echo `date +'%a %Y-%m-%d %H:%M:%S'`
}

# ----------------------------------------------------------------------------
# name:
#     console_log
#
# description:
#     Writes the specified string to the console with a date/time stamp
#
# usage:
#     console_log <quoted-str>
#
# parameters:
#     str  *req*  Positional argument $1  String to write to console
#
# return:
#     None
# ----------------------------------------------------------------------------
function console_log()
{
    if [ $# -ne 1 ]
    then
        echo "Usage:  console_log <log-message>"
        exit 1
    fi

    # get the log message
    msg=$1

    # ------------------------------------------------------------------------
    # removed timezone
    # ------------------------------------------------------------------------
    # echo '['$(date +'%a %Y-%m-%d %H:%M:%S %z')']' $msg
    # ------------------------------------------------------------------------
    echo '['$(date +'%a %Y-%m-%d %H:%M:%S')']' $msg
}

# ----------------------------------------------------------------------------
# name:
#     sep
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

# ----------------------------------------------------------------------------
# name:
#     banner_msg
#
# description:
#     Prints out a message to the console with a preceding and proceding
#     seprator line
#
# parameters:
#     bmsg_str (arg #1) The message string to write
#     head_chr (arg #2) First character of the separator line     (default: #)
#     line_chr (arg #3) Repeating character of the separator line (default: -)
#
# notes:
#     If no parameters are supplied, the following default values are used:
#         head_chr = '#'
#         line_chr = '-'
#
#    In order for the user to specify a sep_char value, the head_chr value
#    must also be specified (due to how positional arguments work in Bash)
#
# return:
#     None
# ----------------------------------------------------------------------------
function banner_msg()
{
    if [ $# -eq 0 ]
    then
        echo "Usage: banner_msg <msg> <head-chr> <line-chr>"
        echo "    msg       Message to print to console"
        echo "    head-chr  Line separator prefix character (default: '#')"
        echo "    line-chr  Line separator character        (default: '-')"
    fi

    bmsg_str=$1

    # default head character
    head_chr='#'
    if [ $# -ge 2 ]
    then
        # use specified head character
        head_chr=$2
    fi

    # default line character
    line_chr='-'
    if [ $# -ge 3 ]
    then
        # use specified line character
        line_chr=$3
    fi

    sep   $head_chr $line_chr
    echo "$head_chr $bmsg_str"
    sep   $head_chr $line_chr
}

# ----------------------------------------------------------------------------
# make these utils available publicly ...
# ----------------------------------------------------------------------------
# export -f console_log
# export -f sep
# export -f banner_msg
# ----------------------------------------------------------------------------
