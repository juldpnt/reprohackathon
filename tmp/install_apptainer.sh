sudo apt update
sudo apt install -y wget
cd /tmp
wget https://github.com/apptainer/apptainer/releases/download/v1.2.4/apptainer_1.2.4_amd64.deb
sudo apt install -y ./apptainer_1.2.4_amd64.deb