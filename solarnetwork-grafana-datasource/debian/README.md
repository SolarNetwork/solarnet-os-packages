# SolarNetwork Grafana Data Source package

On Debian 12 systems, run the [util/setup-deb12.sh](util/setup-deb12.sh) script to build the plugin.
You can customize various aspects by setting environment variables, for example:

```sh
PKG_BRANCH=feature/grafana9 DS_BRANCH=feature/grafana9 NODE_VERSION=18 ./setup-deb12.sh
```

Then run the following to build the package:

```sh
make DIST=bookworm
```

> :tip: **Note** that the package will be for all architectures, but only `arm64` and `amd64` are
> actually supported.

> :warning: **Note** that the plugin build requires a few GB of disk space to complete.
