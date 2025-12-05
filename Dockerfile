FROM php:8.2-fpm-alpine

LABEL authors="Vladislav Naumov"

WORKDIR /opt/www

COPY ./src /opt/www

RUN apk update && apk upgrade && \
    apk add --no-cache nginx && \
    apk add composer && \
    mkdir -p /run/nginx && \
    mkdir -p /var/tmp/nginx

COPY ./configs/nginx/app.conf /etc/nginx/http.d/default.conf

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["docker-entrypoint.sh"]