#!/bin/bash
REQ=""
for i in `find /var/www/html -name composer.json | grep -v /var/www/html/core | grep -v /var/www/html/composer.json | grep -v /var/www/html/vendor | sed -e 's|^/var/www/html/||'`; do
  REQ="${REQ}, \"$i\""
done
REQ="\"merge-plugin\": {\"require\":[${REQ:2}],"
sed -i -e "s|^.*\"merge-plugin\".*$|$REQ|" /var/www/html/composer.json
cd /var/www/html
composer update
