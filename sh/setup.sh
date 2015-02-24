#!/usr/bin/env bash

green=`tput setaf 2`
reset=`tput sgr0`

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
dir="$dir/.."

if [[ "$1" = /* ]]; then
  path=${1}
else
  path=${dir}/${1}
fi

echo $path - $2

if [ -n "$1" ]; then
  if [ -d "$path" ]; then
    echo "Exists. Skipping."
  else
    if [ "$2" == "false" ]; then
      echo "${1} has no remote repo. Skipping."
    else
      echo "Cloning https://github.com/${2}.git to ${path}"
      mkdir -p ${path}
      git clone --recursive https://github.com/${2}.git ${path}

      # This loads nvm
      export NVM_DIR="/home/vagrant/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
      echo $path
      ( cd ${path} && npm install )
    fi
  fi
else
  echo "setup.sh got an empty local path" 1>&2
  exit 1
fi