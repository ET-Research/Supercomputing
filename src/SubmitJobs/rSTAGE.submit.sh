#!/bin/bash
#SBATCH --job-name="bmSTAGE"
#SBATCH --output="../log/rSTAGE.log"
#SBATCH --partition=normal
#SBATCH --nodes=73
#SBATCH --ntasks-per-node=16
#SBATCH --export=ALL
#SBATCH -t 24:00:00
# -------------------------------------------------------------
# Author: Yuhang(Steven) Wang
# Date: 10/18/2016
# License: MIT/X11
# -------------------------------------------------------------

stage=STAGE
config=../namd/rSTAGE.namd.tcl

#Load NAMD module
module load namd

#Run MPI job using ibrun
ibrun namd2 $config
