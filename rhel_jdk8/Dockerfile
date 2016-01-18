# use CentOS 7 for real long term support (planned EOL is not before end of 2020)
# RHEL is one of the maintainers of openJDK
FROM centos:7
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN yum update -y
RUN yum install -y supervisor java-1.8.0-openjdk-headless && \
    yum clean packages && yum clean expire-cache

# set up utf-8 localed
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# expose
VOLUME /var/log
VOLUME /opt
EXPOSE 8443
EXPOSE 8080

COPY MinimalHTTPexample/MinimalHTTP.jar /opt/start.jar

CMD ["/usr/bin/java", "-jar", "/opt/start.jar"]