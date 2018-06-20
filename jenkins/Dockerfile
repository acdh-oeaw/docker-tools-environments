FROM jenkins/jenkins:lts-alpine
MAINTAINER Omar Siam <Omar.Siam@oeaw.ac.at>

USER root

COPY useradd.sh /usr/sbin/useradd
COPY groupadd.sh /usr/sbin/groupadd
RUN chmod u+x /usr/sbin/useradd /usr/sbin/groupadd

#@INJECT_USER@

RUN mkdir -p $JENKINS_HOME \
    && chown -R user "$JENKINS_HOME" /usr/share/jenkins/ref \
    && REALUID=$(id -u user) && REALGROUP=$(id -G -n user) && REALGID=$(id -G user) \
    && deluser user \
    && addgroup -g $REALGID $REALGROUP && adduser -h "$JENKINS_HOME" -u $REALUID -G $REALGROUP -s /bin/bash -D user

USER user