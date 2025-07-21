# SolarNetwork Grafana Data Source package

On Debian 12 systems, run the [util/setup-deb12.sh](util/setup-deb12.sh) script to build the plugin.
Then:

```sh
make DIST=bookworm
```

> :tip: **Note** that the package will be for all architectures, but only `arm64` and `amd64` are
> actually supported.

> :warning: **Note** that the plugin build requires a few GB of disk space to complete.
