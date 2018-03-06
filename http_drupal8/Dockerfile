#@TEMPLATE
# This is a Dockerfile template
# It can not be build using "docker build" without parameterization which is done by docker-tools
# For this reason it makes no sense to derive anything from this image
FROM acdh/base_http_php
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

ENV PATH=$PATH:/var/www/vendor/drush/drush

WORKDIR /var/www
RUN php -r "readfile('https://ftp.drupal.org/files/projects/drupal-@VERSION@.tar.gz');" > drupal.tar.gz && \
    php -r "if (hash('MD5', file_get_contents('drupal.tar.gz')) === '@HASH@') { echo 'Installer verified'; } else { echo 'Installer corrupted'; unlink('drupal.tar.gz'); exit(1); } echo PHP_EOL;" && \
  tar -xzf drupal.tar.gz && \
  rm -f drupal.tar.gz && \
  rm -fR html && \
  mv drupal-@VERSION@ html && \
  chown -R www-data:www-data /var/www && \
  composer require drush/drush && \
  drush -y init && \
  apt-get update && \
  apt-get install -y curl git && \
  apt-get clean

COPY updateLibs.sh /usr/local/sbin/updateLibs.sh
VOLUME /var/www/html/sites /var/www/html/modules /var/www/html/themes /var/www/html/profiles /var/www/html/libraries

#@INJECT_USER@
