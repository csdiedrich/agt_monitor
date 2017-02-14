#!/bin/bash
/root/scripts/setup.sh
/etc/init.d/nagios-nrpe-server start
ssh root@nagios '/root/scripts/reload.sh'
ping 8.8.8.8 > /dev/null
