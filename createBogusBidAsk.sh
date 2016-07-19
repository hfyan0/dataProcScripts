#!/bin/bash

DATAPATH=/mnt/d/data/ccfData/hsi_hhi_bogusbidask

cd $DATAPATH

for i in *csv
do
    cat $i | awk -F"," '{print $1,$2,$3,$4,"B",$3,"5",$3,"4",$3,"3",$3,"2",$3,"1","A",$3,"5",$3,"4",$3,"3",$3,"2",$3,"1"}' | tr ' ' ',' > tmp ; mv -f tmp $i
done
