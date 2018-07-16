#!/bin/bash

EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` <target-extension> <replacement-extension>"
  exit $E_BADARGS
fi

tgt_ext=$1
new_ext=$2

# echo "-- renaming files with extension '${tgt_ext}' to '${new_ext}'"

for file in *.${tgt_ext} 
do
    mv "$file" "`basename $file .${tgt_ext}`.${new_ext}"
done

exit 0
