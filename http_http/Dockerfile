# Image for serving HTTP environment
# The base acdh/http image was not sufficient because placing VOLUMES 
#   directives in it caused problems with child containers
FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# expose
VOLUME /etc
VOLUME /var/log
EXPOSE 80

