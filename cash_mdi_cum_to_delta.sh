#!/bin/bash

if [[ $# -eq 0 ]]
then
    echo "arg 1: folder containing input files"
    echo "arg 2: folder containing output files"
    exit
fi

cd $1
for i in *
do
    cat $i | awk -F, 'BEGIN{v=$4}{print $1,$2,$3,$4-v,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26; v=$4}' > $2/$i
done
