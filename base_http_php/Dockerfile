# Image for serving HTTP/PHP environment:
# Apache is running using the ITK module so
# --cap-add=SYS_NICE --cap-add=DAC_READ_SEARCH docker privileges are required
FROM debian:bullseye
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt full-upgrade -y && \
  apt install -y supervisor apache2 apache2-utils libapache2-mpm-itk \
                 links curl vim locales \
                 libapache2-mod-php php-cli php-pear php-pgsql php-zip \
                 php-mysql php-gd php-recode php-readline php-json \
                 php-curl php-gmp php-ldap php-odbc php-sqlite3 \
                 php-xmlrpc php-intl php-xsl php-mbstring php-apcu \
                 php-zip php-yaml php-imagick mysql-client w3c-sgml-lib \
                 composer && \
  apt clean && \
  rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  a2enmod rewrite && \
  a2enmod headers && \
  a2enmod proxy && \
  a2enmod proxy_http && \
  sed -i -e 's/StartServers.*/StartServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf && \
  sed -i -e 's/MinSpareServers.*/MinSpareServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

RUN locale-gen en_US.UTF-8 && \
  mkdir -p /var/www/exec /var/www/config &&\
  chown www-data:www-data /var/www/exec /var/www/config &&\
  sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 64M/' -e 's/post_max_size.*/post_max_size = 64M/' /etc/php/7.4/apache2/php.ini

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
EXPOSE 80
#@INJECT_USER@

# Do not use VOLUME or EXPOSE in base_ containers. They are meant to be derived from.
# There is no posibility to alter these in derived images.

