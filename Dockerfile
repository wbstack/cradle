FROM composer@sha256:d374b2e1f715621e9d9929575d6b35b11cf4a6dc237d4a08f2e6d1611f534675 as composer
# composer is pinned at a PHP 7 version

WORKDIR /installing
COPY ./ /installing
RUN composer install --no-dev --no-progress


FROM php:8.0.0-apache

LABEL org.opencontainers.image.source="https://github.com/wbstack/cradle"

ENV APACHE_DOCUMENT_ROOT /var/www/html/cradle/public_html
#TODO do 2 tuns in 1 layer..
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf
RUN sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY --from=composer --chown=www-data:www-data /installing /var/www/html/cradle

ADD ./docker/config.js /var/www/html/cradle/public_html/config.js
