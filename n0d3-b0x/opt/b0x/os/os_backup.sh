#!/bin/sh
#-------------------------------------------------------------------
#~ @(#) Name : os_backup.sh
#~ @(#) Desc : 
#~ @(#) version : 1.0
# Date : 2020-06-01
#-------------------------------------------------------------------
# Version history
# V1.0 [2020-06-01]
#-------------------------------------------------------------------
#~ Usage : os_backup.sh
#-------------------------------------------------------------------


SRC=$(dirname $0)
LOG=/tmp/$SRC

# Load _ENV_ params
. $SRC/_ENV_

echo "***** $(date) b0x backup *****" > $LOG 
rsync -aHv --delete-during --exclude-from=$SRC/$BACKUP_EXCLUDE_FILE / $BACKUP_PATH_DIR >> $LOG