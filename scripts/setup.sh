#!/bin/bash
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
/usr/bin/expect -c 'spawn ssh-copy-id root@nagios
expect "(yes/no)?"
send "yes\n"
expect "password:"
send "'$PWD_ROOT'\n"
expect eof'
ip=$(ip addr |grep eth0|grep -v UP|awk -F"/" '{print $1}'|awk '{print $2}'|head -1)
host=$(cat /etc/hostname)
ip_nagios=$(ping -c1 nagios|head -1|awk '{print $3}'|sed 's/(//g'|sed 's/)//g')
sed -i "s/IP/$ip/g" /opt/template.cfg
sed -i "s/HOSTNAME/$host/g" /opt/template.cfg
sed -i "s/IP_NAGIOS/$ip_nagios/g" /etc/nagios/nrpe.cfg
scp /opt/template.cfg root@nagios:/opt/nagios/etc/monitor/$host.cfg
