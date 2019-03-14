ARG PHP_VERSION

FROM php:${PHP_VERSION}-fpm-alpine

RUN echo @main http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo /etc/apk/respositories && \
    apk update && apk upgrade &&\
    apk add --no-cache \
    bash \
    wget \
    icu-dev \
    supervisor \
    libxml2-dev \
    libzip-dev \
    curl && \
    docker-php-ext-install pdo_mysql exif intl soap zip opcache && \
    docker-php-source delete && \
    mkdir -p /var/log/supervisor && \
    apk del gcc musl-dev linux-headers libffi-dev augeas-dev python-dev make autoconf

# Create default PHP.ini configuration from PHP template
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Clean up temporary directories
RUN rm -rf /tmp/* /var/tmp/*

EXPOSE 9000

WORKDIR /var/www