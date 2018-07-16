#!/bin/bash

# ----------------------------------------------------------------------------
#
# code to check/count number of bash command line arguments
#
# ----------------------------------------------------------------------------

# 'a' is an array that contains all command line arguments
a=${0}
echo "**** number of arguments:           $#"
echo "**** total length of all arguments: ${#a}"

count=0
for arg in "$@"
do
    echo "     length of argument '$arg': ${#arg}"
    (( count++ ))
    (( accum += ${#arg} ))
done

echo "**** counted number of arguments:    $count"
echo "**** accumulated length of all args: $accum"
