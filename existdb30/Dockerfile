FROM acdh/java8
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
    apt update && apt full-upgrade -y
RUN apt install -y openjdk-8-jdk git patch
RUN cd /opt && git clone --verbose --progress https://github.com/eXist-db/exist.git && cd exist && git checkout eXist-3.0.RC1
COPY build-config.diff /opt/exist/build-config.diff
RUN cd /opt/exist && patch -p1 < build-config.diff && ./build.sh && mkdir -p /var/log/exist && mkdir /data
RUN cd /opt/exist &&\
 rm -rf tools/wrapper/logs &&\
 ln -s /var/log/exist tools/wrapper/logs &&\
 rm -rf tools/jetty/logs &&\
 ln -s /var/log/exist tools/jetty/logs &&\
 rm -rf webapp/WEB-INF/logs &&\
 ln -s /var/log/exist webapp/WEB-INF/logs &&\
 mkdir /opt/exist/tools/jetty/tmp &&\
 chmod g+w /opt/exist/tools/jetty/tmp &&\
 chgrp users /opt/exist/tools/jetty/tmp &&\
 mv /opt/exist/autodeploy /opt/exist/autodeploy.init
COPY wrapper.sh /opt/exist/tools/wrapper/bin/wrapper.sh
# git error: wrapper is not executable
RUN chmod a+x /opt/exist/tools/wrapper/bin/wrapper-linux-x86-64
RUN chmod a+x /opt/exist/tools/wrapper/bin/wrapper.sh
RUN chmod a+rwx /opt/exist/tools/jetty/tmp
CMD ["/opt/exist/tools/wrapper/bin/wrapper.sh", "/opt/exist/tools/wrapper/conf/wrapper.conf", "wrapper.syslog.ident=exist", "wrapper.name=exist", "wrapper.displayname=eXist db 3.0 RC1", "wrapper.daemonize=FALSE"]
# We use runtime configuration for that for now.
# VOLUME /var/log/exist /opt/exist/webapp/WEB-INF/data /opt/exist/autodeploy
# EXPOSE 8080 8443
