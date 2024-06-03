#!/bin/bash

xfce4-mouse-settings

# Color Variables
yellow='\033[0;33m'
bg_red='\033[0;41m'

echo -e "${yellow}SETTING UP MOUSE${clear}!"

sudo apt-get update -y 

echo -e "${red}INSTALLING BRAVE${clear}!"

sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y 
sudo apt install brave-browser -y 

echo -e "${red}INSTALLING VS-CODE${clear}!"

wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/e170252f762678dec6ca2cc69aba1570769a5d39/code_1.88.1-1712771838_amd64.deb
sleep 2s
sudo dpkg -i *.deb


echo -e "${red}INSTALLING NODE & NPM${clear}!"


sudo apt-get install npm -y && sudo apt-get install node -y  
npm -v && node -v
sudo su 
npm install vite
npm install serve
sleep 2s

echo -e "${red}INSTALLING MOTION CANVAS${clear}!"

git clone https://github.com/NGsHjodra/motion_canvas_projects.git
git clone https://github.com/Thomsr/sorting-animations.git
git clone https://github.com/motion-canvas/examples.git
git clone https://github.com/ksassnowski/videos.git

sudo npm init @motion-canvas@latest