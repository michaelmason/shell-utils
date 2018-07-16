#!/bin/bash

E_BADARGS=65

if [ $# -ne 1 -a $# -ne 2 ]
then
    echo "Usage: `basename $0` <max-value> [num-values]"
    echo "    max-value    Range maximum"
    echo "    num-values   Number of values to return [optional, default=0]"
    echo
    echo "Description:"
    echo -n "    Generates <num-values> random integers between 0 and "
    echo "<max-value>"
    exit $E_BADARGS
fi

lo=0
hi=$1

num_rand=1
if [ $# -eq 2 ]
then
    num_rand=$2
fi

# echo "**** generating $num_rand random integer(s) in range: ($lo, $hi)"

shuf -i 0-$hi -n $num_rand
