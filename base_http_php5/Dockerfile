# Image for serving HTTP/PHP5 environment
#
# This configuration is DEPRECATED now and all services should be adapted to
# work with php7!
FROM ubuntu:trusty
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en


RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
  apt-get update && apt-get dist-upgrade -y && apt-get clean
# install softwares
# libapache2-mpm-itk requires mpm_event Apache module to be disabled first
# and it is not automatically done during the install so has to be done by hand
RUN apt-get update && \
  apt-get install -y supervisor apache2 apache2-utils links vim patch && \
  a2dismod mpm_event && \
  apt-get install -y libapache2-mpm-itk \
                     php5-cli libapache2-mod-php5 php-pear php5-pgsql \
                     php5-mysql php5-gd php5-recode php5-readline php5-json \
                     php5-curl php5-gmp php5-ldap php5-odbc php5-sqlite \
                     php5-xmlrpc php5-intl php5-xsl php5-apcu  \
                     mysql-client w3c-dtd-xhtml && \
  apt-get clean && \
  a2enmod rewrite && \
  a2enmod headers && \
  mkdir -p /var/www/exec /var/www/config &&\
  chown www-data:www-data /var/www/exec /var/www/config

COPY use-rotatelogs.patch /etc/apache2/
RUN cd /etc/apache2 && patch -p0 < use-rotatelogs.patch
COPY bzip2oldlog.sh /usr/local/bin/