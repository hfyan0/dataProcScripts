#!/bin/bash

DATA_FREQ=60
INPUT_DATA_PATH="/mnt/d/data/ebroker_data/hkfut4/"
OUTPUT_DATA_PATH="/mnt/d/data/ebroker_data/hkfut4_frontmth_snap"$DATA_FREQ"sec/"

CALENDAR_PATH=/home/qy/dr/nirvana/conf/HKFE_Calendar_full.csv
TMP_PATH=/tmp/tmp_extractFrontMthFutData
NORMAL_DAYS=/tmp/tmp_extractFrontMthFutData_normal
EXPIRY_DAYS=/tmp/tmp_extractFrontMthFutData_expiry

cat $CALENDAR_PATH | awk -F, '{print $2,$1}' | grep -v "Expir" | sort > $TMP_PATH
cat $TMP_PATH | grep ^Y | awk '{print $2}' | tr -d '-' > $EXPIRY_DAYS
cat $TMP_PATH | grep ^N | awk '{print $2}' | tr -d '-' > $NORMAL_DAYS


#########################################

rm -rf $OUTPUT_DATA_PATH
mkdir $OUTPUT_DATA_PATH

#########################################
for i in $(cat $EXPIRY_DAYS)
do
    cd $INPUT_DATA_PATH

    if [[ -e $i.csv ]]
    then
        echo $i.csv
        HSIFrontMth=$(cat $i.csv | grep -G HSI[A-Z] | awk -F ',' '{print $2}' | sort | uniq | head -2 | tail -1)
        HHIFrontMth=$(cat $i.csv | grep -G HHI[A-Z] | awk -F ',' '{print $2}' | sort | uniq | head -2 | tail -1)
        cat $i.csv | egrep "$HSIFrontMth|$HHIFrontMth" | grep -v 99999 | grep -v ^07 | grep -v ^08 | grep -v ^17 | grep -v ^18 | grep -v ^19 | grep -v ^20 | grep -v ^21 | grep -v ^22 | grep -v ^23 > $OUTPUT_DATA_PATH/$i.p.csv

        /home/qy/Dropbox/nirvana/workspaceCN/DataProcessing/Debug/DataProcessing 235 $OUTPUT_DATA_PATH/$i.p.csv /tmp/$i.p.csv $DATA_FREQ
        mv /tmp/$i.p.csv $OUTPUT_DATA_PATH/$i.csv
        rm -f $OUTPUT_DATA_PATH/$i.p.csv
    fi
done


#########################################
for i in $(cat $NORMAL_DAYS)
do
    cd $INPUT_DATA_PATH

    if [[ -e $i.csv ]]
    then
        echo $i.csv
        HSIFrontMth=$(cat $i.csv | grep -G HSI[A-Z] | awk -F ',' '{print $2}' | sort | uniq | head -1)
        HHIFrontMth=$(cat $i.csv | grep -G HHI[A-Z] | awk -F ',' '{print $2}' | sort | uniq | head -1)
        cat $i.csv | egrep "$HSIFrontMth|$HHIFrontMth" | grep -v 99999 | grep -v ^07 | grep -v ^08 | grep -v ^17 | grep -v ^18 | grep -v ^19 | grep -v ^20 | grep -v ^21 | grep -v ^22 | grep -v ^23  > $OUTPUT_DATA_PATH/$i.p.csv

        /home/qy/Dropbox/nirvana/workspaceCN/DataProcessing/Debug/DataProcessing 235 $OUTPUT_DATA_PATH/$i.p.csv /tmp/$i.p.csv $DATA_FREQ
        mv /tmp/$i.p.csv $OUTPUT_DATA_PATH/$i.csv
        rm -f $OUTPUT_DATA_PATH/$i.p.csv
    fi
done
