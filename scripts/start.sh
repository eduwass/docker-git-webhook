#!/bin/bash

# Disable Strict Host checking for non interactive git clones
mkdir -p -m 0700 /root/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Copy private SSH key
if [ ! -z "$SSH_KEY" ]; then
  if [ ! -z "$BASE64_ENCODED_SSH_KEY" ]; then
    echo $SSH_KEY > /root/.ssh/id_rsa.base64
    base64 -d /root/.ssh/id_rsa.base64 > /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
  else
    echo $SSH_KEY > /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
  fi
fi

# Setup git variables
if [ ! -z "$GIT_EMAIL" ]; then
 git config --global user.email "$GIT_EMAIL"
fi
if [ ! -z "$GIT_NAME" ]; then
 git config --global user.name "$GIT_NAME"
 git config --global push.default simple
fi

# Dont pull code down if the .git folder exists
if [ ! -d "/code/.git" ];then
  # Pull down code form git for our site!
  if [ ! -z "$GIT_REPO" ]; then
    rm /code/*
    if [ ! -z "$GIT_BRANCH" ]; then
      git clone  --recursive -b $GIT_BRANCH $GIT_REPO /code/
    else
      git clone --recursive $GIT_REPO /code/
    fi
    chown -Rf www-data:www-data /code/*
  else
    # if git repo not defined, pull from default repo:
    git clone  --recursive -b production https://github.com/eduwass/containerstudio-wordpress.git /code/
    # remove git files
    rm -rf /code/.git
  fi
fi

# Run any commands passed by env
eval $STARTUP_COMMANDS

# Start supervisord to start app and services
/usr/bin/supervisord -n -c /etc/supervisord.conf