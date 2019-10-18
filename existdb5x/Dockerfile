FROM existdb/existdb:5.0.0
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

COPY busybox /usr/bin/busybox
COPY busybox /usr/bin/sh
COPY busybox /usr/bin/rm
COPY busybox /usr/bin/ln
COPY useradd.sh /usr/bin/useradd
COPY groupadd.sh /usr/bin/groupadd
RUN cd /usr/bin && ln -sf busybox sh && ln -sf busybox cp &&\
  ln -sf busybox rm && ln -sf busybox ln && ln -sf busybox ls &&\
  ln -sf busybox chmod && ln -sf busybox adduser && ln -sf busybox addgroup &&\
  chmod u+x /usr/bin/useradd /usr/bin/groupadd

#@INJECT_USER@

VOLUME /exist/data /exist/autodeploy /exist/logs