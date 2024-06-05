#!/bin/bash
sudo su 
xfce4-mouse-settings

sudo apt-get update -y
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y 
sudo apt install brave-browser -y 

sudo apt-get install tldr
sudo apt-get install gobuster

sudo gobuster

wget -p ../../../home/kali/Downloads https://vscode.download.prss.microsoft.com/dbazure/download/stable/e170252f762678dec6ca2cc69aba1570769a5d39/code_1.88.1-1712771838_amd64.deb
wget -P ../../../home/kali/Downloads https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.12/obsidian_1.5.12_amd64.deb

cd ../../../home/kali/Downloads 

sleep 2s
sudo dpkg -i *.deb

brave-browser --new-window discord.com/login
brave-browser --new-window app.hackthebox.com
brave-browser --new-window academy.hackthebox.com
brave-browser --new-window discord.com/login
