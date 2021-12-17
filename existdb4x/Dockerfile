FROM acdh/base_existdb
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

# Inject config, fix problems
COPY exist-build-config.diff 0001-Force-update-RestXQ-for-Chrome.patch 0002-Update-log4j-Log4Shell-fix.patch 0003-Update-the-1.2-api-translate-layer-also.patch /opt/
RUN yum -y install maven ant && \
    cd /opt/exist && \
    git checkout eXist-4.3.1 &&\
    git apply ../0001-Force-update-RestXQ-for-Chrome.patch &&\
    git apply ../0002-Update-log4j-Log4Shell-fix.patch &&\
    git apply ../0003-Update-the-1.2-api-translate-layer-also.patch &&\
    patch -l -p1 < ../exist-build-config.diff && ./build.sh && \
    yum -y remove ant maven && yum -y autoremove && \
    rm -rf ~/.m2 ~/.ivy2
COPY autodeploy/* /opt/exist/autodeploy/
# customize config
RUN cd /opt/exist && \
    mkdir -p /var/log/exist &&\
    mkdir -p /data &&\
    cp -r /opt/exist/autodeploy /opt/exist/autodeploy.init &&\
    rm -rf tools/yajsw/logs &&\
    ln -s /var/log/exist tools/yajsw/logs &&\
    rm -rf tools/jetty/logs &&\
    ln -s /var/log/exist tools/jetty/logs &&\
    rm -rf webapp/WEB-INF/logs &&\
    ln -s /var/log/exist webapp/WEB-INF/logs &&\
    mkdir -p /opt/exist/tools/jetty/tmp &&\
    chmod a+rwx /opt/exist/tools/jetty/work /opt/exist/tools/jetty/tmp /opt/exist/tools/yajsw/tmp &&\
    chgrp users /opt/exist/tools/jetty/work /opt/exist/tools/jetty/tmp /opt/exist/tools/yajsw/tmp &&\
    # wrapper changed to yajsw
    rm -rf /opt/exist/tools/wrapper

COPY wrapper.sh /opt/exist/tools/yajsw/bin/wrapper.sh
COPY wrapper.conf /opt/exist/tools/yajsw/conf/
RUN chmod a+x /opt/exist/tools/yajsw/bin/wrapper.sh

#@INJECT_USER@

CMD ["/opt/exist/tools/yajsw/bin/wrapper.sh"]
# We use runtime configuration for that for now.
# VOLUME /var/log/exist /opt/exist/webapp/WEB-INF/data /opt/exist/autodeploy
# EXPOSE 8080 8443
