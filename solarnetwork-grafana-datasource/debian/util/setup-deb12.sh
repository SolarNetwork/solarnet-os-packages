#!/bin/sh

# Set up a Debian 12 system to build the package, then build it. util/build-docker.sh does the
# same in a container.

# might need to hold kernel packages, e.g.
# apt-mark hold 'linux-image*'

# install requirements
apt update
apt install -y git build-essential make curl ruby ruby-dev

# install FPM
gem install --no-document fpm

# install NVM and node 22
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 22

# install Go and mage
curl -fsSL "https://go.dev/dl/go1.24.4.linux-$(dpkg --print-architecture).tar.gz" | tar -C /usr/local -xz
export PATH=/usr/local/go/bin:$HOME/go/bin:$PATH GOTOOLCHAIN=local
go install github.com/magefile/mage@v1.15.0

# clone package repo
git clone https://github.com/SolarNetwork/solarnet-os-packages.git
cd solarnet-os-packages
git switch develop
cd solarnetwork-grafana-datasource/debian

# use custom temp dir because /tmp an run out of space
export GOTMPDIR="/var/tmp"

# build the plugin (at PLUGIN_GIT_REF in the Makefile) and the package
make plugin deb DIST=bookworm
