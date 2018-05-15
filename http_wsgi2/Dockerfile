# Image for serving HTTP/WSGI with Python2
FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
RUN apt-get update && \
  apt-get install -y libapache2-mod-wsgi python-pip python-virtualenv && \
  apt-get install -y libmysqlclient-dev python-dev git && \
  apt-get clean

# expose
EXPOSE 80
EXPOSE 8000

#@INJECT_USER@

