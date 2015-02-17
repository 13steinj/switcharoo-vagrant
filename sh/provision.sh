#!/usr/bin/env bash

# if [ -e "/etc/vagrant-provisioned" ];
# then
#     echo "Vagrant provisioning already completed. Skipping..."
#     exit 0
# else
#     echo "Starting Vagrant provisioning process..."
# fi

# Change the hostname so we can easily identify what environment we're on:
echo "switcharoo-vagrant" > /etc/hostname
# Update /etc/hosts to match new hostname to avoid "Unable to resolve hostname" issue:
echo "127.0.0.1 switcharoo-vagrant" >> /etc/hosts
# Use hostname command so that the new hostname takes effect immediately without a restart:
hostname switcharoo-vagrant



# Install core components
sudo -u root bash /vagrant/sh/core.sh

# Install io.js
sudo -u vagrant bash /vagrant/sh/iojs.sh

# Do some fun sym linking
sudo -u root bash /vagrant/sh/npm_link.sh

# sudo -u vagrant bash touch /etc/vagrant-provisioned

echo "--------------------------------------------------"
echo "Your vagrant instance is running at: 192.168.33.10"