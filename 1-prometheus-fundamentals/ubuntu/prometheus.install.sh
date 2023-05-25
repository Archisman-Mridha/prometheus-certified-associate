# Creating a user called prometheus.
# --no-create-home specifies that there is no need to create a home directory for the user.
sudo useradd --no-create-home --shell /bin/false prometheus

# We will store the Prometheus configuration file here.
sudo mkdir /etc/prometheus &&
  sudo chown prometheus:prometheus /etc/prometheus
# And here all the data (in the time-series database) related to Prometheus will be stored.
sudo mkdir /var/lib/prometheus &&
  sudo chown prometheus:prometheus /var/lib/prometheus

wget https://github.com/prometheus/prometheus/releases/download/v2.44.0/prometheus-2.44.0.linux-amd64.tar.gz &&
  tar xvf prometheus-2.44.0.linux-amd64.tar.gz &&
  rm prometheus-2.44.0.linux-amd64.tar.gz

cd prometheus-2.44.0.linux-amd64

# Prometheus executable
sudo cp prometheus /usr/local/bin &&
  sudo chown prometheus:prometheus /usr/local/bin/prometheus
# Prometheus CLI tools
sudo cp promtool /usr/local/bin &&
  sudo chown prometheus:prometheus /usr/local/bin/promtool
# Prometheus Console related tools
sudo cp consoles /etc/prometheus &&
  sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo cp console_libraries /etc/prometheus &&
  sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

cd ../ &&
  rm -rf prometheus-2.44.0.linux-amd64

# Prometheus configuration file
sudo cp prometheus.yml /etc/prometheus &&
  sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
# TLS certificate encrypting the traffic between Prometheus and the node exporter
sudo cp node-exporter.crt /etc/prometheus &&
  sudo chown prometheus:prometheus /etc/prometheus/node-exporter.crt

# SystemD unit file for Prometheus
sudo cp ./prometheus.service /etc/systemd/system/prometheus.service

# Reload SystemD and enable Prometheus on startup.
sudo systemctl daemon-reload &&
  sudo systemctl start prometheus &&
  sudo systemctl enable prometheus
sudo systemctl status prometheus