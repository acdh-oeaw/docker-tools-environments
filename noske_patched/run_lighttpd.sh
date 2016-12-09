#!/usr/bin/env bash
if [ ! "$(ls -A /usr/lib/python2.7/dist-packages/bonito)" ];
then cp -R /usr/lib/python2.7/dist-packages/bonito.init/* /usr/lib/python2.7/dist-packages/bonito
fi
/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -D