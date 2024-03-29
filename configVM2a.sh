red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
echo "${red}Este Programa foi criado pelo: ${green}Grupo 4 ${reset}"

echo "${green}Installing Docker${reset}"
sudo apt update
sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io
sudo apt -y install docker-compose
sudo usermod -aG docker $USER
sudo systemctl start docker

cd ~

echo "${green}Instalando o Node Exporter${reset}"
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar xvfz node_exporter-0.18.1.linux-amd64.tar.gz
sudo mv node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin/
sudo useradd -rs /bin/false node_exporter
sudo chmod -R 777 /etc/systemd/system/
cd /etc/systemd/system/
wget https://raw.githubusercontent.com/mayconht/Projeto_Final/master/Prometheus/node_exporter.service
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

cd ~

echo "${green}Instalando Grafana${reset}"
curl https://packagecloud.io/gpg.key | sudo apt-key add -
curl https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt-get update
sudo apt -y install grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

cd ~

echo "${green}Instalando o cadvisor Exporter${reset}"
sudo docker run --restart always \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor-VM2 \
  google/cadvisor:latest

echo "${green}Instalando Prometheus${reset}"
wget https://s3-eu-west-1.amazonaws.com/deb.robustperception.io/41EFC99D.gpg | sudo apt-key add -
apt-get update
apt -y install prometheus prometheus-node-exporter prometheus-pushgateway prometheus-alertmanager
sudo systemctl stop prometheus
sudo chmod -R 777 /etc/prometheus/
cd /etc/prometheus/
sudo rm -rf prometheus.yml
wget https://raw.githubusercontent.com/mayconht/Projeto_Final/master/Prometheus/prometheus.yml
wget https://raw.githubusercontent.com/mayconht/Projeto_Final/master/Prometheus/docker-compose.yml
sudo systemctl start prometheus
sudo systemctl enable prometheus

# echo "${green}Instalando PostgreSQL${reset}"
# sudo docker pull postgres
# sudo docker run  --name PostgreSQL --restart always -d -p 5432:5432 -e POSTGRES_PASSWORD=docker postgres


echo "${green}Instalando MongoDB${reset}"
sudo docker pull mongo
sudo docker run --name MongoDB --restart always -d -p 27017-27019:27017-27019 mongo
