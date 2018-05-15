FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
RUN apt update && apt full-upgrade -y && \
  apt-get install -y npm nodejs git && \
  apt-get clean && \
  npm install -g bower

#@INJECT_USER@
