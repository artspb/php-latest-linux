FROM php:7.2-cli
RUN pecl install xdebug-2.6.0alpha1 && docker-php-ext-enable xdebug
WORKDIR /usr/src/php-latest