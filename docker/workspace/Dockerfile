FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

USER root
# Create user/group & configure useful utils
ARG PUID=1000
ARG PGID=1000
RUN set -xe; \
    apt-get update -yqq && \
    groupadd -g ${PGID} hive && \
    useradd -u ${PUID} -g hive -m hive && \
    usermod -p "*" hive -s /bin/bash && \
    apt-get install -yqq \
        apt-utils \
        curl \
        cron \
        htop \
        libzip-dev zip unzip

# Create custom user aliases
USER root
    COPY ./aliases.sh /root/aliases.sh
    COPY ./aliases.sh /home/hive/aliases.sh

RUN sed -i 's/\r//' /root/aliases.sh && \
    sed -i 's/\r//' /home/hive/aliases.sh && \
    chown hive:hive /home/hive/aliases.sh && \
    echo "" >> ~/.bashrc && \
    echo "# Custom aliases" >> ~/.bashrc && \
    echo "source ~/aliases.sh" >> ~/.bashrc && \
    echo "" >> ~/.bashrc

USER hive

RUN echo "" >> ~/.bashrc && \
    echo "# Custom aliases" >> ~/.bashrc && \
    echo "source ~/aliases.sh" >> ~/.bashrc && \
    echo "" >> ~/.bashrc

# Load & configure custom CRONTAB
USER root
COPY ./crontab /etc/cron.d
RUN chmod -R 644 /etc/cron.d

# Load NVM & configure .env NodeJS version
USER hive
ARG NODE_VERSION=node
ENV NODE_VERSION ${NODE_VERSION}
ENV NVM_DIR /home/hive/.nvm
RUN mkdir -p $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm use ${NODE_VERSION} \
    && nvm alias ${NODE_VERSION} \
    && ln -s `npm bin --global` /home/hive/.node-bin

RUN echo "" >> ~/.bashrc \
    && echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc \
    && echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.bashrc

USER root
RUN echo "" >> ~/.bashrc \
    && echo 'export NVM_DIR="/home/hive/.nvm"' >> ~/.bashrc \
    && echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.bashrc

ENV PATH $PATH:/home/hive/.node-bin

# Load & configure Deployer (https://deployer.org/)
USER root
RUN curl -LO https://deployer.org/deployer.phar \
    && mv deployer.phar /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep

# Clean up
USER root
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm /var/log/lastlog /var/log/faillog

# Set default work directory
WORKDIR /var/www