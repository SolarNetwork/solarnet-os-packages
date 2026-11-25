# SolarNetwork Grafana Data Source package

Installs the [SolarNetwork Grafana data source][plugin] plugin.

# Building

Build with Docker:

```sh
util/build-docker.sh bookworm
```

Or on a Debian 12 system, run the [util/setup-deb12.sh](util/setup-deb12.sh) script. If you already
have `node` 22, `go`, `mage` and `fpm`, run:

```sh
make plugin deb DIST=bookworm
```

> :tip: **Note** that the package is for all architectures, but only `arm64` and `amd64` are
> actually supported.

> :warning: **Note** that the plugin build requires a few GB of disk space to complete.

[plugin]: https://github.com/SolarNetwork/solarnetwork-grafana-datasource
