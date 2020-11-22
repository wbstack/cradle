FROM composer:1.10 as composer

WORKDIR /installing
COPY ./ /installing
RUN composer install --no-dev --no-progress --no-autoloader && rm -rf vendor


FROM nginx:1-alpine

LABEL org.opencontainers.image.source="https://github.com/wbstack/cradle"

COPY --from=composer --chown=nginx:nginx /installing/public_html /usr/share/nginx/html

ADD ./docker/default.conf /etc/nginx/conf.d/default.conf
ADD ./docker/config.js /usr/share/nginx/html/config.js
