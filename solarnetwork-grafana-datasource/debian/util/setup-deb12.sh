#!/bin/sh

# might need to hold kernel packages, e.g.
# apt-mark hold linux-image-rpi-v8 linux-image-rpi-2712 linux-image-6.12.25+rpt-rpi-v8 linux-image-6.12.25+rpt-rpi-2712


# make pytyon2 from Debian 11 available
echo 'deb http://archive.debian.org/debian/ bullseye main' >>/etc/apt/sources.list
apt update

# install requirements
apt install git build-essential make golang npm python2

# make python2 the default
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

# install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# switch to node 14
nvm install 14

# install mage
mkdir -p ~/go
git clone https://github.com/magefile/mage
cd mage
export PATH=$PATH:~/go/bin

cd ..

# clone plugin repo
git clone https://github.com/SolarNetwork/solarnetwork-grafana-datasource.git

# switch desired version
cd solarnetwork-grafana-datasource
git checkout 2.0.0

# install node deps
npm ci

# use custom temp dir because /tmp an run out of space
export GOTMPDIR="/var/tmp"

# build
npm run build
