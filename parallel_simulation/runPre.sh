#!/bin/bash

source /usr/lib/openfoam/openfoam2312/etc/bashrc

nproc=$1

cd parallel_simulation

blockMesh &> /dev/null

sed "s/nOS/$nproc/" system/decomposeParDict-draft > system/decomposeParDict

decomposePar &> /dev/null

sed "s/nOS/$nproc/" machines-draft > machines