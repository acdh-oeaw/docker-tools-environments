# Image for serving HTTP/PHP environment:
# Apache is running using the ITK module so
# --cap-add=SYS_NICE --cap-add=DAC_READ_SEARCH docker privileges are required
FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

RUN apt-get update && \
  apt-get install -y php5-cli libapache2-mod-php5 php-pear php5-pgsql php5-mysql php5-gd php5-recode php5-readline \
                     php5-json php5-curl php5-gmp php5-ldap php5-odbc php5-sqlite php5-xmlrpc php5-intl \
                     php5-xsl w3c-dtd-xhtml mysql-client && \
  apt-get clean

RUN mkdir -p /var/www/exec /var/www/config &&\
    chown www-data:www-data /var/www/exec /var/www/config

# Do not use VOLUME or EXPOSE in base_ containers. They are meant to be derived from.
# There is no posibility to alter these further down.

