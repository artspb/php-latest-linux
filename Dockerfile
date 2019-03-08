FROM php:7.3.3-cli
RUN pecl install xdebug-2.7.0 && docker-php-ext-enable xdebug
WORKDIR /usr/src/php-latest
