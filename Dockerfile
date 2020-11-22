FROM ghcr.io/wbstack/build-util:latest as magnustools

WORKDIR /magnustools

# Checkout the code from git...
RUN git clone https://github.com/wbstack/magnustools.git . \
    # TODO this should be kept in sync with the version we are modifying files against... (get it dynamically?)
    && git checkout wbstack-0.8 \
    && rm -rf /magnustools/.git

FROM nginx:1-alpine

ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf

# TODO do in 1 layer
COPY --chown=nginx:nginx ./public_html /usr/share/nginx/html
COPY --from=magnustools --chown=nginx:nginx /magnustools/public_html/resources /usr/share/nginx/html/resources

ADD ./docker/config.js /usr/share/nginx/html/config.js
