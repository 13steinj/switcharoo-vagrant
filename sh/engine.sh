#!/usr/bin/env bash

# Get, install, and configure nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

# This loads nvm
export NVM_DIR="/home/vagrant/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install ${1}
nvm alias default ${1}