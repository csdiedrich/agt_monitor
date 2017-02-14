#!/bin/bash
/root/scripts/setup.sh
/etc/init.d/nagios-nrpe-server start
ping 8.8.8.8 > /dev/null
