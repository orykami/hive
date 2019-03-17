FROM nginx:alpine
LABEL maintainer="Benoit JACQUOT <88.jacquot.benoit@gmail.com>"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data

# Adding CSR/SSL script & config for Local SSL Generation
ADD ./scripts/startup.sh /opt/startup.sh
ADD ./scripts/ssl/domains.ext /opt/domains.ext

CMD ["/bin/bash", "/opt/startup.sh"]

EXPOSE 80 443