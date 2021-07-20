FROM centos:7
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

# install software
RUN yum -y update && \
  yum -y install epel-release && \
  yum -y install -y java-1.8.0-openjdk-headless \
                     supervisor elinks curl vim-enhanced nano locales && \
  yum clean all

# set up utf-8 locale (defaults to POSIX)
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 8000
EXPOSE 8080

#@INJECT_USER@

