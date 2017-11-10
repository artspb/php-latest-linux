FROM php:7.1-cli
RUN pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug
WORKDIR /usr/src/php-latest