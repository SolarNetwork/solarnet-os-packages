# VerneMQ package

This directory contains support for building the `vernemq` package for Debian Linux OS.

# Build requirements

The following software must be installed before building:

 * `build-essential`
 * `git`
 * `libsnappy-dev`
 
The following software must be installed before packaging:

 * `ruby`
 * `ruby-dev`

Additionally the `fpm` Ruby gem must be installed.

For example:

```sh
sudo apt-get install ruby ruby-dev build-essential git libsnappy-dev
sudo gem install --no-ri --no-rdoc fpm
```

You must then check out the VerneMQ source into a `vernemq` directory within this directory:

```sh
git clone https://github.com/vernemq/vernemq.git
```

# Building

Run `make` to build the package, which will produce `vernemq_VERSION_PLATFORM.deb` in
this directory.
