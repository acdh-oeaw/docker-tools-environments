# Image for serving HTTP/PHP5 environment
#
# This configuration is DEPRECATED now and all services should be adapted to
# work with php7!
FROM ubuntu:focal
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
  apt-get update && apt-get dist-upgrade -y && apt-get install -y gnupg2 && apt-get clean
# install softwares
# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)
COPY ondrej-ubuntu-php-bionic.list /etc/apt/sources.list.d/
COPY ondrej-ppa.asc .
RUN apt-key add ondrej-ppa.asc &&\
  apt-get update && \
  apt-get install -y supervisor apache2 apache2-utils links vim patch locales && \
  locale-gen en_US.UTF-8 && \
  apt-get install -y \
                     php5.6-cli libapache2-mod-php5.6 php-pear php5.6-pgsql \
                     php5.6-mysql php5.6-gd php5.6-recode php5.6-readline php5.6-json \
                     php5.6-curl php5.6-gmp php5.6-ldap php5.6-odbc php5.6-sqlite \
                     php5.6-xmlrpc php5.6-intl php5.6-mbstring php5.6-xsl php5.6-apcu  \
                     php5.6-zip mysql-client w3c-sgml-lib p7zip && \
  apt-get clean && \
  a2enmod rewrite && \
  a2enmod headers && \
  mkdir -p /var/www/exec /var/www/config &&\
  chown www-data:www-data /var/www/exec /var/www/config

COPY use-rotatelogs.patch /etc/apache2/
RUN cd /etc/apache2 && patch -p0 < use-rotatelogs.patch
COPY bzip2oldlog.sh /usr/local/bin/