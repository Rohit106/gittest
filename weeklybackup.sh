#!/bin/bash
HOST="hostname"
PASSFILE="/home/nagios/pass.txt"
#DUMP="/usr/bin/mysqldump"
STORELOCAL="/mnt/bkp_app_db"
STOREREMOTE="/data/home/www-db-bkp"
mem="70"
memory_full=`free -om | grep Mem |while read nme tot used free rest ; do echo  $tot $used $free ; done`
tot_m=`echo $memory_full| cut -d" " -f1`
used_m=`echo $memory_full| cut -d" " -f2`
free_m=`echo $memory_full| cut -d" " -f3`
memory1=`expr $used_m \* 100`
memory=`expr $memory1 \/ $tot_m`

#$DUMP -uroot --events --all-databases | gzip -v > $STORELOCAL/$HOST.sql.gz
/usr/bin/sshpass -f $PASSFILE /usr/bin/rsync -av -e "ssh -p 22420" $STORELOCAL/$HOST.sql.gz nagios@X.X.X.X:$STOREREMOTE/$HOST/. > /tmp/backup.log
/usr/bin/sshpass -f $PASSFILE /usr/bin/rsync -av -e "ssh -p 22420" $STORELOCAL/www nagios@X.X.X.X:$STOREREMOTE/$HOST/. >> /tmp/backup.log
echo "Weeklly BackUP completed of $HOST on JaxtrSMS_Build" | mail -s "Weeklly incremental backup $HOST on build" xyz@gmail.com < /tmp/backup.log
echo "Memory_utilazation : $memory1 MB   Memory_utilazation : $memory%"
if
        [ "$memory" -gt "$mem" ]
        then
        echo 3 > /proc/sys/vm/drop_caches
fi

