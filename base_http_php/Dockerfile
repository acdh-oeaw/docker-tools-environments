# Image for serving HTTP/PHP environment:
# Apache is running using the ITK module so
# --cap-add=SYS_NICE --cap-add=DAC_READ_SEARCH docker privileges are required
FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

RUN apt update && apt full-upgrade -y && \
  apt-get install -y php7.0-cli libapache2-mod-php7.0 php-pear php7.0-pgsql php7.0-zip \
                     php7.0-mysql php7.0-gd php7.0-recode php7.0-readline php7.0-json \
                     php7.0-curl php7.0-gmp php7.0-ldap php7.0-odbc php7.0-sqlite \
                     php7.0-xmlrpc php7.0-intl php7.0-xsl php7.0-mbstring php-apcu \
                     php7.0-zip mysql-client w3c-sgml-lib composer && \
  apt-get clean

RUN mkdir -p /var/www/exec  /var/www/config &&\
    chown www-data:www-data /var/www/exec /var/www/config &&\
    sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 64M/' -e 's/post_max_size.*/post_max_size = 64M/' /etc/php/7.0/apache2/php.ini

# Do not use VOLUME or EXPOSE in base_ containers. They are meant to be derived from.
# There is no posibility to alter these in derived images.

