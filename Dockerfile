FROM php:8.0-apache

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN apt-get install --fix-missing -y libpq-dev
RUN apt-get install --no-install-recommends -y libpq-dev
RUN apt-get install -y libxml2-dev libbz2-dev zlib1g-dev
RUN apt-get -y install libsqlite3-dev libsqlite3-0 mariadb-client curl exif ftp
RUN docker-php-ext-install intl
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-enable mysqli
RUN docker-php-ext-enable pdo
RUN docker-php-ext-enable pdo_mysql
RUN apt-get -y install git
RUN apt-get -y install --fix-missing zip unzip
RUN apt-get -y install --fix-missing git

COPY warung-app-ci4-rest /var/www/html/warung-app-ci4-rest
ADD conf/apache.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite

RUN chmod -R 0777 /var/www/html/warung-app-ci4-rest/writable
RUN chmod -R 0777 /var/www/html/warung-app-ci4-rest/public/img