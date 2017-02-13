#!/bin/bash
/etc/init.d/nagios-nrpe-server start
ping 8.8.8.8 > /dev/null
