FROM acdh/base_existdb
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

# Inject config, fix problems
COPY build-config.diff /opt/exist-build-config.diff
RUN cd /opt/exist && \
    git checkout eXist-3.0.RC1 &&\
    patch -p1 < ../exist-build-config.diff && ./build.sh
# remove unsupported and/or unneeded packages not needed for running existdb
RUN apt remove -y --purge links supervisor ant maven openjdk-8-jdk &&\
    apt autoremove -y --purge
# customize config
RUN cd /opt/exist && \
    mkdir -p /var/log/exist &&\
    mkdir -p /data &&\
    mv /opt/exist/autodeploy /opt/exist/autodeploy.init &&\
    rm -rf tools/wrapper/logs &&\
    ln -s /var/log/exist tools/wrapper/logs &&\
    rm -rf tools/jetty/logs &&\
    ln -s /var/log/exist tools/jetty/logs &&\
    rm -rf webapp/WEB-INF/logs &&\
    ln -s /var/log/exist webapp/WEB-INF/logs &&\
    mkdir -p /opt/exist/tools/jetty/tmp &&\
    chmod a+rwx /opt/exist/tools/jetty/tmp &&\
    chgrp users /opt/exist/tools/jetty/tmp &&\
    # git error: wrapper is not executable
    chmod a+x /opt/exist/tools/wrapper/bin/wrapper-linux-x86-64

COPY wrapper.sh /opt/exist/tools/wrapper/bin/wrapper.sh
RUN chmod a+x /opt/exist/tools/wrapper/bin/wrapper.sh

#@INJECT_USER@

CMD ["/opt/exist/tools/wrapper/bin/wrapper.sh", "/opt/exist/tools/wrapper/conf/wrapper.conf", "wrapper.syslog.ident=exist", "wrapper.name=exist", "wrapper.displayname=eXist db 3.0 RC1", "wrapper.daemonize=FALSE"]
# We use runtime configuration for that for now.
# VOLUME /var/log/exist /opt/exist/webapp/WEB-INF/data /opt/exist/autodeploy
# EXPOSE 8080 8443
