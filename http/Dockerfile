FROM ubuntu:latest
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
  apt-get update && apt-get dist-upgrade -y && apt-get clean
# install software
RUN apt-get update && \
  apt-get install -y supervisor apache2 libapache2-mpm-itk links vim && \
  a2enmod rewrite && \
  a2enmod headers && \
  a2enmod proxy && \
  apt-get clean

# configure
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 80
