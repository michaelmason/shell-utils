#!/bin/bash

ARGC=1
E_BADARGS=65

if [ $# -ne $ARGC ]
then
    echo "Usage:"
    echo "    `basename $0` <logfile>"
    echo
    echo "Arguments:"
    echo "    logfile   Logfile created by memlog.sh"
    echo
    echo "Description:"
    echo "    Plots the memory usage over time"
    echo
    exit $E_BADARGS
fi

logfile=$1

minval=0
maxval=128

gnuplot -persist <<-EOFMarker
    set title "Available System RAM Over Time" font ",14 textcolor rgbcolor
    set yrange [$minval:$maxval]
    set pointsize 1
    set xlabel "Time (25 second samples)"
    set ylabel "Available System RAM (GB)"
    set terminal png
    set output "`basename $logfile`.png"
    plot "$logfile" every 5 notitle with lines
EOFMarker
