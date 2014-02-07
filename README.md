# Lux

Lux shines a light on your systems.

Used collectd? Used sensu? Bit like them.

*Nota bene*: Lux is currently pre-release. This README should be treated as part proposal, and not purely documentation - anything described below may not work correctly, be finished, or even exist, 'til version 1.

## Details

Run lux-client on each of your nodes. It runs plugins which aggregate system data, then sends metrics and health status to your graphite instance and to your lux-server.

Run lux-server on a single node. It monitors a queue for check data. It emits alerts based on check status, providing an API and dashboard for monitoring these.

## Plugins

Lux supports multiple types of plugin, for easy integration with existing systems.

### Nagios Plugins

The aim is for compatibility with [Nagios plugins](http://nagios.sourceforge.net/docs/3_0/pluginapi.html) and [Sensu checks](http://sensuapp.org/docs/0.11/checks).

### Collectd Plugins

### Munin Plugins

### Lux Standalone Plugins

A standalone plugin is, much like a Nagios plugin, an independent runnable, written in any appropriate language, that conforms to the following specification:

1. It exits with one of the following [return codes](https://en.wikipedia.org/wiki/Exit_status) to signify health status:
    * `0` for `OK`
    * `1` for `WARNING`
    * `2` for `CRITICAL`
2. It emits descriptive and/or metric data to `stdout` in the following format:

TODO

Short desc
Longer
met.ric value

/[A-Za-z.]+ \d+(\.\d+)?/

### Lux Internal Plugins

TODO Haskell libraries
