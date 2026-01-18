#!/bin/sh

PKG_HOLD="${PKG_HOLD:-linux-image*}"
PKG_BRANCH="${PKG_BRANCH:-develop}"
DS_BRANCH="${DS_BRANCH:-develop}"
NODE_VERSION="${NODE_VERSION:-18}"

# might need to hold kernel packages, e.g.
if [ -n "$PKG_HOLD" ]; then
	apt-mark hold "$PKG_HOLD"
fi

# make pytyon2 from Debian 11 available
echo 'deb http://archive.debian.org/debian/ bullseye main' >>/etc/apt/sources.list
apt update

# install requirements
apt install -y git build-essential make golang npm python2 ruby ruby-dev

# make python2 the default
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

# install FPM
gem install --no-document fpm

# install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# switch to specific node
nvm install $NODE_VERSION

# install mage
mkdir -p ~/go
git clone https://github.com/magefile/mage
cd mage
go run bootstrap.go
export PATH=$PATH:~/go/bin

cd ..

# clone package repo
git clone https://github.com/SolarNetwork/solarnet-os-packages.git
cd solarnet-os-packages
git switch "${PKG_BRANCH}"
cd solarnetwork-grafana-datasource/debian

# clone plugin repo
git clone https://github.com/SolarNetwork/solarnetwork-grafana-datasource.git

# switch desired version
cd solarnetwork-grafana-datasource
git checkout "${DS_BRANCH}"

# install node deps
npm ci

# use custom temp dir because /tmp an run out of space
export GOTMPDIR="/var/tmp"

# build plugin
npm run build
mage

# build package
cd ..
make DIST=trixie
