FROM php:7.3.2-cli
RUN pecl install xdebug-2.7.0RC2 && docker-php-ext-enable xdebug
WORKDIR /usr/src/php-latest
