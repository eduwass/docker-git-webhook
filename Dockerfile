# Use AlpineLinux as base image
FROM alpine:3.5

# Install Git
RUN apt-get update && \
apt-get install -y git

# Install Supervisor
ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.0
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION
RUN pip install supervisor==$SUPERVISOR_VERSION

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