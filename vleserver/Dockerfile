# Image for the server side RESTful API for VLE
# Apache is running using the ITK module so
# --cap-add=SYS_NICE --cap-add=DAC_READ_SEARCH docker privileges are required
FROM ubuntu:xenial
MAINTAINER Omar Siam <Omar.Siam@oeaw.ac.at>

ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
  apt-get update && apt-get dist-upgrade -y && apt-get clean
RUN apt install -y apache2 apache2-utils libapache2-mpm-itk \
                 curl vim locales \
                 libapache2-mod-php php-cli php-pear php-pgsql \
                 php-mysql php-gd php-recode \
                 php-curl php-gmp php-ldap php-odbc php-sqlite3 \
                 php-xmlrpc php-xsl \
                 php-zip mysql-client w3c-sgml-lib git && \
  apt clean && \
  rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  a2enmod rewrite && \
  a2enmod headers && \
  a2enmod proxy && \
  a2enmod proxy_http && \
  sed -i -e 's/StartServers.*/StartServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf && \
  sed -i -e 's/MinSpareServers.*/MinSpareServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

RUN locale-gen en_US.UTF-8 && \
  mkdir -p /var/www/exec /var/www/config &&\
  chown www-data:www-data /var/www/exec /var/www/config &&\
  sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 64M/' -e 's/post_max_size.*/post_max_size = 64M/' /etc/php/7.0/apache2/php.ini

RUN rm -fv /var/www/html/*&&\
    rm -fv /var/www/exc/* && cd /var/www/exec &&\
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
    ln -s /var/www/exec/vleserver/public /var/www/html/restutf8
# expose and freeze for containers derived from this setup
VOLUME /var/www/html
VOLUME /var/www/exec

#@INJECT_USER@

CMD ["/bin/bash", "-c", "source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND"]
EXPOSE 80
