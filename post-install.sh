#!/bin/bash

BLUE='\e[34m'
GREEN='\e[32m'
RED='\e[31m'
ENDCOLOR='\e[0m'
FAINT='\033[3m'
AURHELPER="yay"

echo -e $GREEN"
╔═╗┌─┐┌─┐┌┬┐  ╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  
╠═╝│ │└─┐ │   ║│││└─┐ │ ├─┤│  │  
╩  └─┘└─┘ ┴   ╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘"$ENDCOLOR

echo
echo "Starting post-install script... AUR helper will be installed first."
read -p "$(echo -e "Install "$RED"Yay "$ENDCOLOR"using git?"$FAINT"(y/n)"$ENDCOLOR)" choice
mkdir ~/repo
cd ~/repo
if [ "$choice" = "y" ]; then
echo -e "Installing "$RED"git "$ENDCOLOR"and "$RED"base-devel "$ENDCOLOR
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ~/repo
fi
echo
echo -e "To continue the post-install, "$RED"Dialog"$ENDCOLOR" is needed to provide a TUI."
sleep 2
read -p "$(echo -e "Install "$RED"ML4W"$ENDCOLOR" using AUR(1) or GIT(2)?"$FAINT"(1/2/n)"$ENDCOLOR)" choice
if [ "$choice" = "1" ]; then
echo -e "Installing "$RED"ML4W"$ENDCOLOR"using"$GREEN"AUR"$ENDCOLOR
    yay -Syu 
    yay -S ml4w-hyprland-git
fi
if [ "$choice" = "2" ]; then
echo -e "Installing "$RED"ML4W "$ENDCOLOR"using "$GREEN"Git"$ENDCOLOR"."
    yay -SYu
    git clone https://github.com/mylinuxforwork/dotfiles.git
    cd dotfiles/bin
    ./ml4w-hyprland-setup
fi
