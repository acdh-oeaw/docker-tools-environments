FROM ubuntu:latest
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list && \
  apt-get update && apt-get dist-upgrade -y && \
  apt-get install -y openjdk-8-jre-headless maven ant \
                     supervisor links curl vim nano locales && \
  apt-get clean

# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 8000
EXPOSE 8080
