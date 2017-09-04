FROM ubuntu:latest
MAINTAINER Dalibor Pancic <dalibor.pancic@oeaw.ac.at>

# Update packages
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
              apt-get update && apt-get dist-upgrade -y && apt-get clean

ENV USER user

# Install tools
RUN apt-get install -y wget supervisor git unzip vim nano curl nginx memcached libfcgi0ldbl \
                       libmemcached11 libpng12-0 libtiff5 libjpeg-turbo-progs python-pip links tzdata locales && \
    apt-get clean


# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Download and install IIIF Server for Ubuntu Xenial
RUN wget --no-verbose --no-check-certificate \
    -O iiifserver.deb \
    'http://downloads.klokantech.com/iiifserver/iiifserver-1.0.0-241.ubuntu-xenial.amd64.deb' \
&& dpkg -i iiifserver.deb \
&& rm iiifserver.deb \
&& rm -rf /etc/nginx/sites-enabled/iiifserver.conf \
&& rm -rf /etc/nginx/sites-available/iiifserver.conf 

# Copy configuration files for dropzone and iiifserver.conf
COPY iiifserver.conf /etc/nginx/sites-available/default
COPY dropzone.py /usr/bin/dropzone.py
RUN chmod +x /usr/bin/dropzone.py && mkdir -p /dropzone /logo

COPY viewer.html /

# Configure Nginx
RUN sed -i 's|www-data|user|g' /etc/nginx/nginx.conf 
ENV TERM xterm
# Configuration for supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


VOLUME /data/ /dropzone/ /var/log

# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 80

