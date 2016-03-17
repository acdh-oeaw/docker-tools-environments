FROM acdh/base_http_php
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

WORKDIR /var/www
RUN wget http://ftp.drupal.org/files/projects/drupal-7.41.tar.gz
RUN tar -xzf drupal-7.41.tar.gz && \
  rm -f drupal-7.41.tar.gz && \
  rm -fR html && \
  mv drupal-7.41 html && \
  chown -R www-data:www-data html

VOLUME /var/www/html
