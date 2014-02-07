# Lux

Lux shines a light on your systems.

Used collectd? Used sensu? Bit like them.

*Nota bene*: Lux is currently pre-release. This README should be treated as part proposal, and not purely documentation - anything described below may not work correctly, be finished, or even exist, 'til version 1.

## Details

Run lux-client on each of your nodes. It runs "metrics" and "checks" sending data to your graphite instance and to your lux-server.

Run lux-server on a single node. It monitors a queue for check data. It emits alerts based on check status, providing an API and dashboard for monitoring these.

### Checks

A check is a standalone program. It should emit descriptive free-text data to stdout, and indicate check status via its [return code](https://en.wikipedia.org/wiki/Exit_status), where `0` is `OK`, `1` is `WARNING`, `2` is `CRITICAL`. 
The aim is for compatibility with [Nagios plugins](http://nagios.sourceforge.net/docs/3_0/pluginapi.html) and [Sensu checks](http://sensuapp.org/docs/0.11/checks).

### Metrics

A "metric" is a standalone program. It should emit text to stdout in the following format:

```
dot.separated.metric.name.suffix value
```

If you've used Graphite, this may feel familiar.
