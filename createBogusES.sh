#!/bin/bash
BOGUSESFOLDER=/mnt/d/data/ebroker_data/bogusES/
SOURCEHSIFUTFOLDER=/mnt/d/data/ebroker_data/hkfut4_snap60sec/

rm -rf $BOGUSESFOLDER
mkdir -p $BOGUSESFOLDER

cd $SOURCEHSIFUTFOLDER
for i in *csv
do
    cat $i | grep -v HHI | grep -v MHI | grep -v MCH | sed -e 's/HSIF/ESH/' | sed -e 's/HSIG/ESH/' | sed -e 's/HSIH/ESH/' | sed -e 's/HSIJ/ESM/' | sed -e 's/HSIK/ESM/' | sed -e 's/HSIM/ESM/' | sed -e 's/HSIN/ESU/' | sed -e 's/HSIQ/ESU/' | sed -e 's/HSIU/ESU/' | sed -e 's/HSIV/ESZ/' | sed -e 's/HSIX/ESZ/' | sed -e 's/HSIZ/ESZ/' > $BOGUSESFOLDER/$i
done
