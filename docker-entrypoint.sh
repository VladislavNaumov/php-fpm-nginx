#!/bin/sh

# Installing the composer package and adding autoloading
cd /opt/www && composer install

# Run php-fpm service
php-fpm -D

sleep 2

# Checking nginx conf and run
nginx -t
exec nginx -g 'daemon off;'