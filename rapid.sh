#!/bin/bash

export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

# Banner Function
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
RESET='\033[0m'

# Define installation commands
CODE="sudo apt install code-oss"
TLDR="sudo apt-get install -y tldr"
EXIFTOOL="sudo apt-get install -y exif"
NPM="npm -y"
NODE="node -y"

# Define categories with corresponding commands
declare -A categories=(	
  ["General Programming"]="$CODE; install_software"
  ["Machine"]="$TLDR $EXIFTOOL"
  ["Git"]="setup_git"
  ["Motion"]="$NPM $NODE; install_canvas"
)

# Function to display banner
function display_banner() {
  echo -e "${RED}██████╗  █████╗ ██████╗ ██╗ ███████═╗${RESET}"
  echo -e "${GREEN}██╔══██╗██╔══██╗██╔══██╗██║ ██╔═══██║${RESET}"
  echo -e "${YELLOW}██████╔╝███████║██████╔╝██║ ██║   ██║${RESET}"
  echo -e "${BLUE}██╔══██║██╔══██║██╔═══╝ ██║ ██║   ██║${RESET}"
  echo -e "${MAGENTA}██║  ██║██║  ██║██║     ██║ ███████╔╝${RESET}"
  echo -e "${CYAN}╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚══════╝${RESET}"
  echo -e "${WHITE}                                           ${RESET}"
  echo -e "${MAGENTA}███████╗ ██████╗██████╗ ██╗ ██████╗ ████████╗███████╗${RESET}"
  echo -e "${CYAN}██╔════╝██╔════╝██╔══██╗██║ ██╔══██╗╚══██╔══╝██╔════╝${RESET}"
  echo -e "${RED}███████╗██║     ██████╔╝██║ ██████╔╝   ██║   ███████╗${RESET}"
  echo -e "${GREEN}╚════██║██║     ██╔══██╗██║ ██╔═══╝    ██║   ╚════██║${RESET}"
  echo -e "${YELLOW}███████║╚██████╗██║  ██║██║ ██║        ██║   ███████║${RESET}"
  echo -e "${BLUE}╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝ ╚═╝        ╚═╝   ╚══════╝${RESET}"
  echo -e "${WHITE}                                           ${RESET}"
}

# Function to display menu
function show_menu() {
  echo -e "${GREEN}Select a category:${RESET}"
  local i=1
  for category in "${!categories[@]}"; do
    echo -e "${YELLOW}$i) $category${RESET}"
    ((i++))
  done
}

# Function to check if a package is installed
function is_installed() {
  local package="$1"
  dpkg -s "$package" &> /dev/null
}

# Function to install software (General Programming)
function install_software() {
  xfce4-mouse-settings
  sudo apt install code-oss
  sudo apt-get update
  sudo wget -P ../../../home/kali/Downloads/ --no-check-certificate "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.3/obsidian_1.6.3_amd64.deb"
  cd ../../../home/kali/Downloads/
  sudo dpkg -i *.deb

  sudo apt install curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install brave-browser

  brave-browser --new-window discord.com/login
  brave-browser --new-window app.hackthebox.com
  brave-browser --new-window academy.hackthebox.com

  #sudo apt-get -f install -y
}

function setup_git() {
  read -p "Enter your email for Git: " get_email
  sudo git config --global user.email "$git_email"
}

# Function to install Motion Canvas projects
function install_canvas() {
  npm -y 
  node -y
  cd ../../../home/kali/Documents/ 
  sudo git clone https://github.com/NGsHjodra/motion_canvas_projects.git
  sudo git clone https://github.com/Thomsr/sorting-animations.git
  sudo git clone https://github.com/motion-canvas/examples.git
  sudo git clone https://github.com/ksassnowski/videos.git
  sudo npm init @motion-canvas@latest -y
}

# Function to install selected programs
function install_programs() {
  local choice=$1
  local i=1
  for category in "${!categories[@]}"; do
    if [[ $i -eq $choice ]]; then
      echo -e "${BLUE}Installing programs for $category...${RESET}"
      if [[ $category == "General Programming" ]]; then
        install_software
      elif [[ $category == "Motion" ]]; then
        install_canvas
      elif [[ $category == "Git" ]]; then
        setup_git
      else
        local programs="${categories[$category]}"
        for program in $programs; do
          if is_installed "$program"; then
            echo -e "${YELLOW}$program is already installed.${RESET}"
          else
            echo -e "${GREEN}Installing $program...${RESET}"
            sudo apt-get install -y "$program"
          fi
        done
      fi
      return 0
    fi
    ((i++))
  done
  echo -e "${RED}Invalid choice. Please run the script again and select a valid option.${RESET}"
  return 1
}

# Main script
clear
display_banner
show_menu
read -p "$(echo -e ${CYAN}'Enter your choice: '${RESET})" user_choice

# Validate user input
if [[ ! $user_choice =~ ^[0-9]+$ ]] || [[ $user_choice -lt 1 ]] || [[ $user_choice -gt ${#categories[@]} ]]; then
  echo -e "${RED}Invalid input. Please run the script again and select a valid option.${RESET}"
  exit 1
fi

# Install selected programs
install_programs "$user_choice" && echo -e "${GREEN}Installation complete.${RESET}"
