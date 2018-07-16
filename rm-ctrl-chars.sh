#!/bin/bash

ifile=$1
ofile=$2

# ----------------------------------------------------------------------------
# these are the characters we're going to preserve ... all others will be
# stripped from the input file
# ----------------------------------------------------------------------------
# octal 11:     tab
# octal 12:     linefeed
# octal 15:     carriage return
# octal 40-176: all the "good" keyboard characters
# ----------------------------------------------------------------------------

tr -cd '\11\12\40-\176' < $ifile > $ofile
