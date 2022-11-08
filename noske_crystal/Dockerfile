FROM centos:7
LABEL maintainer Omar.Siam@oeaw.ac.at


# bonito-www(-open) depends on httpd. It works with lighttpd of course but the package system requires something.
# This fake package was created using https://github.com/larsks/fakeprovide.git
# cronolog is a customized version that is able to gzip older log files.
COPY rpms/cronolog-1.7.2-105.7.x86_64.rpm \
     rpms/fakeprovide-httpd-20201030141639-1.el7.noarch.rpm \
     rpms/python3-openpyxl-2.6.2-6.el7.noarch.rpm \
     rpms/python3-prctl-1.8.1-3.20201109git.el7.x86_64.rpm \
     run_lighttpd.sh import_logs.py \
     lighttpd.conf add_auth.sh \
     run.cgi test-run.cgi \
     /rpms/
# for UI-customization: /usr/lib/python3.6/dist-packages/bonito will be mounted. Save it away.
# This was an ubuntu based image which has it's python packages in dist-packages
# The customized directory is mounted there hence it hast to be replicated here
RUN cd /rpms && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/bonito-open/bonito-open-5.58.1-1.el7.noarch.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-2.214.1-1.el7.x86_64.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-python3-2.214.1-1.el7.x86_64.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-static-2.214.1-1.el7.x86_64.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-susanne-2.214.1-1.el7.noarch.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/crystal-open/crystal-open-2.129.1-1.el7.noarch.rpm && \
    curl -LO https://corpora.fi.muni.cz/noske/current/centos7/gdex/gdex-4.12-1.el7.noarch.rpm && \
    cd / && \
    yum install -y epel-release && \
    yum update -y && \
    yum install -y lighttpd lighttpd-fastcgi python36-lxml && \
    mv /rpms/manatee-open-susanne-2.208-1.el7.noarch.rpm /root && \
    yum install -y ./rpms/* && \
    mv /rpms/run_lighttpd.sh /rpms/import_logs.py / && \
    mv /rpms/lighttpd.conf /rpms/add_auth.sh /etc/lighttpd/ && \
    mv /rpms/run.cgi /var/www/bonito/ && \
    mkdir -p /var/www/test/bonito/ && \
    mv /rpms/test-run.cgi /var/www/test/bonito/run.cgi && \
    rm -rf /rpms/ && \
    localedef -c -i en_IE -f UTF-8 en_IE.UTF-8; echo returned $? && \
    mkdir -p /var/www/test/bonito/ && \
    usermod -l www-data lighttpd && groupmod -n www-data lighttpd && \
    mkdir -p /usr/lib/python3.6/dist-packages && \
    mv /usr/lib/python3.6/site-packages/bonito /usr/lib/python3.6/dist-packages && \
    cp -a /usr/lib/python3.6/dist-packages/bonito /usr/lib/python3.6/site-packages/bonoto.init && \
    ln -s /usr/lib/python3.6/dist-packages/bonito /usr/lib/python3.6/site-packages/bonito && \
    mv /var/www/crystal /var/www/crystal.init && \
    yum install -y which && \
    yum install -y less vim && \
    yum clean all
## install some missing stuff: mandatory: which / comfort: less vi 

ENV MANATEE_REGISTRY=/var/lib/manatee/registry \
    HTTPD_ERROR_LOGFILE=/dev/fd/3 \
    HTTPD_ACCESS_LOGFILE="|/usr/sbin/cronolog -c -S /var/log/lighttpd/access.log /var/log/lighttpd/%Y-%m-%d-access.log" \
    LOGIDSITE=0 \
    HTPASSWD_FILE="" \
    CORPLIST="" \
    LANG="en_IE.UTF-8"
#@INJECT_USER@

USER root

RUN mkdir -p /tmp/lighttpd && chown www-data:www-data /tmp/lighttpd && \
    mkdir -p /var/lib/bonito/jobs && chown www-data:www-data /var/lib/bonito/jobs && \
    mkdir -p /var/lib/bonito/cache && chown www-data:www-data /var/lib/bonito/cache && \
    mkdir -p /var/cache/lighttpd/compress && chown www-data:www-data /var/cache/lighttpd/compress && \
    mkdir -p /var/www/crystal && chown www-data:www-data /var/www/crystal && \
    mkdir -p /var/lib/manatee/data && chown www-data:www-data /var/lib/manatee/data

USER www-data
WORKDIR /home/user
VOLUME /var/lib/manatee/registry /var/log/lighttpd /var/lib/manatee/data /var/lib/bonito
# optionally /var/www/crystal
EXPOSE 8080

HEALTHCHECK --timeout=1s \
  CMD curl -A "healthcheck" -f http://localhost:8080/bonito/run.cgi || exit 1
CMD ["/bin/sh", "/run_lighttpd.sh"]
