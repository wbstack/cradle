#!/usr/bin/env bash

if [ -r '/usr/share/ca-certificates/extra/ca.crt' ]; then
    echo 'extra/ca.crt' >> /etc/ca-certificates.conf
    update-ca-certificates
fi

docker-php-entrypoint apache2-foreground
