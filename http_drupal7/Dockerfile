FROM acdh/base_http_php
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

WORKDIR /var/www
RUN php -r "readfile('https://ftp.drupal.org/files/projects/drupal-7.43.tar.gz');" > drupal-7.43.tar.gz &&\
    php -r "if (hash('MD5', file_get_contents('drupal-7.43.tar.gz')) === 'c6fb49bc88a6408a985afddac76b9f8b') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('drupal-7.43.tar.gz'); } echo PHP_EOL;"
RUN tar -xzf drupal-7.43.tar.gz && \
  rm -f drupal-7.43.tar.gz && \
  rm -fR html && \
  mv drupal-7.43 html && \
  chown -R www-data:www-data html
RUN apt update && \
  apt-get install -y drush && \
  apt-get clean

VOLUME /var/www/html/sites/all /var/www/html/sites/default
