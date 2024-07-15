#!/bin/bash

run_simulation () {
	if [ $1 -eq 1 ]
	then
		bash serial_simulation/runPre.sh
		bash serial_simulation/runAll.sh
		bash serial_simulation/runClean.sh
	else
		bash parallel_simulation/runPre.sh $1
		bash parallel_simulation/runAll.sh
		bash parallel_simulation/runClean.sh
	fi
}

for nth in {1..16}
do
	echo "Running for $nth threads ..."
	run_simulation $nth
done

echo "Plotting ..."
bash scaling/runPlot.sh