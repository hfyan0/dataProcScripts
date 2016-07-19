#!/bin/bash

SOURCEFILE=/mnt/d/data/hkex/HSI_D1_ohlc.csv
DESTFILE=/mnt/d/data/hkex/HSI_D1_mdi.csv
TMPFILE=/tmp/conv_daily_ohlc
SYMBOL=HSI

rm -f $TMPFILE

cat $SOURCEFILE | awk -F, -v sym=$SYMBOL 'BEGIN{OFS=","}{dat=$1; sub(/-/, "", dat); sub(/-/, "", dat);  print dat"_092000_000000",sym,$3,100,"B",$3,100,999999,100,999999,100,999999,100,999999,100,"A",$3,100,999999,100,999999,100,999999,100,999999,100; }' >> $TMPFILE
cat $SOURCEFILE | awk -F, -v sym=$SYMBOL 'BEGIN{OFS=","}{dat=$1; sub(/-/, "", dat); sub(/-/, "", dat);  print dat"_155600_000000",sym,$4,100,"B",$4,100,999999,100,999999,100,999999,100,999999,100,"A",$4,100,999999,100,999999,100,999999,100,999999,100; }' >> $TMPFILE
cat $SOURCEFILE | awk -F, -v sym=$SYMBOL 'BEGIN{OFS=","}{dat=$1; sub(/-/, "", dat); sub(/-/, "", dat);  print dat"_155700_000000",sym,$5,100,"B",$5,100,999999,100,999999,100,999999,100,999999,100,"A",$5,100,999999,100,999999,100,999999,100,999999,100; }' >> $TMPFILE
cat $SOURCEFILE | awk -F, -v sym=$SYMBOL 'BEGIN{OFS=","}{dat=$1; sub(/-/, "", dat); sub(/-/, "", dat);  print dat"_155800_000000",sym,$6,100,"B",$6,100,999999,100,999999,100,999999,100,999999,100,"A",$6,100,999999,100,999999,100,999999,100,999999,100; }' >> $TMPFILE

cat $TMPFILE | sort > $DESTFILE

rm -f $TMPFILE
