FROM ubuntu:latest
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

ENV DEBIAN_FRONTEND=noninteractive PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/www/drupal/git/vendor/drush/drush/
RUN apt update && \
    apt full-upgrade -y && \
    apt install -y locales gnupg && \
    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu/ focal main" >> /etc/apt/sources.list && \
    echo "deb http://ppa.launchpad.net/ondrej/apache2/ubuntu/ focal main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en
RUN locale-gen en_US.UTF-8 && \
    locale-gen de_DE.UTF-8 && \
    apt update && \
    apt install -y curl git vim mysql-client \
                   apache2 libapache2-mod-php8.0 \
                   php8.0-cli php8.0-curl php8.0-gd php8.0-mbstring php8.0-mysql php8.0-opcache php8.0-pgsql php8.0-sqlite3 php8.0-xml php8.0-yaml php8.0-zip && \
    apt clean && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    a2enmod rewrite && \
    sed -i -e 's/StartServers.*/StartServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf && \
    sed -i -e 's/MinSpareServers.*/MinSpareServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf && \
    sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 64M/' -e 's/post_max_size.*/post_max_size = 64M/' /etc/php/*/apache2/php.ini && \
    curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    rm composer-setup.php && \
    usermod -d /var/www/drupal www-data &&\
    mkdir -p /var/www/drupal/composer &&\
    chown -R www-data:www-data /var/www/drupal &&\
    cd /var/www/drupal &&\
    runuser -u www-data -- composer create-project drupal/recommended-project git --no-interaction &&\
    cd /var/www/drupal/git &&\
    runuser -u www-data -- composer require drush/drush &&\
    mv composer.json /var/www/drupal/composer/ &&\
    ln -s /var/www/drupal/composer/composer.json composer.json &&\
    chown -R www-data:www-data /var/www/drupal
CMD ["/bin/bash", "-c", "source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND"]
VOLUME /var/www/drupal/composer /var/www/drupal/git/web/sites
EXPOSE 80

