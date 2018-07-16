 #!/bin/bash

NUM_ARGS_1=1
NUM_ARGS_2=2
E_BADARGS=65

if [ $# -ne $NUM_ARGS_1 -a $# -ne $NUM_ARGS_2 ]
then
    echo "Usage: `basename $0` <quoted-expr> [num-lines]"
    echo "  <quoted-expr>  expression to be repeated"
    echo "  <last-n-lines> last number of lines to list from output (optional)"
    exit $E_BADARGS
fi

# set up default value of 15 lines
num_lines=15
if [ $# -eq 2 ]
then
    num_lines=$2
fi

watch "$1 | tail -n $num_lines"

exit 0
