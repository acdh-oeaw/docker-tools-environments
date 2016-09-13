#@TEMPLATE
# This is a Dockerfile template
# It can not be build using "docker build" without parameterization which is done by docker-tools
# For this reason it makes no sense to derive anything from this image
FROM acdh/base_http_php
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

WORKDIR /var/www
RUN php -r "readfile('https://ftp.drupal.org/files/projects/drupal-@VERSION@.tar.gz');" > drupal.tar.gz && \
    php -r "if (hash('MD5', file_get_contents('drupal.tar.gz')) === '@HASH@') { echo 'Installer verified'; } else { echo 'Installer corrupted'; unlink('drupal.tar.gz'); exit(1); } echo PHP_EOL;"
RUN tar -xzf drupal.tar.gz && \
  rm -f drupal.tar.gz && \
  rm -fR html && \
  mv drupal-@VERSION@ html && \
  chown -R www-data:www-data html
RUN php -r "readfile('http://files.drush.org/drush.phar');" > drush && \
  chmod +x drush && \
  mv drush /usr/local/bin
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
  php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupted' . PHP_EOL; exit(1); } echo PHP_EOL;" && \
  php composer-setup.php --install-dir /usr/bin --filename composer && \
  rm composer-setup.php
RUN apt-get update && \
  apt-get install -y curl && \
  apt-get clean

VOLUME /var/www/html/sites /var/www/html/modules /var/www/html/themes /var/www/html/profiles /var/www/html/libraries
