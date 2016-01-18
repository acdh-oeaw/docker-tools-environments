# RHEL thinks they have to standardize on one and only one JDK that is _the_
# development platform. So with ant and maven openJDK 1.7.0 is pulled in
FROM acdh/base_rhel_java8
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN yum update -y
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel ant maven && \
    yum clean packages && yum clean expire-cache
