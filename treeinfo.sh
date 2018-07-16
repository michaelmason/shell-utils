#!/bin/bash

search ()
{
    for dir in `echo *`
    # `echo *` lists all the files in current working directory without line
    # breaks
    #           
    # similar effect to "for dir in *" but "for dir in `echo *`" will not
    # handle filenames with blanks.
    do
        if [ -d "$dir" ] ; then     # if it is a directory (-d) ...
            lev=0                   # then keep track of directory level
            while [ $lev != $1 ]    # keep track of inner nested loop
            do
                echo -n "| "        # display vertical connector symbol
                                    # with 2 spaces & no line feed
                                    # in order to indent the listing
                lev=`expr $lev + 1` # increment 'lev'
            done

            if [ -L "$dir" ] ; then # if directory is a symbolic link ...
                echo "+---$dir" `ls -l $dir | sed 's/^.*'$dir' //'`
                # display horiz. connector and list directory name, but delete
                # date/time part of long listing.
            else
                echo "+---$dir"             # display horizontal connector symbol
                                            # and print directory name
                numdirs=`expr $numdirs + 1` # increment directory count.
                if cd "$dir" ; then         # if we can move to subdirectory
                    search `expr $1 + 1`    # then do so, with recursion ;-)
                    cd ..
                fi
            fi
        fi
    done
}

if [ $# != 0 ] ; then
    cd $1   # move to directory
    #else   # stay in current directory
fi

echo "**** initial directory: `pwd`"
numdirs=0

search 0
echo "**** total directories: $numdirs"

exit 0
