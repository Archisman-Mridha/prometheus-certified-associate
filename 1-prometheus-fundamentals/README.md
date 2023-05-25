#  Prometheus Fundamentals

> Prometheus is **used to collect metrics data from multiple sources and present all of that data in a single place using the built in Prometheus dashboard**.

> Prometheus also **has built in alert triggering system** - it can track various metrics and when those metrics pass their thresholds, Prometheus will trigger alerts. The alert will then be sent by Prometheus Alert Manager integrated with various different notifiers (Email, Slack, SMS etc.).

An application needs to expose its metrics data at some HTTP endpoint. **This metrics data needs to be in a specific format that Prometheus understands**. The application metrics is then pulled by Prometheus from that endpoint. Prometheus then stores the scraped metrics in a time series database which can be queried using PromQL (Prometheus' built in query language).

> Prometheus is designed to monitor numeric time-series data only. We shouldn't monitor stuff like events, system logs and traces using Prometheus.

You can view the architecture of Prometheus here - https://prometheus.io/docs/introduction/overview/#architecture.

## Running Prometheus and node-exporter in Ubuntu

> Aim - Install Prometheus on your Ubuntu machine. Make Prometheus run as a SystemD unit so that it is automatically started on boot and keeps running in the background. Run Prometheus node-exporter in the same way. Configure Prometheus to pull metrics from this node-exporter. Communication between Prometheus and the node-exporter should be verified and encrypted.

You can find the files [here](./1-prometheus-fundamentals/ubuntu).

This is the command I used to generate the self-signed certificate -
```sh
sudo openssl req -new \
  -newkey rsa:2048 \
  -days 365 \
  -nodes \
  -x509 \
  -keyout node-exporter.key -out node-exporter.crt \
  -subj "/C=US/ST=California/L=Oakland/O=MyOrg/CN=localhost" -addext "subjectAltName = DNS:localhost"
```
And this is the one I have used to generate the hashed password -
```sh
sudo apt install apache2-utils &&
  htpasswd -nBC 12 "" | tr -d ':\n'
```

- The Prometheus dashboard will be available at *http://localhost:9090/*.
- Machine metrics (in the format which Prometheus understands) will be available at *http://localhost:9100/metrics*.