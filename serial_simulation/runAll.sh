#!/bin/bash

source /usr/lib/openfoam/openfoam2312/etc/bashrc

cd serial_simulation

nOS=1
time_file="time_$nOS.log"

echo -n "$nOS    " > $time_file

{ time pimpleFoam > log.FOAMout 2> log.FOAMerror; } 2>&1 | grep real | awk '{print $2}' | awk -Fm '{print $1*60 + $2}' >> $time_file

mv $time_file ../scaling/$time_file