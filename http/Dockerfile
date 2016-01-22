# we are using latest stable (vivid) instead of latest (which is latest LTS: 14.04)
FROM ubuntu:wily
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# install software
# enableing the ITK module is a little tricky (requires MPM event module to be
#   disabled first), so it takes 3 lines of code
RUN apt-get update && \
  apt-get install -y supervisor apache2 links vim && \
  a2dismod mpm_event && \
  apt-get install -y apache2-mpm-itk && \
  a2enmod rewrite && \
  apt-get clean

# configure
RUN /etc/init.d/apache2 start
RUN /etc/init.d/apache2 stop
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# expose
CMD ["/usr/bin/supervisord"]
RUN chmod -R +r /var/log/apache2 && \
  chmod +x /var/log/apache2
# do not expose volumes here as it breaks derived images!

