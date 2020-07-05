#!/bin/sh
#-------------------------------------------------------------------
#~ @(#) Name : os_cloudflare_dns_update.sh
#~ @(#) Desc : CloudFlare DNS Update
#~ @(#) version : 1.1
# Date : 2020-07-05
#-------------------------------------------------------------------
#~ Usage : os_cloudflare_dns_update.sh <interface> (ie :eth0, wwan0)
#-------------------------------------------------------------------

SCRIPT_NAME=`basename $0 .sh`
SRC=$(dirname $0)
HOST=`hostname -s`
TMP_FILE=/tmp/_$SCRIPT_NAME.txt
DATE=$(date +"%Y%m%d-%H-%M-%S")

ZoneID="<your cloudflare zone ID>" #cloudflare zone ID
DNSRecord="<your DNS Zone record ID>" #DNS Zone record ID
DNSName="<your DNS Zone name>" #DNS Zone name
Email="<your cloudflare email for login>" #cloudflare email used for login
APIKey="<your cloudflare API key>" #cloudflare API key

# Load _ENV_ params
. $SRC/_ENV_

if [ -f $TMP_FILE ];then
  read -a fields <<< `cat $TMP_FILE`
  _IP=${fields[0]} 
else 
  _IP="*.*.*.*"
fi

# Get public IP
IP=`curl --interface $1 http://ipecho.net/plain`
#IP="$(dig +short IP.opendns.com @resolver1.opendns.com)"

if  [[ "x$IP" = "x$_IP" ]]; then
  echo "-> public IP not change so do nothing"
else 
  echo "-> public IP are chage so PUT new public IP in cloudflare"
  jsonResponse=$(curl -s -X PUT https://api.cloudflare.com/client/v4/zones/${ZoneID}/dns_records/${DNSRecord} -H "Content-Type: application/json" -H "X-Auth-Email: ${Email}" -H "X-Auth-Key: ${APIKey}" -H "cache-control: no-cache" -d "{\"type\" : \"A\", \"name\" : \"${DNSName}\", \"content\" : \"${IP}\" }")
  isDNSUpdated=$(echo ${jsonResponse} | jq --raw-output '.success' )
  errorMessage=$(echo ${jsonResponse} | jq --raw-output '.errors[].message')
  echo $IP > $TMP_FILE
  # Check if the error message is empty or null 
  if [ -z "$errorMessage" ] || [ ! -n "$errorMessage" ]
  then
    errorMessage=$(echo ${jsonResponse} | jq --raw-output '.errors[].error_chain[].message')
  fi

  # if the DNS update failed for some reason, send an Apple iMessage
  if ! $isDNSUpdated
  then
    echo "-> response error by cloudflare API"
#    $SRC/ux_send_Message.sh $AppleID "<im>[${SCRIPT_NAME}][${DATE}][${HOST}][for zone: ${DNSName} is NOT UPDATED because: ${errorMessage}]"
    echo $_IP > $TMP_FILE
  fi
fi