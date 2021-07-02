cd
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
source ~/.profile

sudo add-apt-repository ppa:jonathonf/ffmpeg-4
sudo apt update
sudo apt install ffmpeg -y
ffmpeg -version

sudo apt install nodejs
npm install express
npm install --save cors
