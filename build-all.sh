#!/bin/bash

# ----------------------------------------------------------------------------
# This script builds all of the tools in /home/mlm/bin that need to be
# compiled.
# ----------------------------------------------------------------------------

echo "**** building $HOME/bin tools ..."

# ----------------------------------------------------------------------------
# Build sizeof.cc -> sizeof
# This tool prints out the size (in bytes) of the built-in C and C++ datatypes
# ----------------------------------------------------------------------------
echo "**** building sizeof ..."
g++ sizeof.cc -o sizeof

# ----------------------------------------------------------------------------
# Build pbin.cc -> pbin
# This tool prints the binary representation of  the given integer
# ----------------------------------------------------------------------------
echo "**** building pbin ..."
g++ pbin.cc -o pbin

echo "**** builds complete"

exit 0
