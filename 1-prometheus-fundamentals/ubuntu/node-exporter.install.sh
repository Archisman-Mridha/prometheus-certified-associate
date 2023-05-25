sudo useradd --no-create-home --shell /bin/false node_exporter

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz &&
  tar xvf node_exporter-1.5.0.linux-amd64.tar.gz &&
  rm node_exporter-1.5.0.linux-amd64.tar.gz

cd ./node_exporter-1.5.0.linux-amd64

sudo cp node_exporter /usr/local/bin &&
  sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

cd ../ &&
  rm -rf ./node_exporter-1.5.0.linux-amd64

# Binary
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Configuration file
sudo mkdir /etc/node_exporter
sudo cp node-exporter.crt /etc/node_exporter &&
  sudo cp node-exporter.key /etc/node_exporter
sudo cp node-exporter.config.yaml /etc/node_exporter
sudo chown -R node_exporter:node_exporter /etc/node_exporter

# SystemD service file
sudo cp ./node-exporter.service /etc/systemd/system/node-exporter.service

sudo systemctl daemon-reload &&
  sudo systemctl start node-exporter &&
  sudo systemctl enable node-exporter
sudo systemctl status node-exporter