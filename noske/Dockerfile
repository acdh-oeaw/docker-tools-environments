FROM ubuntu:12.04
MAINTAINER Omar.Siam@oeaw.ac.at

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

RUN sed 's/archive.ubuntu/at.archive.ubuntu/' /etc/apt/sources.list > /etc/apt/sources.at.list && \
    cp /etc/apt/sources.at.list /etc/apt/sources.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget python \
    libantlr3c-3.2-0 libltdl7 libpcre3 libpcre++ \
    python-cheetah python-simplejson \
    apache2 && \
    apt-get clean
RUN wget http://corpora.fi.muni.cz/noske/deb/1204/bonito-open/archive/bonito-open_3.48.9-1_all.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1204/bonito-open/archive/bonito-open-www_3.48.9-1_all.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1204/finlib/archive/finlib_2.28.2-1_amd64.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1204/manatee-open/archive/manatee-open-python_2.107.1-1ubuntu1_amd64.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1204/manatee-open/archive/manatee-open_2.107.1-1ubuntu1_amd64.deb && \
    dpkg --install *.deb && \
    locale-gen --lang en_US.UTF-8 && \
    mkdir /var/run/apache2 && \
    chown www-data:www-data /var/run/apache2 && \
    rm /var/www/bonito/.htaccess

VOLUME ["/usr/lib/python2.7/dist-packages/bonito"]
VOLUME ["/var/lib/manatee/registry"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
