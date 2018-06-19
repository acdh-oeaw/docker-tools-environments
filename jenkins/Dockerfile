FROM jenkins/jenkins:lts-alpine
MAINTAINER Omar Siam <Omar.Siam@oeaw.ac.at>

RUN mkdir -p $JENKINS_HOME \
    && chown user:user $JENKINS_HOME
#    && adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}
RUN chown -R user "$JENKINS_HOME" /usr/share/jenkins/ref