# Image for serving dictionary sites and dictionary fcs endpoints
FROM acdh/base_http_php5
MAINTAINER Omar Siam <Omar.Siam@oeaw.ac.at>

RUN apt-get update && \
  apt-get install -y git && \
  apt-get clean
RUN rm -fv /var/www/html/* && cd /var/www/html &&\
    git clone https://github.com/acdh-oeaw/corpus_shell.git &&\
    cd corpus_shell &&\
    git submodule update --init xsl &&\
    git submodule update --init modules/utils-php &&\
    cd modules/utils-php &&\
    git submodule update --init vlib &&\
    cd ../.. &&\
    git submodule update --init modules/mysqlonsru &&\
    git submodule update --init modules/fcs-aggregator
RUN cd /var/www/html/corpus_shell &&\
    php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php &&\
    php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupted'; unlink('composer-setup.php'); exit(1); } echo PHP_EOL;" &&\
    php composer-setup.php &&\
    php -r "unlink('composer-setup.php');"
RUN cd /var/www/html/corpus_shell &&\
    php composer.phar install
# expose and freeze for containers derived from this the corpus_shell setup
VOLUME /var/www/html

CMD ["/bin/bash", "-c", "source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND"]
EXPOSE 80

