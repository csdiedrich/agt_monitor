FROM ubuntu
RUN apt-get update; apt-get install nagios-nrpe-server nagios-plugins sysstat bc -y
COPY check_* /usr/lib/nagios/plugins/
ADD nrpe.cfg /etc/nagios/nrpe.cfg
ADD setup.sh /setup.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
CMD ["/run.sh"]
