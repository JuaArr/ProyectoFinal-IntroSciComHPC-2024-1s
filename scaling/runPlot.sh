#!/bin/bash

cd scaling

wtime_1=$(awk '{print $2}' time_1.log)

export wtime_1

cat time_*.log | awk -v wtime="$wtime_1" '{print $1, $2, wtime/$2, wtime/$2/$1}' > metrics.txt

rm -f time_*.log

gnuplot plot.gp