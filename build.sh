#!/bin/bash

set -e

# initial cleanup
rm -rf bundle && rm -f php73-${VERSION}.tar.gz

# create bundle
mkdir bundle && cd bundle

# copy executable script
cp ../php.sh . && chmod +x php.sh

# extract and copy libraries
mapfile -t libs < <(ldd `which php` | grep '=> /usr/lib/x86_64-linux-gnu' | grep -oP '/.*(?= )')
for lib in "${libs[@]}"
do
    cp --parents ${lib} .
done
libbsd=$(ldd `which php` | grep '=>' | grep libbsd.so | grep -oP '/.*(?= )')
if [ -n "${libbsd}" ]; then
    cp ${libbsd} usr/lib/x86_64-linux-gnu
fi
libkeyutils=$(ldd `which php` | grep '=>' | grep libkeyutils.so | grep -oP '/.*(?= )')
if [ -n "${libkeyutils}" ]; then
    cp ${libkeyutils} usr/lib/x86_64-linux-gnu
fi
libidn=$(ldd `which php` | grep '=>' | grep libidn.so | grep -oP '/.*(?= )')
if [ -n "${libidn}" ]; then
    cp ${libidn} usr/lib/x86_64-linux-gnu
fi
libsodium=$(find / -name libsodium.so.18)
if [ -n "${libsodium}" ]; then
    cp ${libsodium} usr/lib/x86_64-linux-gnu
fi

# copy extension libraries
cp -r --parents /usr/local/lib/php/extensions .

# copy configuration
cp -r --parents /usr/local/etc/php .
if [ ! -f usr/local/etc/php/php.ini ]; then
    touch usr/local/etc/php/php.ini
fi

# add placeholder to configuration files
sed -i -e "s#^zend_extension=#zend_extension=\$(pwd)#g" usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
sed -i -e "s#^extension=sodium.so#extension=\$(pwd)/$(find usr -name sodium.so)#g" usr/local/etc/php/conf.d/docker-php-ext-sodium.ini

# copy binaries
cp --parents /usr/local/bin/php .
cp -d --parents /usr/local/bin/phar .
cp --parents /usr/local/bin/phar.phar .

# build archive
tar czf ../php73-${VERSION}.tar.gz .

# restore configuration files
sed -i -e "s#^zend_extension=\$(pwd)#zend_extension=$(pwd)#g" usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
sed -i -e "s#^extension=\$(pwd)#extension=$(pwd)#g" usr/local/etc/php/conf.d/docker-php-ext-sodium.ini

# delete all real files
for lib in "${libs[@]}"
do
    rm -f ${lib}
done
rm -rf /usr/local/lib/php/extensions
rm -rf /usr/local/etc/php
rm -f /usr/local/bin/php
rm -f /usr/local/bin/phar
rm -f /usr/local/bin/phar.phar

# test executable script
./php.sh --version
./php.sh --ini

# exit
cd ..
rm -rf bundle
