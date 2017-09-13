#!/bin/bash

sed -i 's|</VirtualHost>|#</VirtualHost>|g' /etc/apache2/sites-available/000-default.conf;
echo 'ScriptAlias /fcgi-bin/ "/usr/share/cgi-bin/"'      >> /etc/apache2/sites-available/000-default.conf; \
echo '<Directory "/usr/share/cgi-bin">'                    >> /etc/apache2/sites-available/000-default.conf; \
echo '    AllowOverride None'                              >> /etc/apache2/sites-available/000-default.conf; \
echo '    Options None'                                    >> /etc/apache2/sites-available/000-default.conf; \
echo '    Require all granted'                             >> /etc/apache2/sites-available/000-default.conf; \
echo '</Directory>'                                        >> /etc/apache2/sites-available/000-default.conf; \
echo 'AddHandler fastcgi-script fcg fcgi fpl'              >> /etc/apache2/sites-available/000-default.conf; \
echo 'Action iiifserver.fcgi /iiifserver.fcgi'              >> /etc/apache2/sites-available/000-default.conf; \
echo 'FastCgiExternalServer /usr/share/cgi-bin/iiifserver.fcgi -host 127.0.0.1:9000 -idle-timeout 3600' >> /etc/apache2/sites-available/000-default.conf; \
echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf;

/usr/bin/supervisord
