# Image for serving HTTP/PHP5 environment
#
# This configuration is DEPRECATED now and all services should be adapted to
# work with php7!
FROM acdh/base_http_php5
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 80
