# RHEL thinks they have to standardize on one and only one JDK that is _the_
# development platform. So with ant and maven openJDK 1.7.0 is pulled in
# Sets 1.7.0 as default, but 1.8.0 is still available.
FROM acdh/base_rhel_jdk7_8
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN alternatives --set java /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.91-2.6.2.3.el7.x86_64/jre/bin/java &&\
    alternatives --set javac /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.91-2.6.2.3.el7.x86_64/bin/javac

# set up utf-8 localed
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# expose
VOLUME /var/log
VOLUME /opt
EXPOSE 8443
EXPOSE 8080

COPY MinimalHTTP.jar /opt/start.jar

CMD ["/usr/bin/java", "-jar", "/opt/start.jar"]