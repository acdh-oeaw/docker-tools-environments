# Image for serving HTTP/PHP environment using the ubuntu:latest docker hub image
FROM debian:bullseye
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt full-upgrade -y && \
    apt-get -y install lsb-release ca-certificates curl locales && \
    curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg && \
    sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
    apt-get update && \
    locale-gen en_US.UTF-8 && \
    locale-gen de_DE.UTF-8

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en
RUN apt update && \
    apt install -y supervisor apache2 curl vim libapache2-mod-php8.2 \
                   php8.2-cli \
                   php8.2-pgsql php8.2-mysql php8.2-sqlite3 php8.2-pdo php8.2-pdo-pgsql php8.2-pdo-mysql php8.2-pdo-sqlite \
                   php8.2-zip php8.2-iconv php8.2-readline php8.2-curl php8.2-intl php8.2-mbstring php8.2-yaml php8.2-bcmath php8.2-dom php8.2-opcache php8.2-gd php8.2-xml php8.2-xsl php8.2-imagick && \
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

