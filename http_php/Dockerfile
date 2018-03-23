# Image for serving HTTP/PHP environment
#
FROM acdh/base_http_php
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 80

