#!/bin/bash

set -e

# extract bundle
rm -rf /usr/src/php-latest/test
mkdir /usr/src/php-latest/test && cd /usr/src/php-latest/test
tar xzf ../php73-${VERSION}.tar.gz

# restore configuration files
sed -i -e "s#^zend_extension=\$(pwd)#zend_extension=$(pwd)#g" usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
sed -i -e "s#^extension=\$(pwd)#extension=$(pwd)#g" usr/local/etc/php/conf.d/docker-php-ext-sodium.ini

# test executable script
./php.sh --version
./php.sh --ini

# exit
cd ..
rm -rf test
