#!/bin/bash

if [[ $# -eq 0 ]]
then
      echo "arg 1 : YYYYMMDD or ytd"
      exit
fi

if [[ $1 == "ytd" ]]
then
    YMD=$(/home/qy/Dropbox/utilities//dmath $(date +'%Y%m%d') -1)
else
    YMD=$(echo $1 | tr -d '-')
fi

if [[ -z $2 ]]
then
    cd /mnt/d/data/ib_datacapture/
    find /mnt/d/capi_protocol_server_rh63/data_capturedata_ibmdi/log/feedLog/ -type f | grep marketfeed | sort
    cat $(find /mnt/d/capi_protocol_server_rh63/data_capturedata_ibmdi/log/feedLog/ -type f | grep marketfeed | sort | tail -n 2) >> /mnt/d/data/ib_datacapture/$YMD"_ori.csv"
    ./fltr.sh $YMD"_ori.csv" $YMD"_mdfdori.csv"
    cd /home/qy/Dropbox/nirvana/sbtProj/dataProcConvTools/
    ./run_95_cashmdi.sh $YMD
    diff /mnt/d/data/ib_datacapture/$YMD"_mdfdori.csv" /mnt/d/data/ib_datacapture/$YMD"_restored.csv"
else
    rm -f /mnt/d/data/ib_datacapture/$YMD"_ori.csv" /mnt/d/data/ib_datacapture/$YMD"_mdfdori.csv" /mnt/d/data/ib_datacapture/$YMD"_restored.csv"
    gzip /mnt/d/data/ib_datacapture/2*
fi
