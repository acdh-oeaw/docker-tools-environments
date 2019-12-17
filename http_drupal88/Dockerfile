FROM ubuntu:eoan
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update &&\
    apt upgrade -y &&\
    apt install -y composer curl git apache2 libapache2-mod-php php-opcache php-cli php-curl php-gd php-json php-mbstring php-mysql php-pgsql php-sqlite3 php-xml php-zip &&\
    a2enmod rewrite &&\
    usermod -d /var/www/drupal www-data &&\
    mkdir -p /var/www/drupal/composer &&\
    chown -R www-data:www-data /var/www/drupal &&\
    cd /var/www/drupal &&\
    runuser -u www-data -- composer create-project drupal/recommended-project git --no-interaction &&\
    cd /var/www/drupal/git &&\
    runuser -u www-data -- composer require drush/drush &&\
    mv composer.json /var/www/drupal/composer/ &&\
    ln -s /var/www/drupal/composer/composer.json composer.json
CMD ["/bin/bash", "-c", "source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND"]
VOLUME /var/www/drupal/composer /var/www/drupal/git/web/sites
#@INJECT_USER@
RUN chown -R www-data:www-data /var/www/drupal

