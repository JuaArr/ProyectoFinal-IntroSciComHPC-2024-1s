#!/bin/bash

source /usr/lib/openfoam/openfoam2312/etc/bashrc

cd parallel_simulation

# Leer los valores de tmin, tmax, deltaT y writeInterval desde el archivo controlDict de OpenFOAM utilizando awk
startTime=$(awk 'NR==21 {print $2}' system/controlDict | tr -d ';')
endTime=$(awk 'NR==25 {print $2}' system/controlDict | tr -d ';')
deltaT=$(awk 'NR==27 {print $2}' system/controlDict | tr -d ';')
writeInterval=$(awk 'NR==31 {print $2}' system/controlDict | tr -d ';')

# Calcular tstep como el producto de deltaT y writeInterval
stepTime=$((deltaT * writeInterval))

# Eliminar los directorios numerados según los valores leídos
rm -fr $(seq $stepTime $stepTime $endTime)
rm -fr constant/polyMesh
rm -fr processor*
rm -f system/decomposeParDict
rm -f log.FOAMout log.FOAMerror
rm -f machines