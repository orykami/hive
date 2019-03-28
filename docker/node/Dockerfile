ARG NODE_VERSION
FROM node:${NODE_VERSION}-alpine
LABEL maintainer="Benoit JACQUOT <88.jacquot.benoit@gmail.com>"

RUN echo @main http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo /etc/apk/respositories && \
    apk update && apk upgrade &&\
    apk add --no-cache \
    bash \
    git \
    supervisor \
    curl && \
    mkdir -p /var/log/supervisor && \
    apk del gcc musl-dev linux-headers libffi-dev augeas-dev python-dev make autoconf

# Clean up temporary directories
RUN rm -rf /tmp/* /var/tmp/*

EXPOSE 9000

COPY supervisor/supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]
WORKDIR /var/www