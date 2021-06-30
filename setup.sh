cd
wget -q https://dl.google.com/go/go1.14.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.linux-amd64.tar.gz
rm go1.14.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc
echo 'export GOPATH=~/go' >> /root/.bashrc
source /root/.bashrc

sudo apt update
sudo apt install ffmpeg
ffmpeg -version

sudo apt install nodejs
