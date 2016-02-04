FROM ubuntu:12.04
MAINTAINER Omar.Siam@oeaw.ac.at

RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python-software-properties &&\
    apt-add-repository -y ppa:esteve/upfmipal && \
    DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget python \
    libantlr3c-3.2-0 libltdl7 libpcre3 libpcre++ \
    python-cheetah python-simplejson \
    lighttpd && \
    apt-get clean
RUN wget http://corpora.fi.muni.cz/noske/deb/1204/bonito-open/archive/bonito-open_3.48.9-1_all.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1204/bonito-open/archive/bonito-open-www_3.48.9-1_all.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1204/finlib/archive/finlib_2.28.2-1_amd64.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1204/manatee-open/archive/manatee-open-python_2.107.1-1ubuntu1_amd64.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1204/manatee-open/archive/manatee-open_2.107.1-1ubuntu1_amd64.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1204/python-signalfd/python-signalfd_0.1-1ubuntu1_amd64.deb
# bonito-www(-open) depends on apache2. It works with lighttpd of course but the package system requires something.
COPY apache2-dummy_1.0_amd64.deb /
RUN ln -s /bin/true /usr/sbin/a2enmod && ln -s /bin/true /etc/init.d/apache2 && \
    dpkg --install *.deb && \
    rm *.deb
RUN locale-gen --lang en_US.UTF-8 && \
    ln -s /usr/lib/x86_64-linux-gnu/libantlr3c-3.4.so.0 /usr/lib/x86_64-linux-gnu/libantlr3c.so && \
    rm /var/www/bonito/.htaccess && \
    mkdir -p /tmp/lighttpd && chmod a+rwx /tmp/lighttpd && chmod a+rwx /var/log/lighttpd && \
    mkdir -p /var/lib/bonito/jobs && chmod a+rwx /var/lib/bonito/jobs &&\
    mkdir -p /var/lib/bonito/cache && chmod a+rwx /var/lib/bonito/cache
COPY lighttpd.conf /etc/lighttpd/
# for UI-customization: /usr/lib/python2.7/dist-packages/bonito will be mounted. Save it away.
RUN cp -a /usr/lib/python2.7/dist-packages/bonito /usr/lib/python2.7/dist-packages/bonito.init
COPY run_lighttpd.sh /
VOLUME /var/lib/manatee/registry /var/log/lighttpd /var/lib/manatee/data /var/lib/bonito
EXPOSE 8080
CMD ["/bin/sh", "/run_lighttpd.sh"]
