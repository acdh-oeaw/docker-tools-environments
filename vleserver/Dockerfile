# Image for the server side RESTful API for VLE
FROM acdh/base_http_php
MAINTAINER Omar Siam <Omar.Siam@oeaw.ac.at>

RUN apt-get update && \
  apt-get install -y git && \
  apt-get clean
RUN rm -fv /var/www/html/*&&\
    rm -fv /var/www/exc/* && cd /var/www/exec &&\
    git clone https://github.com/acdh-oeaw/vleserver.git
RUN cd /var/www/exec/vleserver &&\
    php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php &&\
    php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupted'; unlink('composer-setup.php'); exit(1); } echo PHP_EOL;" &&\
    php composer-setup.php &&\
    php -r "unlink('composer-setup.php');"
RUN cd /var/www/exec/vleserver &&\
    php composer.phar install --no-dev --prefer-dist --optimize-autoloader &&\
    ln -s /var/www/exec/vleserver/public /var/www/html/resttest &&\
    ln -s /var/www/exec/vleserver/public /var/www/html/restutf8
# expose and freeze for containers derived from this the corpus_shell setup
VOLUME /var/www/html
VOLUME /var/www/exec

CMD ["/bin/bash", "-c", "source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND"]
EXPOSE 80
