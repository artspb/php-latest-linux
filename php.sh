#!/bin/bash
LD_LIBRARY_PATH="$(pwd)/usr/lib/x86_64-linux-gnu" PHP_INI_SCAN_DIR="$(pwd)/usr/local/etc/php/conf.d" $(pwd)/usr/local/bin/php -c $(pwd)/usr/local/etc/php/php.ini "$@"
