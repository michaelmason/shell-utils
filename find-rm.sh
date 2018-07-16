 #!/bin/bash

NUM_ARGS=2
E_BADARGS=65

if [ $# -ne $NUM_ARGS ]
then
    echo "Usage: `basename $0` <base-dir> <filename-glob>"
    echo "    <base-dir>       location to begin the find/rm operation"
    echo "    <filename-glob>  glob matching files to be deleted"
    exit $E_BADARGS
fi

base_dir=$1  # base directory
tgt_glob=$2  # target glob

echo "**** base dir:    $base_dir"
echo "**** target glob: $tgt_glob"

find $base_dir -name $tgt_glob -exec rm -rf {} \;

exit 0
