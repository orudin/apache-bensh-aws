#!/bin/bash
apt -y update
apt -y install apache2-utils
echo -ne "
* soft nofile 65536
* hard nofile 65536
" >>/etc/security/limits.conf
reboot 0