#!/bin/bash

BLUE='\e[34m'
GREEN='\e[32m'
RED='\e[31m'
ENDCOLOR='\e[0m'
AURHELPER="yay"

echo -e $GREEN"██████╗  ██████╗ ███████╗████████╗    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
██╔══██╗██╔═══██╗██╔════╝╚══██╔══╝    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
██████╔╝██║   ██║███████╗   ██║       ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
██╔═══╝ ██║   ██║╚════██║   ██║       ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
██║     ╚██████╔╝███████║   ██║       ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
╚═╝      ╚═════╝ ╚══════╝   ╚═╝       ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝"$ENDCOLOR

echo

echo "Starting post-install script... AUR helper will be installed first."


read -p "$(echo -e "Install "$RED"Yay "$ENDCOLOR"using git?(y/n)"$ENDCOLOR)" choice
if [ ! -d ~/repo ] ; then
mkdir ~/repo
else 

echo -e $BLUE"~/repo"$ENDCOLOR" already exists."

fi

if [ "$choice" = "y" ]; then
echo -e "Installing "$RED"git "$ENDCOLOR"and "$RED"base-devel "$ENDCOLOR
    sudo pacman -S --needed git base-devel
    cd ~/repo
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ~/repo
fi

read -p "$(echo -e "Do quick install??"$RED"THIS INCLUDES CHROMEBOOK RELATED STUFF"$ENDCOLOR"(y/n)")" choice

if [ "$choice" = "y" ]; then 
    cd ~/repo
    git clone https://github.com/WeirdTreeThing/chromebook-linux-audio.git
    cd chromebook-linux-audio
    ./setup-audio
    cd ~/repo
    git clone https://github.com/WeirdTreeThing/cros-keyboard-map
    cd cros-keyboard-map
    ./install.sh
    cd ~/repo
    yay -Syyu
    yay -S gum rsync
    git clone https://github.com/mylinuxforwork/dotfiles.git
    cd dotfiles/bin
    ./ml4w-hyprland-setup
elif [ "$choice" = "n" ]; then

read -p "$(echo -e "Install "$BLUE"ML4W"$ENDCOLOR" using AUR(1) or GIT(2)?"$FAINT"(1/2/n)"$ENDCOLOR)" choice

if [ "$choice" = "1" ]; then
echo -e "Installing "$BLUE"ML4W"$ENDCOLOR"using"$GREEN"AUR"$ENDCOLOR
    yay -Syyu 
    yay -S ml4w-hyprland-git
    ml4w-hyprland-setup

fi
if [ "$choice" = "2" ]; then
echo -e "Installing "$BLUE"ML4W "$ENDCOLOR"using "$GREEN"Git"$ENDCOLOR"."
    yay -Syyu
    yay -S gum rsync
    git clone https://github.com/mylinuxforwork/dotfiles.git
    cd dotfiles/bin
    ./ml4w-hyprland-setup
fi

fi

