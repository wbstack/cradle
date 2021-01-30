FROM composer@sha256:d374b2e1f715621e9d9929575d6b35b11cf4a6dc237d4a08f2e6d1611f534675 as composer
# composer is pinned at a PHP 7 version

WORKDIR /installing
COPY ./ /installing
RUN composer install --no-dev --no-progress --no-autoloader && rm -rf vendor


FROM nginx:1-alpine

LABEL org.opencontainers.image.source="https://github.com/wbstack/cradle"

COPY --from=composer --chown=nginx:nginx /installing/public_html /usr/share/nginx/html

ADD ./docker/default.conf /etc/nginx/conf.d/default.conf
ADD ./docker/config.js /usr/share/nginx/html/config.js
