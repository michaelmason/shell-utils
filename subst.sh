#!/bin/bash

# ----------------------------------------------------------------------------
# Description:
#   Substitute one pattern for another pattern in a file
# ----------------------------------------------------------------------------

NUM_ARGS=3
E_BADARGS=65

if [ $# -ne $NUM_ARGS ]
then
    echo "Usage: `basename $0` <search-string> <replace-string> <file(s)>"
    exit $E_BADARGS
fi

search_string=$1
replace_string=$2

# ----------------------------------------------------------------------------
#
# sed arguments:
#
#    s          substitude command for sed
#    /pattern/  invokes string matching
#    g          global flag to tell sed to replace all occurrences (not just
#               the first)
#
# ----------------------------------------------------------------------------
sed -i "s/$search_string/$replace_string/g" $3

exit 0
