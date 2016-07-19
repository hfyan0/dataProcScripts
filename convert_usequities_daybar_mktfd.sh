#!/bin/bash

TMPFILE1=/tmp/i3uyksajgrt
TMPFILE2=/tmp/i3uyksajgrt2
DMATHLOC=/home/qy/Dropbox/utilities/dmath

source /home/qy/Dropbox/dataENF/blmg/common_path.sh

for ADJUNADJ in 1 2
do
    if [[ $ADJUNADJ -eq 1 ]]
    then
        PATH1="/mnt/d/data/blmg/usequities_adj/"
        PATH2="/mnt/d/data/blmg/usequities_adj_daybar/"
        PATH3="/mnt/d/data/blmg/usequities_adj_tmp/"
        PATH4="/mnt/d/data/blmg/usequities_adj_blmgdaybar/"
        PATH5="/home/qy/Dropbox/dataENF/blmg/data_adj/"
    else
        PATH1="/mnt/d/data/blmg/usequities_unadj/"
        PATH2="/mnt/d/data/blmg/usequities_unadj_daybar/"
        PATH3="/mnt/d/data/blmg/usequities_unadj_tmp/"
        PATH4="/mnt/d/data/blmg/usequities_unadj_blmgdaybar/"
        PATH5="/home/qy/Dropbox/dataENF/blmg/data_unadj/"
    fi
    
    rm -rf $PATH1 $PATH2 $PATH3 $PATH4
    rm -f $TMPFILE1 $TMPFILE2
    mkdir $PATH1 $PATH2 $PATH3 $PATH4
    
    cd $PATH4
    for SYM in $SYMBOLLIST_USETF
    do
        cp $PATH5/$SYM".csv" $SYM".csv"
        cat $PATH4/$SYM".csv" | awk -F, '{print $1","$3","$4","$5","$6}' > $PATH2/$SYM".csv"
        /home/qy/Dropbox/nirvana/workspaceCN/DataProcessing/Debug/DataProcessing 236 $PATH2/$SYM".csv" $PATH3/$SYM".csv" $SYM 003000 010000 021500 040000 DOHLC
    done

    #########################################################
    # marketfeeds are now in US YYYYMMDD but HK HHMMSS
    #########################################################
    
    cat $PATH3/* | cut -c1-8 | sort | uniq > $TMPFILE1
    for usymd in $(cat $TMPFILE1)
    do
        hkymd=$($DMATHLOC $usymd 1)
        grep -h $usymd $PATH3/* | sed -e "s/$usymd/$hkymd/" > $PATH1/$hkymd.csv
    done
    
    #########################################################
    # marketfeeds are now in HK YYYYMMDD and HK HHMMSS :)
    #########################################################
    
    #########################################################
    # duplicate the market close data
    #########################################################
    cd $PATH1
    for i in 19*csv 2*csv
    do
        cat $i | cut -c10-1000 | sed -e 's/_000000//' | sort > $TMPFILE1

        cat $TMPFILE1 > $TMPFILE2
        cat $TMPFILE1 | grep ^04 | sed -e 's/^0400/0300/' >> $TMPFILE2

        cat $TMPFILE2 | sort > $i
        cat $TMPFILE1 | grep ^04 >> $i
    done
    
    rm -f $TMPFILE1 $TMPFILE2
done
