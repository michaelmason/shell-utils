#!/bin/bash

TESTFILE=testfile
time sh -c "dd if=/dev/zero of=$TESTFILE bs=100k count=10k && sync"

rm $TESTFILE
