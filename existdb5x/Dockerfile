FROM existdb/existdb:5.0.0
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

COPY busybox /bin/busybox
COPY busybox /bin/sh
COPY busybox /bin/rm
COPY busybox /bin/ln
COPY useradd.sh /bin/useradd
COPY groupadd.sh /bin/groupadd
RUN cd /bin && rm sh && ln -s busybox sh && ln -s busybox cp &&\
  rm rm && cp sh rm && cp rm ln && cp rm chmod &&\
  chmod u+x /usr/sbin/useradd /usr/sbin/groupadd

#@INJECT_USER@

VOLUME /exist/data /exist/autodeploy /exist/logs