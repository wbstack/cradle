FROM composer:2.8 as composer

WORKDIR /installing
COPY ./ /installing
RUN composer install --no-dev --no-progress


FROM php:8.1-apache

LABEL org.opencontainers.image.source="https://github.com/wbstack/cradle"

ENV APACHE_DOCUMENT_ROOT /var/www/html/cradle/public_html
#TODO do 2 tuns in 1 layer..
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf
RUN sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY --from=composer --chown=www-data:www-data /installing /var/www/html/cradle

ADD ./docker/config.js /var/www/html/cradle/public_html/config.js

COPY docker/entrypoint.sh /entrypoint.sh
COPY docker/php.ini /usr/local/etc/php/conf.d/php.ini

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
