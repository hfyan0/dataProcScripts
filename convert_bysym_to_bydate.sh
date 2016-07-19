#!/bin/bash
TMPFILE=/tmp/rf_backup_qy/werpo
SRCFOLDER=/mnt/d/data/blmg/hkstk_bar_d1_bysym_adj_withdup/
DESTFOLDER=/mnt/d/data/blmg/hkstk_bar_d1_bydate_adj/

cat $SRCFOLDER/*csv | cut -c1-8  | sort | uniq | grep ^2010 -A 100000 > $TMPFILE

while IFS='' read -r line || [[ -n "$line" ]]; do
    DATESTR=$line
    cat $SRCFOLDER/*csv | grep ^$DATESTR | sort | uniq > $DESTFOLDER/$DATESTR.csv
done < "$TMPFILE"
