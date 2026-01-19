# SolarFlux Authorization VerneMQ Webhook

TODO

## Configure native build

The `production` profile will be enabled during the AOT phase of the native build. The logging
configuration will be compiled into the native application, so you must configure production logging
settings in a `solarflux-vernemq-webhook/application-production.yml` with logging that points to
`solarflux-vernemq-webhook/logging-production.xml`.

You can also create a `solarflux-vernemq-webhook/native-build.args` file for any custom native
build arguments, e.g.

```
--enable-native-access=ALL-UNNAMED
-O3
-R:MaxHeapSize=128m
-R:MinHeapSize=128m
```