#!/bin/bash

# Install useful tools
apt-get update
apt-get install -y wget git curl vim

# Symlink settings
ln -s /vagrant/config/.bash_profile /home/vagrant/.bash_profile
