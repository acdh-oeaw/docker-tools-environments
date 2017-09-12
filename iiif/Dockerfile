FROM ubuntu:latest
MAINTAINER Dalibor Pancic <dalibor.pancic@oeaw.ac.at>

# Update packages
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
              apt-get update && apt-get dist-upgrade -y && apt-get clean

# Install tools
RUN apt-get install -y wget supervisor git unzip vim nano curl nginx memcached libfcgi0ldbl \
                       libmemcached11 libpng12-0 libtiff5 libjpeg-turbo-progs python-pip links tzdata locales && \
    apt-get clean

# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    USER=user \
    TERM=xterm

# Download and install IIIF Server for Ubuntu Xenial
RUN wget --no-verbose --no-check-certificate \
    -O iiifserver.deb \
    'http://downloads.klokantech.com/iiifserver/iiifserver-1.0.0-241.ubuntu-xenial.amd64.deb' \
    && dpkg -i iiifserver.deb \
    && rm iiifserver.deb \
    && rm -rf /etc/nginx/sites-enabled/iiifserver.conf \
    && rm -rf /etc/nginx/sites-available/iiifserver.conf \
    && sed -i 's|www-data|user|g' /etc/nginx/nginx.conf

# Copy configuration files for dropzone and iiifserver.conf

COPY iiifserver.conf /etc/nginx/sites-available/default
COPY dropzone.py /usr/bin/dropzone.py
COPY viewer.html /
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ENV TERM xterm
RUN chmod +x /usr/bin/dropzone.py && mkdir -p /dropzone /var/cache/nginx /logo /opt/logs  \
    && ln -s /var/log/nginx/error.log /opt/logs/nginx_error.log \
    && touch /var/run/nginx.pid

RUN chown -R $USER:$USER /usr/bin/dropzone.py /usr/bin/memcached /opt/logs \
    && chown -R $USER:$USER /var/www/html /usr/sbin/nginx /etc/nginx /var/lib/nginx /run /var/run/nginx.pid \
    && chown -R $USER:$USER /var/log/nginx /var/cache/nginx \
    && chown -R $USER:$USER /data /dropzone /usr/share/cgi-bin  /usr/share/iiifserver /viewer.html

# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 8080
