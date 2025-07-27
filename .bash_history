cd ~
ls
sudo nano scripts/install_kubernetes
mv scripts/install_kubernetes scripts/install_kubernetes.sh
sudo chmod 755 scripts/intall_kubernetes.sh
ls scripts/
sudo nano scripts/install_kubernetes.sh 
sudo chmod 755 scripts/install_kubernetes.sh 
ls scripts/
exit
cd ~
sudo apt update
sudo apt upgrade -y
ls
mkdir my_scrips
mv my_scrips/ ./scripts
ls
touch scripts/install-docker.sh
chmod 755 scripts/install-docker.sh 
sudo nano scripts/install-docker.sh 
bash scripts/install-docker.sh 
exit
