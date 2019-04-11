#!/bin/bash

# Launch self-signed SSL generation if needed
if [[ ! -f /etc/nginx/ssl/hive.default.crt ]]; then
    openssl genrsa -out "/etc/nginx/ssl/hive.default.key" 2048
    openssl req -new -key "/etc/nginx/ssl/hive.default.key" \
        -out "/etc/nginx/ssl/hive.default.csr" \
        -subj "/CN=hive/O=hive/C=FR"
    openssl x509 -req -days 365 \
        -in "/etc/nginx/ssl/hive.default.csr" \
        -signkey "/etc/nginx/ssl/hive.default.key" \
        -out "/etc/nginx/ssl/hive.default.crt"
    # Create DHPARAM for increase SSL Security if needed
    if [[ ! -f /etc/nginx/ssl/dhparam.pem ]]; then
        openssl dhparam -out /etc/nginx/ssl/dhparam.pem 4096
    fi
fi

# Resolve environment variables from VHOSTS configurations
for vhost in /etc/nginx/vhosts/*.conf;
do
  /bin/bash -c \
    "envsubst '\$NGINX_HOST_HTTPS_PORT \$NGINX_HOST_HTTP_PORT' < $vhost \
    > /etc/nginx/sites-enabled/$(basename -- $vhost)";
done

nginx