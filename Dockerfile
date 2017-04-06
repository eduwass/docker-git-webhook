# Use AlpineLinux as base image
FROM alpine:3.5

# Install Git
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# Install Supervisor
RUN apk add --no-cache \
    supervisor

# Copy supervisor config
ADD conf/supervisord.conf /etc/supervisord.conf

# Add our Scripts
ADD scripts/pull /usr/bin/pull
ADD scripts/push /usr/bin/push
ADD scripts/docker-hook /usr/bin/docker-hook
ADD scripts/hook-listener /usr/bin/hook-listener
ADD scripts/start.sh /usr/bin/start.sh
RUN chmod 755 /usr/bin/pull && chmod 755 /usr/bin/push
RUN chmod +x /usr/bin/docker-hook
RUN chmod +x /usr/bin/hook-listener

# Expose Webhook port
EXPOSE 8555

# run start script
CMD ["/bin/bash", "/usr/bin/start.sh"]