# Image for the server side RESTful API for VLE
# Apache is running using the ITK module so
# --cap-add=SYS_NICE --cap-add=DAC_READ_SEARCH docker privileges are required
FROM php:7.1-apache
MAINTAINER Omar Siam <Omar.Siam@oeaw.ac.at>

ENV DEBIAN_FRONTEND=noninteractive

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

RUN mkdir -p /var/www/exec /var/www/config &&\
  chown www-data:www-data /var/www/exec /var/www/config &&\
  apt update && apt install -y git unzip

RUN rm -fv /var/www/html/* &&\
    rm -fv /var/www/exec/* && cd /var/www/exec &&\
    git clone https://github.com/acdh-oeaw/vleserver.git
RUN cd /var/www/exec/vleserver &&\
    php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php &&\
    EXPECTED_SIGNATURE=$(php -r "readfile('https://composer.github.io/installer.sig');") &&\
    php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '$EXPECTED_SIGNATURE') { echo 'Installer verified'; } else { echo 'Installer corrupted'; unlink('composer-setup.php'); exit(1); } echo PHP_EOL;" &&\
    php composer-setup.php &&\
    php -r "unlink('composer-setup.php');"
RUN cd /var/www/exec/vleserver &&\
    php composer.phar install --no-dev --prefer-dist --optimize-autoloader &&\
    ln -s /var/www/exec/vleserver/public /var/www/html/resttest &&\
    ln -s /var/www/exec/vleserver/public /var/www/html/restutf8 &&\
    echo "RewriteEngine On \
RewriteRule ^$ /restutf8 [L]" > /var/www/html/.htaccess &&\
    chown 33:33 /var/www/exec/vleserver/data/cache &&\
    a2enmod rewrite && \
    a2enmod headers && \
    a2enmod proxy && \
    a2enmod proxy_http
# expose and freeze for containers derived from this setup
VOLUME /var/www/html
VOLUME /var/www/exec

#@INJECT_USER@

WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
