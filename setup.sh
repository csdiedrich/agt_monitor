#!/bin/bash
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
/login.sh root@nagios
ip=$(ip addr |grep eth0|grep -v UP|awk -F"/" '{print $1}'|awk '{print $2}')
host=$(hostname)
sed -i 's/IP/$ip/g' /opt/template.cfg
sed -i 's/HOSTNAME/$host/g' /opt/template.cfg
scp /opt/template.cfg root@nagios:/opt/nagios/etc/monitor/$host.cfg
