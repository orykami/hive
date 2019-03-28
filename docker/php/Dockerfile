ARG PHP_VERSION

FROM php:${PHP_VERSION}-fpm-alpine
LABEL maintainer="Benoit JACQUOT <88.jacquot.benoit@gmail.com>"

RUN echo @main http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo /etc/apk/respositories && \
    apk update && apk upgrade &&\
    apk add --no-cache \
    bash \
    wget \
    git \
    icu-dev \
    supervisor \
    libxml2-dev \
    libzip-dev \
    curl && \
    docker-php-ext-install pdo_mysql exif intl soap zip opcache pcntl bcmath && \
    docker-php-source delete && \
    mkdir -p /var/log/supervisor && \
    apk del gcc musl-dev linux-headers libffi-dev augeas-dev python-dev make autoconf

# Create default PHP.ini configuration from PHP template
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php \
    && echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc \
    && mv composer.phar /usr/local/bin/composer

# Load & configure Deployer (https://deployer.org/)
RUN curl -LO https://deployer.org/deployer.phar \
    && mv deployer.phar /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep

# Clean up temporary directories
RUN rm -rf /tmp/* /var/tmp/*

EXPOSE 9000

COPY supervisor/supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]
WORKDIR /var/www