 #!/bin/bash

ARGC_1=1
ARGC_2=2
E_BADARGS=65

if [ $# -ne $ARGC_1 -a $# -ne $ARGC_2 ]
then
    echo "Usage `basename $0` <filename> [num-lines]"
    echo "  - filename             - the file to be watched"
    echo "  - num-lines (optional) - number of lines to list from the file"
    exit $E_BADARGS
fi

num_lines=15
if [ $# -eq 2 ]
then
    num_lines=$2
fi

watch "tail -n $num_lines $1"
