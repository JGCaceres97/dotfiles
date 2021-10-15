#!/bin/bash

## Colors
COLOR1='\033[1;36m'
COLOR2='\033[0;37m'
COLOR3='\033[1;32m'
COLOR4='\033[1;31m'
NC='\033[0m'

echo -e "${COLOR1}### Updating system...${NC}"
sudo pacman -Syyu --noconfirm

### GIT ###
echo -e "\n${COLOR1}### Installing requirements...${NC}"
sudo pacman -S git base-devel --noconfirm --needed

echo -e "\n${COLOR1}### Configuring Git...${NC}"
echo -e "\n${COLOR2}Enter the global username for Git:${NC}";
read GITUSER;
git config --global user.name "${GITUSER}"

echo -e "\n${COLOR2}Enter the global email for Git:${NC}";
read GITEMAIL;
git config --global user.email "${GITEMAIL}"

echo -e "\n${COLOR3}Requirements has been installed!${NC}"

### YAY ###
echo -e "\n${COLOR1}### Installing Yay...${NC}"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ..
rm -rf yay

echo -e "\n${COLOR3}Yay has been installed!${NC}"

### PACKAGES ###
echo -e "\n${COLOR1}### Installing packages and setting config...${NC}"
git clone https://github.com/JGCaceres97/dotfiles.git

yay -S alacritty chromium chromium-widevine fish fisher gnome-disk-utility gparted mpv neofetch nerd-fonts-fira-code noto-fonts-emoji nvm powerline powerline-fonts starship ulauncher visual-studio-code-bin youtube-dl --noconfirm --nocleanmenu --nodiffmenu --noeditmenu --removemake --clean --needed

chsh -s /bin/fish
fisher add edc/bass

echo -e "\n${COLOR4}### Dotfiles has been installed! Press any key to exit.";
read KEY;
exit
