FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
  apt update && apt full-upgrade -y && \
  apt-get install -y npm nodejs git && \
  apt-get clean && \
  npm install -g bower && \
  ln -s /usr/bin/nodejs /usr/bin/node
