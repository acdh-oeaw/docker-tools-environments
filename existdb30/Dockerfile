FROM acdh/base_existdb
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

# Inject config, fix problems
COPY build-config.diff /opt/exist-build-config.diff
COPY final.patch /opt/final.patch
RUN cd /opt/exist && \
    git checkout acd0c14 && \
    patch -p1 < ../final.patch &&\
    patch -p1 < ../exist-build-config.diff && ./build.sh &&\
    mkdir -p /var/log/exist &&\
    mkdir -p /data &&\
    mv /opt/exist/autodeploy /opt/exist/autodeploy.init &&\
    rm -rf tools/yajsw/logs &&\
    ln -s /var/log/exist tools/yajsw/logs &&\
    rm -rf tools/jetty/logs &&\
    ln -s /var/log/exist tools/jetty/logs &&\
    rm -rf webapp/WEB-INF/logs &&\
    ln -s /var/log/exist webapp/WEB-INF/logs &&\
    mkdir -p /opt/exist/tools/jetty/tmp &&\
    chmod a+rwx /opt/exist/tools/jetty/tmp /opt/exist/tools/yajsw/tmp &&\
    chgrp users /opt/exist/tools/jetty/tmp /opt/exist/tools/yajsw/tmp &&\
    # wrapper changed to yajsw
    rm -rf /opt/exist/tools/wrapper

COPY wrapper.sh /opt/exist/tools/yajsw/bin/wrapper.sh
RUN chmod a+x /opt/exist/tools/yajsw/bin/wrapper.sh

CMD ["/opt/exist/tools/yajsw/bin/wrapper.sh"]
# We use runtime configuration for that for now.
# VOLUME /var/log/exist /opt/exist/webapp/WEB-INF/data /opt/exist/autodeploy
# EXPOSE 8080 8443
