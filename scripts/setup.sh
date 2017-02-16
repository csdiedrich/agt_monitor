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
python /usr/lib/nagios/plugins/check_swarm managers > /dev/null 2>&1
if [ $? = 0 ]; then
  sed -i "s/IP/$ip/g" /opt/template_manager.cfg
  sed -i "s/HOSTNAME/$host/g" /opt/template_manager.cfg
  sed -i "s/IP_NAGIOS/$ip_nagios/g" /etc/nagios/nrpe.cfg
  sed -i "s/SERVICE/$SERVICE/g" /opt/template_manager.cfg
  scp /opt/template_manager.cfg root@nagios:/opt/nagios/etc/monitor/$host.cfg
else
  sed -i "s/IP/$ip/g" /opt/template_node.cfg
  sed -i "s/HOSTNAME/$host/g" /opt/template_node.cfg
  sed -i "s/IP_NAGIOS/$ip_nagios/g" /etc/nagios/nrpe.cfg
  sed -i "s/SERVICE/$SERVICE/g" /opt/template_node.cfg
  scp /opt/template_node.cfg root@nagios:/opt/nagios/etc/monitor/$host.cfg
fi
usermod nagios -s /bin/bash
