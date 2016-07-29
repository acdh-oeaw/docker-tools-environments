FROM acdh/existdb30
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

COPY log4j2.xml /opt/exist/tools/wrapper/conf/log4j2.xml
RUN ln -sf /opt/exist/tools/wrapper/conf/log4j2.xml /opt/exist/log4j2.xml
COPY autodeploy/* /opt/exist/autodeploy.init/
COPY wrapper.conf /opt/exist/tools/wrapper/conf/wrapper.conf
