# Image for serving HTTP/PHP environment using the ubuntu:latest docker hub image
FROM ubuntu:latest
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

ENV DEBIAN_FRONTEND=noninteractive
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
    apt install -y supervisor apache2 curl vim libapache2-mod-php8.0 \
                   php8.0-cli \
                   php8.0-pgsql php8.0-mysql php8.0-sqlite3 php8.0-pdo php8.0-pdo-pgsql php8.0-pdo-mysql php8.0-pdo-sqlite \
                   php8.0-zip php8.0-iconv php8.0-readline php8.0-curl php8.0-intl php8.0-mbstring php8.0-yaml php8.0-bcmath php8.0-dom php8.0-opcache php8.0-gd php8.0-xml php8.0-xsl php8.0-imagick && \
    apt clean && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    a2enmod rewrite && \
    a2enmod headers && \
    a2enmod proxy && \
    a2enmod proxy_http && \
    sed -i -e 's/StartServers.*/StartServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf && \
    sed -i -e 's/MinSpareServers.*/MinSpareServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf && \
    sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 64M/' -e 's/post_max_size.*/post_max_size = 64M/' /etc/php/*/apache2/php.ini && \
    mkdir -p /var/www/exec /var/www/config && \
    chown www-data:www-data /var/www/exec /var/www/config && \
    rm -fR /var/www/html/* && \
    curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    rm composer-setup.php && \
    echo '[supervisord]\nnodaemon=true\n\n[program:apache2]\ncommand=/bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND"' > /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
EXPOSE 80
#@INJECT_USER@

