#!/bin/sh

php-fpm -D
sleep 2
nginx -t
exec nginx -g 'daemon off;'