# Image for serving HTTP/WSGI with Python3
FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
RUN apt-get update && \
  apt-get install -y libapache2-mod-wsgi-py3 python3-pip python3-virtualenv wget && \
  apt-get install -y default-libmysqlclient-dev python3-dev git && \
  apt-get clean

RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.5.9/Python-3.5.9.tgz && \
    tar xzf Python-3.5.9.tgz && \
    cd Python-3.5.9 && \   
    ./configure --enable-optimizations && \
    make altinstall && \
    python3.5 -V 
# expose
EXPOSE 80
EXPOSE 8000

#@INJECT_USER@

