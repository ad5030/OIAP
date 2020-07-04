#!/bin/sh
#-------------------------------------------------------------------
#~ @(#) Name : b0x_clean.sh
#~ @(#) Desc : 
#~ @(#) version : 1.0
# Auteur : adm@di-marco.net
# Date : 2020-06-01
#-------------------------------------------------------------------
# Version history
# V1.0 [2020-06-01]
#-------------------------------------------------------------------
#~ Usage : b0x_backup_script.sh
#-------------------------------------------------------------------
echo "***** $(date) b0x backup *****" > /backups.log 
rsync -aHv --delete-during --exclude-from=/opt/_b0x/sh/.b0x_backup_script_exclude.txt / /mnt/freebox/99_b0x/90_backup/ >> /backups.log 