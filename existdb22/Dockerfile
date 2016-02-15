FROM acdh/existdb30
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
    apt update && apt full-upgrade -y && apt-get clean
RUN apt install -y openjdk-7-jdk && apt-get clean && update-ca-certificates -f &&\
    update-alternatives --set java /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java &&\
    update-alternatives --set javac /usr/lib/jvm/java-7-openjdk-amd64/bin/javac
RUN cd /opt/exist && ant clean && rm -f extensions/betterform/main/lib/* && git reset --hard &&\
    git checkout eXist-2.2 && rm -rf tools/jetty/logs
COPY build-config.diff /opt/exist/build-config.diff
RUN cd /opt/exist && patch -p1 < build-config.diff && ./build.sh && mkdir -p /var/log/exist && mkdir -p /data
RUN cd /opt/exist &&\
 rm -rf tools/wrapper/logs &&\
 ln -s /var/log/exist tools/wrapper/logs &&\
 rm -rf tools/jetty/logs &&\
 ln -s /var/log/exist tools/jetty/logs &&\
 rm -rf webapp/WEB-INF/logs &&\
 ln -s /var/log/exist webapp/WEB-INF/logs &&\
 mkdir -p /opt/exist/tools/jetty/tmp &&\
 chmod g+w /opt/exist/tools/jetty/tmp &&\
 chgrp users /opt/exist/tools/jetty/tmp &&\
 mv /opt/exist/autodeploy /opt/exist/autodeploy.init
COPY wrapper.sh /opt/exist/tools/wrapper/bin/wrapper.sh
# git error: wrapper is not executable
RUN chmod a+x /opt/exist/tools/wrapper/bin/wrapper-linux-x86-64
RUN chmod a+x /opt/exist/tools/wrapper/bin/wrapper.sh
RUN chmod a+rwx /opt/exist/tools/jetty/tmp
# We use runtime configuration for that for now.
# VOLUME /var/log/exist /opt/exist/webapp/WEB-INF/data /opt/exist/autodeploy
# EXPOSE 8080 8443
