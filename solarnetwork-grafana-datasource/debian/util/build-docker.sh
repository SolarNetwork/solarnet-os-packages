#!/bin/sh
# Build the plugin and the package in a throwaway container with node 22, Go, mage and fpm.
# Run from the debian directory: util/build-docker.sh [DIST]
set -eu
DIST="${1:-bookworm}"
exec docker run --rm -v "$PWD":/work -w /work \
	-e DIST="$DIST" -e HOST_UID="$(id -u)" -e HOST_GID="$(id -g)" \
	node:22-bookworm sh -euc '
	apt-get update -qq
	apt-get install -y -qq --no-install-recommends ruby ruby-dev build-essential curl git >/dev/null
	gem install --no-document fpm >/dev/null
	curl -fsSL "https://go.dev/dl/go1.24.4.linux-$(dpkg --print-architecture).tar.gz" | tar -C /usr/local -xz
	export PATH=/usr/local/go/bin:/root/go/bin:$PATH GOTOOLCHAIN=local GOTMPDIR=/var/tmp
	go install github.com/magefile/mage@v1.15.0
	git config --global --add safe.directory "*"
	make plugin deb DIST="$DIST"
	chown -R "$HOST_UID:$HOST_GID" /work'
