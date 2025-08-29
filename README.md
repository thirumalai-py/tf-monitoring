# tf-monitoring
End-to-End MERN Application Deployment and Monitoring with Terraform, Ansible, Prometheus, and Grafana


ansible-playbook -i inventory.ini site.yml

## 🛠 Install Prometheus on EC2 (Ubuntu/Debian)

**1. Download Prometheus**

```
cd /opt
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.54.1/prometheus-2.54.1.linux-amd64.tar.gz
sudo tar xvf prometheus-2.54.1.linux-amd64.tar.gz
sudo mv prometheus-2.54.1.linux-amd64 prometheus
```

**2. Create Prometheus user** 
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus /var/lib/prometheus


**3. Move binaries**

cd /opt/prometheus
sudo cp prometheus promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool
sudo cp -r consoles/ console_libraries/ /etc/prometheus/
sudo chown -R prometheus:prometheus /etc/prometheus


## ⚙️ Configure Prometheus

Create config file:

`sudo nano /etc/prometheus/prometheus.yml`

```
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'backend'
    static_configs:
      - targets: ['localhost:4000']   # <- your Node.js backend /metrics port
```

## 🖥 Create Systemd Service

`sudo nano /etc/systemd/system/prometheus.service`

```
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file /etc/prometheus/prometheus.yml \
  --storage.tsdb.path /var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
```

**🚀 Start Prometheus**

sudo systemctl daemon-reexec
sudo systemctl enable prometheus
sudo systemctl start prometheus

systemctl status prometheus
