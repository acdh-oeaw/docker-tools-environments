FROM ubuntu:wily
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
# openjdk-8-jre-headless/openjdk-8-jre/openjdk-8-jdk
RUN apt-get update && \
  apt-get install -y openjdk-8-jre-headless maven2 ant && \
  apt-get install -y supervisor links vim && \
  apt-get clean

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 8000
EXPOSE 8080
