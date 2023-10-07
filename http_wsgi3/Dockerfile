# Image for serving HTTP/WSGI with Python3
FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
RUN apt-get update && \
  apt-get install -y libapache2-mod-wsgi-py3 python3-pip python3-virtualenv && \
  apt-get install -y default-mysql-client default-libmysqlclient-dev python3-dev git && \
  apt-get clean

# expose
EXPOSE 80
EXPOSE 8000

#@INJECT_USER@

