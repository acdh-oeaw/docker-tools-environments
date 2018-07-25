FROM acdh/java8
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN mkdir -p /opt/basex && chown user:user /opt/basex
USER user
WORKDIR /opt/basex/bin
CMD ["/opt/basex/bin/basexhttp"]
