# Image for serving HTTP/PHP environment:
# Apache is running using the ITK module so
# --cap-add=SYS_NICE --cap-add=DAC_READ_SEARCH docker privileges are required
FROM acdh/http_php5
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
    php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '7228c001f88bee97506740ef0888240bd8a760b046ee16db8f4095c0d8d525f2367663f22a46b48d072c816e7fe19959') { echo 'Installer verified'; } else { echo 'Installer corrupted'; unlink('composer-setup.php'); exit(1); } echo PHP_EOL;" &&\
    php composer-setup.php &&\
    php -r "unlink('composer-setup.php');"
RUN cd /var/www/html/corpus_shell &&\
    php composer.phar install
# expose and freeze for containers derived from this the corpus_shell setup
VOLUME /var/www/html

