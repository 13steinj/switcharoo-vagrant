#!/usr/bin/env bash

cd /home/vagrant/

wget -q "https://iojs.org/dist/v1.2.0/iojs-v1.2.0-linux-x64.tar.gz"
# wget -q https://iojs.org/dist/v1.2.0/SHASUMS256.txt
# grep iojs-v1.2.0-linux-x64.tar.gz SHASUMS256.txt | sha256sum -c -

tar xvzf iojs-v1.2.0-linux-x64.tar.gz
sudo ln -s /home/vagrant/iojs-v1.2.0-linux-x64/bin/iojs /usr/local/bin/node
sudo ln -s /home/vagrant/iojs-v1.2.0-linux-x64/bin/iojs /usr/local/bin/iojs
sudo ln -s /home/vagrant/iojs-v1.2.0-linux-x64/bin/npm /usr/local/bin/npm

rm iojs-v1.2.0-linux-x64.tar.gz
