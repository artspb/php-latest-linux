FROM php:7.3.4-cli
RUN pecl install xdebug-2.7.1 && docker-php-ext-enable xdebug
WORKDIR /usr/src/php-latest
