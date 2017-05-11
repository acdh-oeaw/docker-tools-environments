FROM acdh/http_wsgi2
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
    apt-get update && apt-get dist-upgrade -y && apt-get clean
RUN apt install -y wget git nodejs npm libltdl7 redis-server libxml2-dev libxslt-dev python-dev && apt-get clean &&\
    ln -s /usr/bin/nodejs /usr/bin/node &&\
    update-ca-certificates -f
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN cd /opt &&\
    git clone --verbose --progress https://github.com/czcorpus/kontext.git &&\
    npm install -g grunt &&\
    wget http://corpora.fi.muni.cz//noske/deb/1604/finlib/archive/finlib_2.35.2-1_amd64.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1604/manatee-open/archive/manatee-open-python_2.137.2-1ubuntu1_amd64.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1604/manatee-open/archive/manatee-open_2.137.2-1ubuntu1_amd64.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/antlr3c/libantlr3c_3.4-1_amd64.deb && \
    wget http://corpora.fi.muni.cz/noske/deb/1604/python-signalfd/python-signalfd_0.1-1ubuntu1_amd64.deb && \
    dpkg --install *.deb &&\
    mkdir -p /tmp/calc-pids &&\
    mkdir -p /tmp/kontext-upload &&\
    mkdir -p /var/lib/manatee/registry &&\
    mkdir -p /var/lib/manatee/corpora/subcorp &&\
    mkdir -p /var/lib/manatee/corpora/freqs-cache &&\
    mkdir -p /var/lib/manatee/corpora/freqs-precalc &&\
    mkdir -p /var/lib/manatee/corpora/colls-cache &&\
    chown -R www-data:www-data /tmp/kontext-upload &&\
    chown -R www-data:www-data /tmp/calc-pids &&\
    chown -R www-data:www-data /var/lib/manatee/*
RUN cd /opt/kontext &&\
    pip install -r requirements.txt &&\
    npm install
COPY conf/* /opt/kontext/conf/
RUN cd /opt/kontext &&\
    grunt production &&\
    cp -r cmpltmpl conf lib locale package.json public scripts worker.py /var/www/html
VOLUME /var/lib/manatee/registry /var/lib/manatee/data
ENV MANATEE_REGISTRY=/var/lib/manatee/registry