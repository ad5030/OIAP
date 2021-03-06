#!/bin/bash
#-------------------------------------------------------------------
#~ @(#) Name : os_ipset_update.sh
#~ @(#) Desc : Update the ipset that iptables references for allowing based on country.
# Takes 2 parameters: ipset name (no spaces), country name e.g. 'Australia', 'france' ...
# iptables should have an existing '--match-set' rule e.g
#  $ iptables -I INPUT -p tcp --dport 22 -m set --match-set australia4 src -j ACCEPT
#  $ ip6tables -I INPUT -p tcp --dport 22 -m set --match-set australia6 src -j ACCEPT
#~ @(#) version : 1.0
# Auteur : adm@di-marco.net
# Date : 2020-02-01
#-------------------------------------------------------------------
# Version history
# V1.0 [2020-02-01] 
#-------------------------------------------------------------------
#~ Usage : os_ipset_update.sh whitelist <country>
#-------------------------------------------------------------------

SRC=$(dirname $0)

# Load _ENV_ params
. $SRC/_ENV_

CHANGELOG="/var/log/ipset_changes.log"
IPSET="/usr/sbin/ipset"
GEOIP_URL="https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country-CSV&license_key=${GEOIP_LICENSE_KEY}&suffix=zip"

IPSET_UP_RULES="/etc/ipset.up.rules"
IPTABLES_UP_RULES="/etc/iptables.up.rules"

# Load _ENV_ params
. $SRC/_ENV_

if [ $# -ne 2 ]; then
    echo "Usage $0 <ipset name> <country>"
    exit
fi

SETNAME=$1
COUNTRY=$2
TMPDIR=/tmp/$$_tmp
GEOIP_FILE=${TMPDIR}/$$_geoip.zip
CIDR_FILE=${TMPDIR}/$$_${SETNAME}_CIDR.zone
mkdir -p $TMPDIR

function fail {
    echo "FAILED: "$1
        cleanup
    exit 1
}

function cleanup {
	rm -rf $TMPDIR
}

cd $TMPDIR

[ $? -ne 0 ] && fail "Problem using tmp directory $TMPDIR"
curlout=`/bin/curl $GEOIP_URL -o $GEOIP_FILE 2>&1`
[ $? -ne 0 ] && fail "Problem downloading GeoIP database: $curlout"
unzip -q $GEOIP_FILE
cd GeoLite2-Country-CSV*

GEOID=`egrep -i "${COUNTRY}" GeoLite2-Country-Locations-en.csv | cut -f1 -d,`
[ $? -ne 0 ] && fail "$COUNTRY not found in GeoIP file"
for IPvX in 4 6; do
	SET=${SETNAME}${IPvX}
	grep $GEOID GeoLite2-Country-Blocks-IPv${IPvX}.csv | cut -f1 -d, > $CIDR_FILE
    if [ "$IPvX" -eq "4" ]; then
        # Add all locahost Address
        echo 127.0.0.0/8 >> $CIDR_FILE
        # Add all IPv4 Private Address
        echo 10.0.0.0/8 >> $CIDR_FILE
        echo 172.16.0.0/12 >> $CIDR_FILE
        echo 192.168.0.0/16 >> $CIDR_FILE
    
        $IPSET -exist create ${SET} hash:net family inet
        $IPSET create ${SET}-tmp hash:net family inet
    else
        $IPSET -exist create ${SET} hash:net family inet6
        $IPSET create ${SET}-tmp hash:net family inet6
    fi
    [ $? -ne 0 ] && fail "Problem creating tmp ipset"
    while read line; do
    $IPSET add ${SET}-tmp $line;
            [ $? -ne 0 ] && fail "Problem updating tmp ipset"
    done < $CIDR_FILE

    # Check for changes
    if [ -n $CHANGELOG ]; then
        $IPSET save ${SET} > ${TMPDIR}/$$_${SET}.ipset
        $IPSET save ${SET}-tmp > ${TMPDIR}/$$_${SET}-tmp.ipset
        echo `date`": Processing $COUNTRY..." >> $CHANGELOG
        echo `wc -l $CIDR_FILE | cut -f1 -d' '`" blocks loaded" >> $CHANGELOG
                diffout=`diff ${TMPDIR}/$$_${SET}.ipset ${TMPDIR}/$$_${SET}-tmp.ipset`
        if [ $? -ne 0 ]; then 
            echo $diffout >> $CHANGELOG
        else
            echo "No changes" >> $CHANGELOG
        fi
        echo >> $CHANGELOG
    fi

    # Flush ipset whitelist hashmap
    $IPSET flush $COUNTRY  > /dev/null
    $IPSET flush $SETNAME  > /dev/null

    $IPSET swap ${SET}-tmp $SET
        [ $? -ne 0 ] && fail "Problem updating live ipset"
    $IPSET destroy ${SET}-tmp
        [ $? -ne 0 ] && fail "Problem destroying tmp ipset"
done

cleanup

# Update rules and persit at reboot
cp ${IPSET_UP_RULES} ${IPSET_UP_RULES}.save
$IPSET save > ${IPSET_UP_RULES}

cp ${IPTABLES_UP_RULES} ${IPTABLES_UP_RULES}.save
cat <<EOF >${IPTABLES_UP_RULES}
# Generated by $0 on $(date)
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:LOGGING - [0:0]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -m set ! --match-set ${1}4 src -j DROP
COMMIT
# Completed on $(date)
EOF

exit 0