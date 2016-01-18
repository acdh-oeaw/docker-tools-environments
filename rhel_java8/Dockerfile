# Settings for using this as an environment
# Probably not useable for reuse in other containers
FROM acdh/base_rhel_java8
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

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