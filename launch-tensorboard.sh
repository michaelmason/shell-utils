#!/bin/bash

# ----------------------------------------------------------------------------
# TODO:
#    - take logdir as a parameter
#    - check for running on gpu009
#    - launch firefox automatically (?) and load URL (?)
# ----------------------------------------------------------------------------

echo "**** launching tensorboard ..."
export LC_ALL=C; tensorboard --logdir=./

echo "**** tensorboard started"
echo "**** on typhoon, launch firefox and navigate to: http://gpu009:6006"
