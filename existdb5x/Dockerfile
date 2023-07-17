FROM acdhch/existdb:5.3.1-java11-ShenGC
LABEL maintainer="Omar Siam <omar.siam@oeaw.ac.at>"

COPY busybox /bin/sh
COPY busybox /usr/bin/busybox
COPY busybox /usr/bin/sh
COPY busybox /usr/bin/rm
COPY busybox /usr/bin/ln
COPY useradd.sh /usr/bin/useradd
COPY groupadd.sh /usr/bin/groupadd
COPY bash.sh /bin/bash
RUN ln -sf /usr/bin/busybox /bin/sh && cd /usr/bin && ln -sf busybox sh && ln -sf busybox cp &&\
  ln -sf busybox rm && ln -sf busybox ln && ln -sf busybox ls &&\
  ln -sf busybox chmod && ln -sf busybox adduser && ln -sf busybox addgroup &&\
  chmod u+x /usr/bin/useradd /usr/bin/groupadd /bin/bash

ENV JAVA_TOOL_OPTIONS \
    $JAVA_TOOL_OPTIONS \
    -Dorg.exist.webdav.PROPFIND_METHOD_XML_SIZE=EXACT \
    -Dorg.exist.webdav.GET_METHOD_XML_SIZE=EXACT
    
#@INJECT_USER@
RUN rm -f /bin/sh /usr/bin/busybox /usr/bin/sh /usr/bin/rm /usr/bin/ln /usr/bin/useradd /usr/bin/groupadd /bin/bash

VOLUME /exist/data /exist/autodeploy /exist/logs
