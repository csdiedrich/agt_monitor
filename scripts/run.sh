#!/bin/bash
/root/scripts/setup.sh
/etc/init.d/nagios-nrpe-server start
ssh root@nagios rm -f /opt/nagios/etc/objects/localhost.cfg
ssh root@nagios sed -i 's/cfg_file=\/opt\/nagios\/etc\/objects\/localhost.cfg/#cfg_file=\/opt\/nagios\/etc\/objects\/localhost.cfg/g' /opt/nagios/etc/nagios.cfg
ssh root@nagios /root/scripts/reload.sh
ping 8.8.8.8 > /dev/null
