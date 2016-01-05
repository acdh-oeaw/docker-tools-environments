# Image for serving HTTP/PHP and HTTP/WSGI environments:
# - PHP run as suPHP
# - WSGI module compiled against Python3
#
# Because of these two requirements the basis is
# an Ubuntu Server destribution (instead of CentOs)
FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
RUN apt-get update && \
  apt-get install -y libapache2-mod-wsgi python-pip python-virtualenv && \
  apt-get install -y libmysqlclient-dev python-dev && \
  apt-get clean

# expose
VOLUME /etc
VOLUME /var/log
EXPOSE 80
EXPOSE 8000
