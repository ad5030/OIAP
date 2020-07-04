#!/bin/bash
#-------------------------------------------------------------------
#~ @(#) Name : b0x_di-marco_net.sh
#~ @(#) Desc : 
#~ @(#) version : 1.0
# Auteur : adm@di-marco.net
# Date : 2020-06-01
#-------------------------------------------------------------------
# Version history
# V1.0 [2020-06-01]
#-------------------------------------------------------------------
#~ Usage : b0x_di-marco_net.sh
#-------------------------------------------------------------------

curl --insecure --cert  /etc/pki/c3po_user.pem:37clt38 -u "AD:37clt38" "https://n0d3.di-marco.net/cert/chain.pem" > /etc/nginx/snippets/chain.pem
curl --insecure --cert  /etc/pki/c3po_user.pem:37clt38 -u "AD:37clt38" "https://n0d3.di-marco.net/cert/cert.pem" > /etc/nginx/snippets/cert.pem
curl --insecure --cert  /etc/pki/c3po_user.pem:37clt38 -u "AD:37clt38" "https://n0d3.di-marco.net/cert/fullchain.pem" > /etc/nginx/snippets/fullchain.pem
curl --insecure --cert  /etc/pki/c3po_user.pem:37clt38 -u "AD:37clt38" "https://n0d3.di-marco.net/cert/privkey.pem" > /etc/nginx/snippets/privkey.pem

sudo systemctl stop nginx ; sudo systemctl start nginx