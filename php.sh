#!/bin/bash
LD_LIBRARY_PATH="$(pwd)/usr/lib/x86_64-linux-gnu" PHP_INI_SCAN_DIR="$(pwd)/etc/php/7.1/cli/conf.d" $(pwd)/usr/bin/php7.1 -c $(pwd)/etc/php/7.1/cli/php.ini "$@"
