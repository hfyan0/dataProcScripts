#!/bin/bash

TMPFILE1=/tmp/i3uyksajgrt
TMPFILE2=/tmp/i3uyksajgrt2

source /home/qy/Dropbox/dataENF/blmg/common_path.sh

for ADJUNADJ in 1 2
do
    if [[ $ADJUNADJ -eq 1 ]]
    then
        PATH1="/mnt/d/data/blmg/hkequities_adj/"
        PATH2="/mnt/d/data/blmg/hkequities_adj_daybar/"
        PATH3="/mnt/d/data/blmg/hkequities_adj_tmp/"
        PATH4="/mnt/d/data/blmg/hkequities_adj_blmgdaybar/"
        PATH5="/home/qy/Dropbox/dataENF/blmg/data_adj/"
    else
        PATH1="/mnt/d/data/blmg/hkequities_unadj/"
        PATH2="/mnt/d/data/blmg/hkequities_unadj_daybar/"
        PATH3="/mnt/d/data/blmg/hkequities_unadj_tmp/"
        PATH4="/mnt/d/data/blmg/hkequities_unadj_blmgdaybar/"
        PATH5="/home/qy/Dropbox/dataENF/blmg/data_unadj/"
    fi
    
    rm -rf $PATH1 $PATH2 $PATH3 $PATH4
    rm -f $TMPFILE1 $TMPFILE2
    mkdir $PATH1 $PATH2 $PATH3 $PATH4
    
    cd $PATH4
    # for SYM in $SYMBOLLIST_HKSTK_D1
    for SYM in 1 5 386 386 857 857 883 939 939 1088 1088 1288 1299 1398 1398 2318 2318 2328 2628 2628 3988 3988 388 688 6837 700 762 941 914 1211 1928 2333
    do
        cp $PATH5/$SYM".csv" $SYM".csv"
        cat $PATH4/$SYM".csv" | awk -F, '{print $1","$3","$4","$5","$6}' > $PATH2/$SYM".csv"
        /home/qy/Dropbox/nirvana/workspaceCN/DataProcessing/Debug/DataProcessing 236 $PATH2/$SYM".csv" $PATH3/$SYM".csv" $SYM 100000 113000 150000 160000 DOHLC
    done

    #########################################################
    # marketfeeds are now in HK HHMMSS
    #########################################################
    
    cat $PATH3/* | cut -c1-8 | sort | uniq > $TMPFILE1
    for hkymd in $(cat $TMPFILE1)
    do
        grep -h $hkymd $PATH3/* > $PATH1/$hkymd.csv
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
        cat $TMPFILE1 | grep ^16 | sed -e 's/^1600/1515/' >> $TMPFILE2

        cat $TMPFILE2 | sort > $i
        cat $TMPFILE1 | grep ^16 >> $i
    done
    
    rm -f $TMPFILE1 $TMPFILE2
done

