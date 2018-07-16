#!/bin/bash

# ----------------------------------------------------------------------------
# This script executes the given quoted command on each compute node in the
# 'nodes' list
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Typhoon compute node list
# ----------------------------------------------------------------------------
nodes=("c001" "c002" "c003" "c004" "c005" "c006" "c007" "c008" "gpu009")

# ----------------------------------------------------------------------------
# Expecting 1 argument (quoted command to execute on each compute node)
#   - note: as long as the entire command is single-quoted, bash treats it
#     like a single argument
# ----------------------------------------------------------------------------
ARGC=1
E_BADARGS=65

if [ $# -ne $ARGC ]
then
    echo "Usage:"
    echo "    `basename $0` <quoted-command>"
    echo
    echo "Description:"
    echo "    Executes the given command on each compute node in the cluster"
    echo
    echo "Arguments:"
    echo "    quoted-command    Command to be executed on each compute node"
    echo
    echo "Example:"
    echo "    Suppose you want to copy a config file from each compute node"
    echo "    to a common location, but you also want to avoid overwriting"
    echo "    files with the same filename.  Here is how you can insert the"
    echo "    hostname into the filename to ensure that it's unique and it"
    echo "    won't overwrite other config files:"
    echo
    echo "    CONFIG_FILE=\"/etc/slurm/slurm.conf\""
    echo "    TARGET_DEST=\"/data/tmp/slurm-conf-compare\""
    echo "    $0 'cp $CONFIG_FILE \$TARGET_DEST/slurm.\$HOSTNAME.conf"
    echo
    exit $E_BADARGS
fi

cmd=$1

# ----------------------------------------------------------------------------
# TODO:
#     Add ability to toggle whether the operation also gets executed on the
#     head-node
#
#     Perhaps just add another argument and test for string-equality:
#
#         --headnode (long option)
#          -hn
# ----------------------------------------------------------------------------
# echo "[head]  `$cmd`"
# ----------------------------------------------------------------------------

for node in "${nodes[@]}"
do
    # ------------------------------------------------------------------------
    # echo "**** processing $node"
    # ------------------------------------------------------------------------
    #
    # ------------------------------------------------------------------------
    # prints entire hostname
    # ------------------------------------------------------------------------
    # echo "[$node] `ssh $node $cmd`"
    # ------------------------------------------------------------------------
    #
    # ------------------------------------------------------------------------
    # prints just first 4 characters for hostname (to keep things lined up!)
    # ------------------------------------------------------------------------
    # echo "[${node:(-4)}]  `ssh $node $cmd`"
    # ------------------------------------------------------------------------
    #
    # ------------------------------------------------------------------------
    # don't print anything but the result of the user-defined command
    # ------------------------------------------------------------------------
    ssh $node $cmd
done
