#!/bin/bash

# Disable IPv6 Networking - Turn Off IPv6
echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.d/90-disable-ipv6.conf
sysctl -p -f /etc/sysctl.d/90-disable-ipv6.conf

# Avoid Using FTP, Telnet, and Rlogin / Rsh services on Linux
sudo apt-get --purge remove xinetd nis yp-tools tftpd atftpd tftpd-hpa telnetd rsh-server rsh-redone-server

# Disable root Login
## Remove the root password
sudo passwd -d root
## Lock the account
sudo passwd -l root

