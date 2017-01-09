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
    php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupted'; unlink('composer-setup.php'); exit(1); } echo PHP_EOL;" &&\
    php composer-setup.php &&\
    php -r "unlink('composer-setup.php');"
RUN cd /var/www/html/corpus_shell &&\
    php composer.phar install
# expose and freeze for containers derived from this the corpus_shell setup
VOLUME /var/www/html

CMD ["/bin/bash", "-c", "source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND"]
EXPOSE 80

