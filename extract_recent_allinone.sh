#!/bin/bash

DATAFOLDER=/mnt/d/data/blmg/

for ADJUNADJ in 1 2
do
    if [[ $ADJUNADJ -eq 1 ]]
    then
        ALLINONEFILE=$DATAFOLDER/usequities_adj_allinone.csv
        ALLINONEFILERECENT=$DATAFOLDER/usequities_adj_allinone_recent.csv
    else
        ALLINONEFILE=$DATAFOLDER/usequities_unadj_allinone.csv
        ALLINONEFILERECENT=$DATAFOLDER/usequities_unadj_allinone_recent.csv
    fi

    cat $ALLINONEFILE | tail -n +$(grep -n ^20160715 $ALLINONEFILE | head -1 | awk -F: '{print $1}') > $ALLINONEFILERECENT
done
