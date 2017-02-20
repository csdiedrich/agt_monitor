FROM ubuntu
RUN apt-get update; apt-get install nagios-nrpe-server nagios-plugins sysstat bc expect openssh-client python-pip sudo -y
RUN pip install docker
COPY monitors/check_* /usr/lib/nagios/plugins/
RUN chmod +x -Rf /usr/lib/nagios/plugins/
ADD confs/nrpe.cfg /etc/nagios/nrpe.cfg
ADD confs/*.cfg /opt/
ADD confs/sudoers /etc/sudoers
RUN mkdir /root/scripts
COPY scripts/* /root/scripts/
RUN chmod +x /root/scripts/*
CMD ["/root/scripts/run.sh"]
