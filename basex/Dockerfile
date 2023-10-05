# Container images newer than 11.0.17 don't work with our docker setup
# Latest version can be set with the replacement of 11.0.17 below
FROM azul/zulu-openjdk:11.0.17
LABEL maintainer Omar Siam <omar.siam@oeaw.ac.at>

RUN sed -i'' -e 's/11.0.17/11.0.20.1/g' /etc/apt/preferences && \
    apt update && apt dist-upgrade -y && apt install -y git
WORKDIR /opt/basex/bin
#@INJECT_USER@
RUN mkdir -p /opt/basex &&\
    if [ $(id user >/dev/null  2>&1; echo $?) -eq "0" ]; then chown user:user /opt/basex; fi
ENV BASEX_JVM="-XX:+UseContainerSupport -XX:+UseShenandoahGC -XX:ShenandoahGCHeuristics=compact -XX:+UseStringDeduplication -XX:+ExitOnOutOfMemoryError"
CMD ["/opt/basex/bin/basexhttp"]
