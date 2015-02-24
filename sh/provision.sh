#!/usr/bin/env bash

if [[ "$5" = /* ]]; then
  SWITCHAROO_BASE_SRC_PATH=${5}
else
  SWITCHAROO_BASE_SRC_PATH=/vagrant/${5}
fi

SWITCHAROO_LOCAL_PATHS=$1
SWITCHAROO_LOCAL_REPOS=$2
SWITCHAROO_HOSTNAME=$3
SWITCHAROO_ENGINE=$4
# SWITCHAROO_BASE_SRC_PATH=$5
SWITCHAROO_BASE_GITHUB_REPO=$6

IFS=' ' read -a local_paths <<< "$SWITCHAROO_LOCAL_PATHS"
IFS=' ' read -a local_repos <<< "$SWITCHAROO_LOCAL_REPOS"

if [ ${#local_repos[@]} -ne ${#local_paths[@]} ]; 
then
  echo "Your :local key in your vagrant_config.yml file is malformatted. It doesn't allow nil values nor any spaces anywhere." 1>&2 
  exit 1
fi

# # Change the hostname so we can easily identify what environment we're on:
# echo ${SWITCHAROO_HOSTNAME} > /etc/hostname

# # Update /etc/hosts to match new hostname to avoid "Unable to resolve hostname" issue:
# echo "127.0.0.1 ${SWITCHAROO_HOSTNAME}" >> /etc/hosts

# # Use hostname command so that the new hostname takes effect immediately without a restart:
# hostname ${SWITCHAROO_HOSTNAME}

# # Install core components
# sudo -u root bash /vagrant/sh/core.sh

# # Install engine
# sudo su - vagrant /vagrant/sh/engine.sh ${SWITCHAROO_ENGINE}

# # Ensure existance or go get all the necessary repos
# sudo su - vagrant /vagrant/sh/setup.sh "${SWITCHAROO_BASE_SRC_PATH}" "${SWITCHAROO_BASE_GITHUB_REPO}" &
# for i in "${!local_paths[@]}"; do 
#   sudo su - vagrant /vagrant/sh/setup.sh "${local_paths[$i]}" "${local_repos[$i]}" &
# done

# wait

# echo "Finished setup.sh. Starting npm_link.sh."

# Do some fun sym linking
for i in "${!local_paths[@]}"; do 
  sudo su - vagrant /vagrant/sh/npm_link.sh ${SWITCHAROO_BASE_SRC_PATH} ${local_paths[$i]} &
done

wait

echo "Finished npm_link.sh. Building the primary repo.";

export NVM_DIR="/home/vagrant/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
( cd ${SWITCHAROO_BASE_SRC_PATH} && npm run build );

echo "--------------------------------------------------"
echo "Finished provisioning."