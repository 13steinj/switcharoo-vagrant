#!/usr/bin/env bash

base_path=$1

if [[ "$2" = false ]]; then
  echo "Skipping.";
  exit 0;
elif [[ "$2" = /* ]]; then
  link_path=${2}
else
  link_path=/vagrant/${2}
fi

# This loads nvm
export NVM_DIR="/home/vagrant/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
echo "BASE ${base_path} - LOCAL ${link_path}" 
( cd ${base_path} && npm link ${link_path} )
