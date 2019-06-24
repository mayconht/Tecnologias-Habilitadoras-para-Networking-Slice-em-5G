echo "Installing Docker"
sudo apt update
sudo apt upgrade
sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
sudo systemctl start docker

echo "Installing Uploader"
sudo git clone https://github.com/mayconht/Projeto_Final
cd Projeto_Final
cd Uploader
sudo docker build -t uploader:latest .
sudo sudo docker run -d -p 5000:5000 uploader:latest



