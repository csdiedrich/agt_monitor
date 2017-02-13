FROM ubuntu
RUN apt-get update; apt-get install nagios-nrpe-server nagios-plugins sysstat bc expect -y
COPY check_* /usr/lib/nagios/plugins/
ADD nrpe.cfg /etc/nagios/nrpe.cfg
ADD template.cfg /opt/template.cfg
RUN mkdir /root/scripts
COPY *.sh /root/scripts/
RUN chmod +x /root/scripts/*.sh
CMD ["/root/scripts/run.sh"]
