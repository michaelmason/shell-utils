#!/bin/bash

# ----------------------------------------------------------------------------
# Description:
#   Substitute one pattern for another pattern in a file
# ----------------------------------------------------------------------------

NUM_ARGS=3
E_BADARGS=65

if [ $# -ne $NUM_ARGS ]
then
    echo "Usage:"
    echo "    `basename $0` <file-ext> <search-string> <directory>"
    echo
    echo "Arguments:"
    echo "    file-ext       File extensions to search"
    echo "    search-string  Target search string"
    echo "    directory      Directory to begin search"
    echo
    echo "Example:"
    echo "    `basename $0` py matplotlib ~/devel"
    exit $E_BADARGS
fi

ext=$1
str=$2
dir=$3

grep -r -i --include \*.$ext $str $dir
