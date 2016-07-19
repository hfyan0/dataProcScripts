#!/bin/bash

if [[ $# -eq 0 ]]
then
    echo "arg 1 : source folder containing mdi format data with cumulative volume"
    echo "arg 2 : destination folder"
fi

SRC_FOLDER=$1
DEST_FOLDER=$2

if [[ ! -d $SRC_FOLDER ]]
then
    echo "source folder does not exist"
    exit
fi

if [[ ! -d $DEST_FOLDER ]]
then
    mkdir -p $DEST_FOLDER
fi

cd $SRC_FOLDER
for i in *
do
    if [[ ! -f $i ]]; then continue; fi
    cat $i | awk -F, 'BEGIN{OFS=","; lastcumvol=$4; lastYMD="19700101"}{ if (substr($1,0,8)!=lastYMD) print; else print $1,$2,$3,$4-lastcumvol,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26; lastcumvol=$4; lastYMD=substr($1,0,8); }' > $DEST_FOLDER/$i
done
