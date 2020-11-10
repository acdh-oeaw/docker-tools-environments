FROM ubuntu:18.04
MAINTAINER Omar.Siam@oeaw.ac.at

RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils wget python \
    libltdl7 libpcre3 libpcre++ locales locales-all \
    python-cheetah python-simplejson \
    python3-dev \
    lighttpd bison make parallel && \
    apt-get clean

RUN wget https://corpora.fi.muni.cz/noske/deb/1804/bonito-open/bonito-open-www_3.116.13-1ubuntu1_all.deb && \
    wget https://corpora.fi.muni.cz/noske/deb/1804/bonito-open/bonito-open_3.116.13-1ubuntu1_all.deb && \
    wget https://corpora.fi.muni.cz/noske/deb/1804/manatee-open/manatee-open-python_2.167.8-1ubuntu1_amd64.deb && \
    wget https://corpora.fi.muni.cz/noske/deb/1804/manatee-open/manatee-open-python3_2.167.8-1ubuntu1_amd64.deb && \
    wget https://corpora.fi.muni.cz/noske/deb/1804/manatee-open/manatee-open_2.167.8-1ubuntu1_amd64.deb && \
    wget https://corpora.fi.muni.cz/noske/deb/1804/python-signalfd/python-signalfd_0.1-1ubuntu1_amd64.deb

# bonito-www(-open) depends on apache2. It works with lighttpd of course but the package system requires something.
COPY apache2-dummy_1.0_amd64.deb lighttpd_1.4.55-1ubuntu2_amd64.deb cronolog_1.7.2_amd64.deb /

RUN ln -s /bin/true /usr/sbin/a2enmod && ln -s /bin/true /etc/init.d/apache2 && \
    dpkg --install *.deb && \
    rm *.deb

RUN locale-gen --lang en_US.UTF-8 && \
    rm /var/www/bonito/.htaccess
# for UI-customization: /usr/lib/python2.7/dist-packages/bonito will be mounted. Save it away.
RUN cp -a /usr/lib/python2.7/dist-packages/bonito /usr/lib/python2.7/dist-packages/bonito.init
COPY lighttpd.conf /etc/lighttpd/
COPY add_auth.sh /etc/lighttpd/
COPY run_lighttpd.sh /
COPY run.cgi /var/www/bonito/
COPY test-run.cgi /var/www/bonito/test/run.cgi
EXPOSE 8080

HEALTHCHECK --timeout=1s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/run.cgi || exit 1

ENV MANATEE_REGISTRY=/var/lib/manatee/registry \
    HTTPD_ERROR_LOGFILE=/dev/fd/3 \
    HTTPD_ACCESS_LOGFILE="|/usr/bin/cronolog -c -S /var/log/lighttpd/access.log /var/log/lighttpd/%Y-%m-%d-access.log" \
    LOGIDSITE=0 \
    HTPASSWD_FILE="" \
    CORPLIST=""
#@INJECT_USER@

USER root

RUN mkdir -p /tmp/lighttpd && chown www-data:www-data /tmp/lighttpd && \
    mkdir -p /var/lib/bonito/jobs && chown www-data:www-data /var/lib/bonito/jobs && \
    mkdir -p /var/lib/bonito/cache && chown www-data:www-data /var/lib/bonito/cache && \
    mkdir -p /var/cache/lighttpd/compress && chown www-data:www-data /var/cache/lighttpd/compress

USER www-data
VOLUME /var/lib/manatee/registry /var/log/lighttpd /var/lib/manatee/data /var/lib/bonito
CMD ["/bin/sh", "/run_lighttpd.sh"]
