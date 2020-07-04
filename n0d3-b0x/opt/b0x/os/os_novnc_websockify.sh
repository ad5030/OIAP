#!/bin/bash
#-------------------------------------------------------------------
#~ @(#) Name : os_novnc_websockify.sh
#~ @(#) Desc : check novnc_websockify service and start novnc_websockify if down
#~ @(#) version : 1.0
# Auteur : adm@di-marco.net
# Date : 2020-06-01
#-------------------------------------------------------------------
# Version history
# V1.0 [2020-06-01]
#-------------------------------------------------------------------
#~ Usage : os_novnc_websockify.sh
#-------------------------------------------------------------------

STATE_OK=0

_service=websockify

SCRIPT=`basename ${0}`

if [[ -z $_service ]]
then
	echo "< Error > Service $_service is empty or null"
	exit ${STATE_UNKNOWN}	
fi

nbPID=`ps -ef | grep ${_service} | grep -v grep | grep -v $SCRIPT | awk '{print $2}' | wc -l`

if [ $nbPID == 0 ]
then
	echo "< Ko > Service $_service is Down"
	/usr/bin/websockify -D --web=/usr/share/novnc/  6080 localhost:9000
	exit ${STATE_OK}
else
	echo "Service $_service is Up" 
	exit ${STATE_OK}
fi