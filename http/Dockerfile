FROM debian:stretch
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list && \
  apt-get update && apt-get dist-upgrade -y && \
  apt-get install -y supervisor apache2 apache2-utils libapache2-mpm-itk links curl vim locales && \
  a2enmod rewrite && \
  a2enmod headers && \
  a2enmod proxy && \
  a2enmod proxy_http && \
  apt-get clean && \
  sed -i -e 's/StartServers.*/StartServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf && \
  sed -i -e 's/MinSpareServers.*/MinSpareServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf

# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:ean

# configure
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 80

#@INJECT_USER@
