#!/bin/bash

chmod +x /usr/bin/dropzone.py && mkdir -p /dropzone /var/cache/nginx /logo /opt/logs;
ln -s /var/log/nginx/error.log /opt/logs/nginx_error.log; 
touch /var/run/nginx.pid;
chown -R $USER:$USER /usr/bin/dropzone.py /usr/bin/memcached /opt/logs;
chown -R $USER:$USER /var/www/html /usr/sbin/nginx /etc/nginx /var/lib/nginx /run /var/run/nginx.pid;
chown -R $USER:$USER /var/log/nginx /var/cache/nginx;
chown -R $USER:$USER /data /dropzone /usr/share/cgi-bin  /usr/share/iiifserver /viewer.html;

/usr/bin/supervisord

