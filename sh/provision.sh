#!/usr/bin/env bash

export SWITCHAROO_LOCAL=$1
export SWITCHAROO_HOSTNAME=$2
export SWITCHAROO_ENGINE=$3

# Change the hostname so we can easily identify what environment we're on:
echo ${SWITCHAROO_HOSTNAME} > /etc/hostname

# Update /etc/hosts to match new hostname to avoid "Unable to resolve hostname" issue:
echo "127.0.0.1 ${SWITCHAROO_HOSTNAME}" >> /etc/hosts

# Use hostname command so that the new hostname takes effect immediately without a restart:
hostname ${SWITCHAROO_HOSTNAME}

# Install core components
sudo -u root bash /vagrant/sh/core.sh

# Install engine
sudo su - vagrant /vagrant/sh/engine.sh ${SWITCHAROO_ENGINE}

# Do some fun sym linking
if [ ${#SWITCHAROO_LOCAL[@]} -ne 0 ]; then
  sudo -u root bash /vagrant/sh/npm_link.sh ${SWITCHAROO_LOCAL}
fi

echo "--------------------------------------------------"
echo "Finished provisioning."