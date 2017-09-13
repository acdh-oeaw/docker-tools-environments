FROM acdh/http
MAINTAINER Dalibor Pancic <dalibor.pancic@oeaw.ac.at>

# Update packages
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
              apt-get update && apt-get install -y wget git unzip nano memcached libfcgi0ldbl libapache2-mod-fastcgi \
              libtiff-dev libjpeg-turbo8-dev libtool libmemcached11 libpng12-0 python-pip links && \
              a2enmod actions && \
    apt-get clean

ENV USER=user \
    DIR=/usr/share

# Install IIIF Server for Ubuntu Xenial 64bit extracted from .deb package
# from http://downloads.klokantech.com/iiifserver/iiifserver-1.0.0-241.ubuntu-xenial.amd64.deb

COPY iiifserver $DIR/iiifserver

RUN  cp -r $DIR/iiifserver/kakadu/*.so /usr/lib/x86_64-linux-gnu && \
     cp -r $DIR/iiifserver/kakadu/kdu_expand /usr/bin && \
     export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/bin && \
     /usr/bin/kdu_expand -v && \
     cp -r $DIR/iiifserver/dropzone.py /usr/bin/dropzone.py && chmod +x /usr/bin/dropzone.py && \
     cp -r $DIR/iiifserver/supervisord.conf /etc/supervisor/conf.d/ && \
     mkdir -p /dropzone /data $DIR/cgi-bin /opt/iiifserver/logs && \ 
     cp -r $DIR/iiifserver/iiifserver.fcgi $DIR/cgi-bin && cd $DIR/cgi-bin && ln -s ../iiifserver/iiifserver.dat iiifserver.dat && \
     cp -r $DIR/iiifserver/viewer.html / && cp -r $DIR/iiifserver/demo.jp2 /data/ && \
     cp -r $DIR/iiifserver/docker-entrypoint.sh / && chmod +x /docker-entrypoint.sh && \
     chown -R $USER:$USER /usr/bin/dropzone.py /usr/bin/memcached /data /dropzone \
                          /viewer.html $DIR/cgi-bin  $DIR/iiifserver /opt/iiifserver/logs 
 


