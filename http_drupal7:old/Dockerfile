FROM acdh/base_http_php
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

WORKDIR /var/www
RUN php -r "readfile('https://ftp.drupal.org/files/projects/drupal-7.42.tar.gz');" > drupal-7.42.tar.gz &&\
    php -r "if (hash('MD5', file_get_contents('drupal-7.42.tar.gz')) === '9a96f67474e209dd48750ba6fccc77db') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('drupal-7.42.tar.gz'); } echo PHP_EOL;"
RUN tar -xzf drupal-7.42.tar.gz && \
  rm -f drupal-7.42.tar.gz && \
  rm -fR html && \
  mv drupal-7.42 html && \
  chown -R www-data:www-data html

VOLUME /var/www/html
