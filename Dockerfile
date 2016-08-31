FROM php:alpine

MAINTAINER Dmitry Boyko <dmitry@thebodva.com>

RUN apk add --update bash && rm -rf /var/cache/apk/*

RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');"
RUN php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer && \
    rm -rf /tmp/composer-setup.php

RUN apk add --no-cache git unzip

RUN apk add --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        sqlite-dev \
        curl-dev \
    && docker-php-ext-install -j9 iconv mcrypt pdo_mysql pcntl pdo_sqlite zip curl bcmath mbstring \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j1 gd \
    && docker-php-ext-enable iconv mcrypt gd pdo_mysql pcntl pdo_sqlite zip curl bcmath mbstring