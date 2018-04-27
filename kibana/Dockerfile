FROM docker.elastic.co/kibana/kibana:6.2.4
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN chown user:user -R /usr/share/kibana/optimize /usr/share/kibana/data /usr/share/kibana/plugins

VOLUME /usr/share/kibana/config /usr/share/kibana/log

EXPOSE 5601