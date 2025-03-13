#!/usr/bin/env bash

sleep 25 # give minikube some time to create and mount the secret
if [ -r '/usr/share/ca-certificates/extra/ca.crt' ]; then
    echo 'extra/ca.crt' >> /etc/ca-certificates.conf
    update-ca-certificates
fi

docker-php-entrypoint apache2-foreground
