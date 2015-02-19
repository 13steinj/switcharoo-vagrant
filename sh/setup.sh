#!/usr/bin/env bash

green=`tput setaf 2`
reset=`tput sgr0`

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
dir="$dir/.."
org=reddit
srcpath=src
baserepo=switcharoo
repos=(
  switcharoo-plugin-ads
  switcharoo-plugin-core
  switcharoo-plugin-metrics
  react-mutator
  snoode
)

git clone git@github.com:${org}/${baserepo}.git ${dir}/${srcpath}/${baserepo}

( cd ${dir}/${srcpath}/${baserepo} && git submodule update --init --recursive ) &
( cd ${dir}/${srcpath}/${baserepo} && npm install ) &

for i in "${repos[@]}"
do
  ( 
    git clone git@github.com:${org}/${i}.git ${dir}/${srcpath}/${i} && 
    cd ${dir}/${srcpath}/${i} && 
    npm install
    # comment the line above and uncomment the three below
    # to set up reddit-mobile locally instead of with Vagrant
    # npm install && 
    # cd ${dir}/${srcpath}/${baserepo} && 
    # npm link ${dir}/${srcpath}/${i} 
  ) &
done

wait

( cd ${dir}/${srcpath}/${baserepo} && npm run build )

echo "${green}Cloned repos, installed npm dependencies, linked node dependencies, and built the project.${reset}"
echo "${green}Run vagrant up to start your VM and run reddit from inside the VM to start the server.${reset}"