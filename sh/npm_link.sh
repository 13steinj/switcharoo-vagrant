#!/usr/bin/env bash

base_path=/vagrant/src/switcharoo

# This loads nvm
export NVM_DIR="/home/vagrant/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

for plugin in ${@} ; do
  ( cd ${base_path} && npm link ${base_path}/../${plugin} ) &
done

wait

echo "npm linked all src files"
