FROM php:7.3.0RC6-cli
RUN pecl install xdebug-2.7.0beta1 && docker-php-ext-enable xdebug
WORKDIR /usr/src/php-latest