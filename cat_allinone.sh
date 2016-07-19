#!/bin/bash

# INPUT_DATA_PATH=/mnt/d/data/ebroker_data/hkfut4_frontmth_snap60sec/
# OUTPUT_DATA_FILE=/mnt/d/data/ebroker_data/hkfut4_frontmth_snap60sec_allinone.csv

if [[ $# -eq 0 ]]
then
    echo "req: arg 1 = input folder containing all source csv, arg 2 = __full path__ of output file, not output folder"
    exit
fi

INPUT_DATA_PATH=$1
OUTPUT_DATA_FILE=$2

rm -f $OUTPUT_DATA_FILE

cd $INPUT_DATA_PATH
for i in *csv
do
    DATE_STR=$(echo $i | sed -e 's/.csv//')
    cat $i | sed -e "s/^/"$DATE_STR"_/" | sed -e 's/,/_000000,/' >> $OUTPUT_DATA_FILE
done
