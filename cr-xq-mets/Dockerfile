FROM acdh/existdb31
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

COPY log4j2.xml /opt/exist/log4j2.xml
RUN ln -sf /opt/exist/log4j2.xml /opt/exist/tools/yajsw/conf/log4j2.xml
COPY autodeploy/* /opt/exist/autodeploy.init/
COPY wrapper.conf /opt/exist/tools/yajsw/conf/wrapper.conf
