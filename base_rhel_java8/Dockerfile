# use CentOS 7 for real long term support (planned EOL is not before end of 2020)
# RHEL is one of the maintainers of openJDK
FROM centos:7
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN yum update -y
RUN yum install -y supervisor java-1.8.0-openjdk-headless && \
    yum clean packages && yum clean expire-cache

# Do not use VOLUME or EXPOSE in base_ containers. They are meant to be derived from.
# There is no posibility to alter these further down.