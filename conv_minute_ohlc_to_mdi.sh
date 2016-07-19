#!/bin/bash

rm -f core*

# SOURCEDIR=/mnt/d/data/hkex/60m_ohlc_HSI/
SOURCEDIR=/mnt/d/data/kevin_maneki/maneki_bkt_data_5m_ohlc
# DESTDIR=/mnt/d/data/hkex/mdifmt_60m/
DESTDIR=/mnt/d/data/kevin_maneki/maneki_bkt_data
DATAPROC=/home/qy/Dropbox/nirvana/workspaceCN/DataProcessing/Debug/DataProcessing
TMPFILE=/tmp/conv_tmp                                                                                                                                                

SOURCEFILEFORMAT="CASH_OHLC"

rm -rf $DESTDIR
mkdir $DESTDIR

cd $SOURCEDIR
for i in *
do
    if [[ $SOURCEFILEFORMAT == "CASH_OHLC" ]]
    then
        cat $i | sed -e 's/_000000//' | tr '_' ',' > $TMPFILE
        $DATAPROC 237 $TMPFILE $DESTDIR/$i 4 f 0 1 8 t 9
        rm -f $TMPFILE
    else
        cat $SOURCEDIR/$i | tr '_' ',' > $TMPFILE
        $DATAPROC 237 $TMPFILE $DESTDIR/$i 5 f 0 1 9 t 10
        rm -f $TMPFILE
    fi
done





