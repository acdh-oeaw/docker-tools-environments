FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
RUN apt-get update && \
  apt-get install -y wget libapache2-mod-php5 php5-gd php5-mysql php5-sqlite && \
  apt-get clean

WORKDIR /var/www
RUN wget http://ftp.drupal.org/files/projects/drupal-7.41.tar.gz
RUN tar -xzf drupal-7.41.tar.gz && \
  rm -f drupal-7.41.tar.gz && \
  rm -fR html && \
  mv drupal-7.41 html && \
  mv html/sites/default html/sites/default_template && \
  mkdir html/sites/default && \
  chown -R www-data:www-data html

# expose
VOLUME /etc
VOLUME /var/log
VOLUME /var/www/html/sites/default_template
EXPOSE 80
