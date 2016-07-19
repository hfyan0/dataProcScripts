#!/bin/bash

if [[ $# -eq 0 ]]
then
    echo "Usage: arg 1 dir"
    exit
fi

TARGETDIR=$1"_nearOC"

rm -rf $TARGETDIR
mkdir $TARGETDIR

cd $1/
for i in 1*.csv 2*.csv
do
    cat $i | grep -v ^05 | grep -v ^06 | grep -v ^07 | grep -v ^08 | grep -v ^094 | grep -v ^095 | grep -v ^10 | grep -v ^11 | grep -v ^12 | grep -v ^13 | grep -v ^14 | grep -v ^150 | grep -v ^151 | grep -v ^152 | grep -v ^153 | grep -v ^154 | grep -v ^17 | grep -v ^18 | grep -v ^19 | grep -v ^20 | grep -v ^21 | grep -v ^22 | grep -v ^23 > ../$TARGETDIR/$i
done
