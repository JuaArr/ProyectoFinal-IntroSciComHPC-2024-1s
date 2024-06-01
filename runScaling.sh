#!/bin/bash

bash serial_simulation/runPre.sh
bash serial_simulation/runAll.sh
bash serial_simulation/runClean.sh

for nth in {2..4}
do
	bash parallel_simulation/runPre.sh $nth
	bash parallel_simulation/runAll.sh
	bash parallel_simulation/runAll.sh
done

bash scaling/runPlot.sh