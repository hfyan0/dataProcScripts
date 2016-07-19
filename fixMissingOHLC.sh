#!/bin/bash

INPUTFILE="$1"

cat $INPUTFILE | awk -F, '{if (NF == 3) print $1","$2","$3","$3","$3","$3; else if (NF == 4) print $1","$2","$3","$4","$3","$3; else if (NF == 5) print $1","$2","$3","$4","$5","$3; else print $1","$2","$3","$4","$5","$6}'
