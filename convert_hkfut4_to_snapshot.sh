#!/bin/bash
# for INTERVAL in 10 30 60
for INTERVAL in 60
do
   SRC_DIR="/mnt/d/data/ebroker_data/hkfut4/"
   TGT_DIR="/mnt/d/data/ebroker_data/hkfut4_snap"$INTERVAL"sec/"
   rm -f $TGT_DIR/*
   cd $SRC_DIR
   for i in *csv
   do
       /home/qy/workspaceCN/DataProcessing/Debug/DataProcessing 235 $SRC_DIR/$i $TGT_DIR/$i $INTERVAL
   done
done
