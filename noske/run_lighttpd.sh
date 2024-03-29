#!/usr/bin/env bash
if [ ! "$(ls -A /usr/lib/python2.7/dist-packages/bonito)" ];
then cp -R /usr/lib/python2.7/dist-packages/bonito.init/* /usr/lib/python2.7/dist-packages/bonito
fi
for corp in $CORPLIST
do path=$(grep -h ^PATH $MANATEE_REGISTRY/$corp | sed -e 's/^PATH[^"]*"\(.*\)"$/\1/g')
if [ ! -d $path ] || [ ! "$(ls -A $path)" ]
  then mkdir -p $path; encodevert -c $corp
  fi
done
exec 3>&1
exec /usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -D