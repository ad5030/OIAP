#!/bin/bash
#-------------------------------------------------------------------
#~ @(#) Name : b0x_security_update.sh
#~ @(#) Desc : 
#~ @(#) version : 1.0
# Date : 2020-06-01
#-------------------------------------------------------------------
# Version history
# V1.0 [2020-06-01]
#-------------------------------------------------------------------
#~ Usage : os_security_update.sh
#-------------------------------------------------------------------
sudo grep security /etc/apt/sources.list | tee /etc/apt/security.sources.list
sudo apt update
sudo apt upgrade -o Dir::Etc::SourceList=/etc/apt/security.sources.list
