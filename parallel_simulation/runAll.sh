#!/bin/bash

source /usr/lib/openfoam/openfoam2312/etc/bashrc

cd parallel_simulation

# Obtener el valor de nOS de la primera línea del archivo machines
nOS=$(awk 'NR==1 {split($2, a, "="); print a[2]}' machines)

# Ejecutar el comando mpirun con el valor de nOS
{ time mpirun --hostfile machines -np "$nOS" pimpleFoam -parallel > log.FOAMout 2> log.FOAMerror ; } | grep real | awk '{print $2}' | awk -Fm '{print $1*60 + $2}' 2> "time_$nOS.log"

# Reintegrar la malla
reconstructPar &> /dev/null