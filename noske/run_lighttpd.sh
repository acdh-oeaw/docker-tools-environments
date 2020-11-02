#!/usr/bin/env bash
if [ ! "$(ls -A /usr/lib/python2.7/dist-packages/bonito)" ];
then cp -R /usr/lib/python2.7/site-packages/bonito.init/* /usr/lib/python2.7/dist-packages/bonito
fi
if [ ! "$(ls -A /var/www/crystal)" ];
then cp -R /var/www/crystal.init/* /var/www/crystal
fi
exec 3>&1
/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -D