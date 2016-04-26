FROM acdh/base_http_php
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

WORKDIR /var/www
RUN php -r "readfile('https://ftp.drupal.org/files/projects/drupal-@VERSION@.tar.gz');" > drupal.tar.gz &&\
    php -r "if (hash('MD5', file_get_contents('drupal.tar.gz')) === '@HASH@') { echo 'Installer verified'; } else { echo 'Installer corrupted'; unlink('drupal.tar.gz'); } echo PHP_EOL;"
RUN tar -xzf drupal.tar.gz && \
  rm -f drupal.tar.gz && \
  rm -fR html && \
  mv drupal-@VERSION@ html && \
  chown -R www-data:www-data html
RUN apt update && \
  apt-get install -y drush && \
  apt-get clean

VOLUME /var/www/html/sites/all /var/www/html/sites/default
