FROM acdh/java8
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

WORKDIR /opt/basex/bin
#@INJECT_USER@
RUN mkdir -p /opt/basex &&\
    if [ $(id user >/dev/null  2>&1; echo $?) -eq "0" ]; then chown user:user /opt/basex; fi
CMD ["/opt/basex/bin/basexhttp"]
