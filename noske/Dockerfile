FROM centos:7
MAINTAINER Omar.Siam@oeaw.ac.at

RUN yum install -y epel-release && \
    yum install -y lighttpd lighttpd-fastcgi && \
    yum clean all

RUN curl -LO https://corpora.fi.muni.cz/noske/current/centos7/bonito-open/bonito4-open-4.24.6-1.el7.noarch.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-2.167.10-1.el7.x86_64.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-python-2.167.10-1.el7.x86_64.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-python3-2.167.10-1.el7.x86_64.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-static-2.167.10-1.el7.x86_64.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/crystal-open/crystal-open-2.14-1.el7.noarch.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/gdex/gdex-3.12-1.el7.noarch.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/rpm/centos7/python-prctl/python-prctl-1.6.1-4.20150909git.el7.centos.x86_64.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/rpm/centos7/python-signalfd/python-signalfd-0.1-5.el7.centos.x86_64.rpm

# bonito-www(-open) depends on httpd. It works with lighttpd of course but the package system requires something.
# This fake package was created using https://github.com/larsks/fakeprovide.git
COPY fakeprovide-httpd-20201030141639-1.el7.noarch.rpm /

#RUN ln -s /bin/true /usr/sbin/a2enmod && ln -s /bin/true /etc/init.d/apache2 && \
RUN yum install -y ./* && \
    rm *.rpm

RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8; echo returned $? && \
    mkdir -p /var/www/test/bonito/ && \
    usermod -l www-data lighttpd && groupmod -n www-data lighttpd && \
    mkdir -p /tmp/lighttpd && chown www-data:www-data /tmp/lighttpd && \
    mkdir -p /var/lib/bonito/jobs && chown www-data:www-data /var/lib/bonito/jobs && \
    mkdir -p /var/lib/bonito/cache && chown www-data:www-data /var/lib/bonito/cache && \
    mkdir -p /var/cache/lighttpd/compress && chown www-data:www-data /var/cache/lighttpd/compress
COPY lighttpd.conf /etc/lighttpd/
COPY run.cgi /var/www/bonito/
COPY test-run.cgi /var/www/test/bonito/run.cgi
# for UI-customization: /usr/lib/python2.7/dist-packages/bonito will be mounted. Save it away.
# This was am ubuntu based image which has it's python packages in dist-packages
# The customized directory is mounted there hence it hast to be replicated here
RUN mkdir -p /usr/lib/python2.7/dist-packages && \
    mv /usr/lib/python2.7/site-packages/bonito /usr/lib/python2.7/dist-packages && \
    cp -a /usr/lib/python2.7/dist-packages/bonito /usr/lib/python2.7/site-packages/bonoto.init && \
    ln -s /usr/lib/python2.7/dist-packages/bonito /usr/lib/python2.7/site-packages/bonito
COPY run_lighttpd.sh /
VOLUME /var/lib/manatee/registry /var/log/lighttpd /var/lib/manatee/data /var/lib/bonito
ENV MANATEE_REGISTRY=/var/lib/manatee/registry
EXPOSE 8080

HEALTHCHECK --timeout=1s \
  CMD curl -A "healthcheck" -f http://localhost:8080/bonito/run.cgi || exit 1

USER www-data
CMD ["/bin/sh", "/run_lighttpd.sh"]

#@INJECT_USER@