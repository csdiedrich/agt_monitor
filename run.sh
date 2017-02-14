#!/bin/bash
/root/scripts/setup.sh
/etc/init.d/nagios-nrpe-server start
ssh root@nagios 'ps -ef|grep nagios|awk "{print $2}"|xargs kill -9'
ping 8.8.8.8 > /dev/null
