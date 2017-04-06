#!/bin/bash

# Disable Strict Host checking for non interactive git clones
mkdir -p -m 0700 /root/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Copy private SSH key
if [ ! -z "$SSH_KEY" ]; then
 echo $SSH_KEY > /root/.ssh/id_rsa
 chmod 600 /root/.ssh/id_rsa
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
if [ ! -d "/usr/src/app/.git" ];then
  # Pull down code form git for our site!
  if [ ! -z "$GIT_REPO" ]; then
    rm /usr/src/app/*
    if [ ! -z "$GIT_BRANCH" ]; then
      git clone  --recursive -b $GIT_BRANCH $GIT_REPO /usr/src/app/
    else
      git clone --recursive $GIT_REPO /usr/src/app/
    fi
    chown -Rf www-data:www-data /usr/src/app/*
  else
    # if git repo not defined, pull from default repo:
    git clone  --recursive -b production https://github.com/eduwass/containerstudio-wordpress.git /usr/src/app/
    # remove git files
    rm -rf /usr/src/app/.git
  fi
fi

# Run any commands passed by env
eval $STARTUP_COMMANDS

# Start supervisord to start app and services
/usr/bin/supervisord -n -c /etc/supervisord.conf