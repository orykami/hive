#!/bin/bash

# Launch SSL generation if no certificate found in /etc/nginx/ssl
if [[ ! -f /etc/nginx/ssl/hive.crt ]]; then
    # Create Root CA for Hive certificates (KEY,PEM)
    openssl req -x509 -new -nodes \
        -newkey rsa:2048 -keyout "/etc/nginx/ssl/RootCA.key" \
        -subj "/C=FR/CN=Hive-Root-CA" \
        -sha256 -days 1024 -out "/etc/nginx/ssl/RootCA.pem"
    # Create Root CA Certificate for Hive (CRT)
    openssl x509 -outform pem \
        -in "/etc/nginx/ssl/RootCA.pem" \
        -out "/etc/nginx/ssl/RootCA.crt"
    # Create Wildcard Certificate for Hive (CSR)
    openssl req -new -nodes \
        -newkey rsa:2048 -keyout "/etc/nginx/ssl/hive.key" \
        -out "/etc/nginx/ssl/hive.csr" \
        -subj "/C=FR/ST=Lorraine/L=Epinal/O=Hive/CN=hive.local"
    # Trust Wildcard Certificate with Hive Root CA
    openssl x509 -req -in "/etc/nginx/ssl/hive.csr" \
        -CA "/etc/nginx/ssl/RootCA.pem" \
        -CAkey "/etc/nginx/ssl/RootCA.key" \
        -CAcreateserial -days 1024 -sha256 \
        -extfile "/opt/domains.ext" \
        -in "/etc/nginx/ssl/hive.csr" \
        -out "/etc/nginx/ssl/hive.crt"
    # Create DHPARAM for increase SSL Security
    if [[ ! -f /etc/nginx/ssl/dh2048.pem ]]; then
        openssl dhparam -out /etc/nginx/ssl/dh2048.pem 2048
    fi
fi

nginx