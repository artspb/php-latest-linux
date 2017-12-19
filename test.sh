#!/bin/bash

set -e

# extract bundle
rm -rf test
mkdir /usr/src/php-latest/test && cd /usr/src/php-latest/test
tar xzf ../php72-${VERSION}.tar.gz

# restore configuration files
find usr/local/etc/php/conf.d/ -maxdepth 1 -type f -exec sed -i -e "s#^zend_extension=\$(pwd)#zend_extension=$(pwd)#g" $(pwd)/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \;

# test executable script
./php.sh --version
./php.sh --ini

# exit
cd ..
rm -rf test
