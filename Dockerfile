FROM ubuntu
RUN apt-get update; apt-get install nagios-nrpe-server nagios-plugins sysstat bc -y
COPY check_* /usr/lib/nagios/plugins/
ADD nrpe.cfg /etc/nagios/nrpe.cfg
ADD setup.sh /setup.sh
RUN chmod +x /setup.sh
ADD run.sh /run.sh
CMD ["/run.sh"]
