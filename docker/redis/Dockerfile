FROM redis:latest

# Configure some Redis optimization before launch
USER root
RUN echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf

EXPOSE 6379
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
