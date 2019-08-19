FROM acdh/http
MAINTAINER Dalibor Pancic <dalibor.pancic@oeaw.ac.at>

ENV USER=user \
    DIR=/usr/share

COPY iiifserver $DIR/iiifserver

# Update packages
RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y wget unzip nano memcached nginx libfcgi0ldbl libtiff-dev \
                       libjpeg-turbo8-dev libtool libmemcached11 libpng16-16 python-pip links libjpeg-progs && \
    apt-get purge -y apache2 apache2-utils && \
    apt-get -y autoremove && \
    rm -rf /etc/apache2 && \
    apt-get clean && \
    mkdir -p /data && \
    mkdir -p /dropzone && \
    mkdir -p /logs && \
    mkdir -p $DIR/cgi-bin && \
    sed -i 's|www-data|user|g' /etc/nginx/nginx.conf && \
    cp -r $DIR/iiifserver/kakadu/kdulib/* /usr/lib/x86_64-linux-gnu/ && \
    cp -r $DIR/iiifserver/kakadu/kdu/* /usr/bin/ && \
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/bin && \
    cp $DIR/iiifserver/dropzone.py /usr/bin/dropzone.py && chmod +x /usr/bin/dropzone.py && \
    cp $DIR/iiifserver/supervisord.conf /etc/supervisor/conf.d/ && \
    cp $DIR/iiifserver/iiifserver.fcgi $DIR/cgi-bin && cp $DIR/iiifserver/iiifserver.dat $DIR/cgi-bin && \
    cp $DIR/iiifserver/viewer.html / && cp $DIR/iiifserver/demo.jp2 /data/ && \
    rm -f /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default && \
    cp $DIR/iiifserver/default /etc/nginx/sites-available/default && \
    cd /etc/nginx/sites-enabled && ln -s ../sites-available/default default && \
    rm -fR $DIR/iiifserver &&  rm -fR $DIR/kakadu && \
    touch /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh && \
    echo "#!/bin/bash\n\
          chown -R $USER:$USER $DIR/cgi-bin /data /viewer.html /usr/bin/dropzone.py /usr/bin/memcached /dropzone /logs\n\
          chmod +x $DIR/cgi-bin/iiifserver.fcgi /usr/bin/dropzone.py /usr/bin/memcached /usr/bin/kdu*\n\
          /usr/bin/supervisord\n"\
       >> /docker-entrypoint.sh

VOLUME /data/ /dropzone/ /logs

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
 


