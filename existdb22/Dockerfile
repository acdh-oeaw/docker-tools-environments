FROM acdh/base_existdb
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

# Inject config, fix problems
COPY build-config.diff 0001-Replace-ivy-2.3.0-with-ivy-2.5.0.patch /opt/
COPY autodeploy/* /opt/exist/autodeploy/
RUN yum -y install maven ant && \
    cd /opt/exist && \
    git fetch --depth 1 origin eXist-2.2 &&\
    git checkout eXist-2.2 && \
    git apply ../0001-Replace-ivy-2.3.0-with-ivy-2.5.0.patch &&\
    patch -p1 < ../build-config.diff && ./build.sh && \
    yum -y remove ant maven && yum -y autoremove && \
    yum clean all &&\
    rm -rf ~/.m2 ~/.ivy2 /var/cache/yum/
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
COPY wrapper.conf /opt/exist/tools/wrapper/conf/
RUN chmod a+x /opt/exist/tools/wrapper/bin/wrapper.sh

#@INJECT_USER@

CMD ["/opt/exist/tools/wrapper/bin/wrapper.sh", "/opt/exist/tools/wrapper/conf/wrapper.conf", "wrapper.syslog.ident=exist", "wrapper.name=exist", "wrapper.displayname=eXist db 2.2", "wrapper.daemonize=FALSE"]
# We use runtime configuration for that for now.
# VOLUME /var/log/exist /opt/exist/webapp/WEB-INF/data /opt/exist/autodeploy
# EXPOSE 8080 8443
