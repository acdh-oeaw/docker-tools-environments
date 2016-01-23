FROM ubuntu:wily
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
    apt update && apt full-upgrade -y
RUN apt install -y git patch maven default-jdk
RUN mkdir /data && cd /opt && git clone --verbose --progress https://github.com/BaseXdb/basex.git && cd basex && git checkout 8.3.1
RUN cd /opt/basex/basex-api && mvn install -Dmaven.test.skip=true
ENV HOME "/data"
COPY basex* /opt/basex/basex-api/etc/
RUN chmod a+x /opt/basex/basex-api/etc/basexhttp /opt/basex/basex-api/etc/basexhttpstop
COPY WEB-INF /opt/basex/basex-api/src/main/resources/WEB-INF/
EXPOSE 1984
EXPOSE 8984
CMD ["/opt/basex/basex-api/etc/basexhttp"]
