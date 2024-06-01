#!/bin/bash

echo "Running for 1 thread"
bash serial_simulation/runPre.sh
bash serial_simulation/runAll.sh
bash serial_simulation/runClean.sh

for nth in {2..4}
do
	echo "Running for $nth thread"
	bash parallel_simulation/runPre.sh $nth
	bash parallel_simulation/runAll.sh
	bash parallel_simulation/runClean.sh
done

bash scaling/runPlot.sh