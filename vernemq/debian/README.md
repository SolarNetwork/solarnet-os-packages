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

To include a custom Erlang runtime, build Erlang/OTP from source and add it to your `PATH`, for
example:

```
git clone https://github.com/erlang/otp.git
cd otp
git checkout OTP-24.2.2
./configure --prefix=$PWD/../erlang
make -j 4 && make install
cd ..
export PATH=$PWD/erlang/bin:$PATH
```

You must then check out the VerneMQ source into a `vernemq` directory within this directory:

```sh
git clone https://github.com/vernemq/vernemq.git
```

# Building

Run `make` to build the package, which will produce `vernemq_VERSION_PLATFORM.deb` in
this directory.
