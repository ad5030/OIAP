#!/bin/bash
#-------------------------------------------------------------------
#~ @(#) Name : ux_CloudFlareDNSUpdate.sh
#~ @(#) Desc : CloudFlare DNS Update
#~ @(#) version : 1.1
# Auteur : adm@di-marco.net
# Date : 2019-07-28
#-------------------------------------------------------------------
# Version history
# V1.0 [2019-07-28] - Creation 
# V1.1 [2019-08-12] - Minor change 
#-------------------------------------------------------------------
#~ Usage : ux_CloudFlareDNSUpdate.sh interface
#-------------------------------------------------------------------

# Variable
SCRIPT_NAME=`basename $0 .sh`
SRC=$(dirname $0)
HOST=`hostname -s`
TMP_FILE=/tmp/_ux_CloudFlareDNSUpdate.txt
DATE=$(date +"%Y%m%d-%H-%M-%S")

AppleID='0652200101' # Apple ID used for send an iMessage
RouterIP='192.168.1.1' # IP address of the router 
ZoneID="81a5f96e1a3cf2d9e6d679dc50574b54" # cloudflare zone ID
DNSRecord="17648e0b725c06e509d37b988d972b8c" # DNS Zone record ID
DNSName="r2d2.di-marco.net" # DNS Zone name
Email="adm@di-marco.net" # cloudflare email used for login
APIKey="b0c2e4d99e99d3e91a2ed5536f7a7361ace1b" # cloudflare API key

if [ -f $TMP_FILE ];then
  read -a fields <<< `cat $TMP_FILE`
  _IP=${fields[0]} 
else 
  _IP="*.*.*.*"
fi

# Get public IP
IP=`curl --interface $1 http://ipecho.net/plain`
#IP=`curl -s -i -b -X POST -H 'Content-Type: application/json' -d '{"parameters":{}}' http://${RouterIP}/sysbus/NMC:getWANStatus | sed 's/.*"IPAddress":"//' | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n1`
#IP="$(dig +short IP.opendns.com @resolver1.opendns.com)"
if  [[ "x$IP" = "x$_IP" ]]; then
  echo "-> public IP not change so do nothing"
else 
  echo "-> public IP are chage so PUT new public IP in cloudflare"
#  jsonResponse=$(curl -s -X PUT https://api.cloudflare.com/client/v4/zones/${ZoneID}/dns_records/${DNSRecord} -H "Content-Type: application/json" -H "X-Auth-Email: ${Email}" -H "X-Auth-Key: ${APIKey}" -H "cache-control: no-cache" -d "{\"type\" : \"A\", \"name\" : \"${DNSName}\", \"content\" : \"${IP}\" }")
#  isDNSUpdated=$(echo ${jsonResponse} | jq --raw-output '.success' )
#  errorMessage=$(echo ${jsonResponse} | jq --raw-output '.errors[].message')
  echo $IP > $TMP_FILE
  # Check if the error message is empty or null 
#  if [ -z "$errorMessage" ] || [ ! -n "$errorMessage" ]
#  then
#    errorMessage=$(echo ${jsonResponse} | jq --raw-output '.errors[].error_chain[].message')
#  fi

  # if the DNS update failed for some reason, send an Apple iMessage
#  if ! $isDNSUpdated
#  then
#    echo "-> response error by cloudflare API"
#    $SRC/ux_send_Message.sh $AppleID "<im>[${SCRIPT_NAME}][${DATE}][${HOST}][for zone: ${DNSName} is NOT UPDATED because: ${errorMessage}]"
#    echo $_IP > $TMP_FILE
#  fi
fi
echo $IP