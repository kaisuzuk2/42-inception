#!/bin/bash
set -e

if [ -z $DOMAIN_NAME ]; then
    echo "[Entrypoint] DOMAIN_NAME empty"
    exit 1
fi 

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    mkdir -p /etc/nginx/ssl

    openssl req \
        -x509 -nodes \
        -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/CN=$DOMAIN_NAME"
fi

exec "$@"