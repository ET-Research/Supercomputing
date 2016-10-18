#!/bin/sh
# Usage: bash mk.sh rSTAGE.submit.sh 1 2 3 4 ...
#  This will create r1.submit.sh, r2.submit.sh ...
# In rSTAGE.submit.sh, two macros are defined: DATE and STAGE
# DATE will be replaced by the result of `date` command
# STAGE will be replaced by the arguments on the command line, 
# i.e., 1, 2, 3, 4, ...
# -------------------------------------------------------------
# Author: Yuhang(Steven) Wang
# Date: 10/18/2016
# License: MIT/X11
# -------------------------------------------------------------

d=`date`
args=("$@")
template=$1
for ((k=1; k < ${#args[@]}; k++)); do
  i=${args[$k]}
  newFile=$(echo $template | sed s/STAGE/$i/)
  sed s/STAGE/$i/g $template | sed "s/DATE/$d/g" > $newFile
  echo $newFile
done
