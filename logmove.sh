#!/bin/bash 

#FROMDIR="/usr/local/tomcat/apache-tomcat-7.0.27/logs/"
#TODIR="/home/nocahd/backuplog/tomcat/"
#PASSFILE="/home/nocahd/pass.txt"

FROMDIR="/tmp/"
TODIR="/home/"


## Login info ##
foldername=$(date +'%d-%m-%Y')
#`mkdir -p  /home/nocahd/backuplog/tomcat/"$foldername"`
`mkdir -p  /home/"$foldername"`
cd "$FROMDIR"


find virtual-* -mtime +1  -exec cp -r -a -p {} $TODIR$foldername \;

#echo $TODIR$foldername
#cd $TODIR ;zip -r $foldername.zip $foldername ; cd

#/usr/bin/rsync -av -e "ssh -p 22420" $TODIR$foldername.zip root@X.X.X.X:/usr/local/jaxtrsim-log-bkup/rtbmslog/. >> /tmp/backup.log

#if ( $TODIR$foldername == $foldername) 
#  echo "Backup" | mail -s "Backup rtbms old +1day log from X.X.X.X copied to backup server X.X.X.X" xyz@gmail.com < /tmp/backup.log


