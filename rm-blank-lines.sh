#!/bin/bash

# ----------------------------------------------------------------------------
#
# Description:
#
#   Removes blank lines from input file and prints results to standard output
#
# ----------------------------------------------------------------------------

E_NOARGS=65
if [ -z "$1" ]
then
    echo "Usage: `basename $0` <target-file>"
    echo
    echo "Description:"
    echo "  Removes blank lines from input file and prints result to standard"
    echo "  output"
    echo
    echo "Arguments:"
    echo "  <target-file>  input file from which to remove blank lines"
    echo
    exit $E_NOARGS
fi

# The sed command below is the same as:
#
#     sed -e '/^$/d' filename
#
# invoked from the command line
#
# sed arguments:
#
#    -e    means an "editing" command follows (optional here)
#     ^    beginning of line
#     $    end of line
#
# This matches lines with nothing between the beginning and the end of line
# (in other words, blank lines).  
# The 'd' is the delete command.

# quoting the command-line arg permits whitespace and special characters in
# the filename.
sed -e /^$/d "$1"

# successful completion
exit 0
