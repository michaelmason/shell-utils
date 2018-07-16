#!/bin/bash

echo
echo "**** checking GPU ID 0 ..."
nvidia-smi -i 0
echo

echo "**** checking GPU ID 1 ..."
nvidia-smi -i 1
echo

echo "**** checking GPU ID 2 ..."
nvidia-smi -i 2
echo
