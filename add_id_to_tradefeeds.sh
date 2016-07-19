#!/bin/bash

if [[ $# -eq 0 ]]
then
    echo "arg : tradefeed file"
    exit
fi

TRADEFEEDFILE=$1

cat $TRADEFEEDFILE | awk -F, 'BEGIN{i=0; OFS=","}{print $1,$2,$3,$4,$5"_"i,$6,$7,$8,$9"_"i,$10; i=i+1}'

