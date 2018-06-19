FROM jenkins/jenkins:lts-alpine
MAINTAINER Omar Siam <Omar.Siam@oeaw.ac.at>

COPY useradd.sh /usr/sbin/useradd
COPY groupadd.sh /usr/sbin/groupadd
RUN chmod u+x /usr/sbin/useradd /usr/sbin/groupadd

#@INJECT_USER@

RUN mkdir -p $JENKINS_HOME \
    && chown -R user "$JENKINS_HOME" /usr/share/jenkins/ref
#    && adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}