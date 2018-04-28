# Image for serving HTTP/PHP environment:
# Apache is running using the ITK module so
# --cap-add=SYS_NICE --cap-add=DAC_READ_SEARCH docker privileges are required
FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt full-upgrade -y && \
  apt install -y libapache2-mod-php php-cli php-pear php-pgsql php-zip \
                 php-mysql php-gd php-recode php-readline php-json \
                 php-curl php-gmp php-ldap php-odbc php-sqlite3 \
                 php-xmlrpc php-intl php-xsl php-mbstring php-apcu \
                 php-zip mysql-client w3c-sgml-lib composer && \
  apt clean && \
  ln -s /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata

RUN mkdir -p /var/www/exec /var/www/config &&\
    chown www-data:www-data /var/www/exec /var/www/config &&\
    sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 64M/' -e 's/post_max_size.*/post_max_size = 64M/' /etc/php/7.2/apache2/php.ini

#@INJECT_USER@

# Do not use VOLUME or EXPOSE in base_ containers. They are meant to be derived from.
# There is no posibility to alter these in derived images.

