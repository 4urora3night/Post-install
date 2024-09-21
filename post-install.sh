#!/bin/bash

BLUE='\e[34m'
GREEN='\e[32m'
RED='\e[31m'
ENDCOLOR='\e[0m'
AURHELPER="yay"

echo -e $GREEN"
██████╗  ██████╗ ███████╗████████╗    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
██╔══██╗██╔═══██╗██╔════╝╚══██╔══╝    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
██████╔╝██║   ██║███████╗   ██║       ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
██╔═══╝ ██║   ██║╚════██║   ██║       ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
██║     ╚██████╔╝███████║   ██║       ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
╚═╝      ╚═════╝ ╚══════╝   ╚═╝       ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝"$ENDCOLOR

echo
echo "Starting post-install script... AUR helper"$RED"(yay)"$ENDCOLOR" will be installed first."

if [ ! -d ~/repo ] ; then
    mkdir ~/repo
else 
    echo -e $BLUE"~/repo"$ENDCOLOR" already exists."
fi



if [ ! -d /bin/yay ] ; then
    read -p "$(echo -e "Install "$RED"Yay "$ENDCOLOR"using git?(y/n)"$ENDCOLOR)" choice
    if [ "$choice" = "y" ]; then
        echo -e "Installing "$RED"git "$ENDCOLOR"and "$RED"base-devel "$ENDCOLOR
        sudo pacman -S --needed git base-devel
        cd ~/repo
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ~/repo
        echo "Installing gum"
        yay -Syyu
        yay gum
    fi
else 
    echo -e $BLUE"yay"$ENDCOLOR" already exists."
    yay -Syu 
    yay gum
fi


CHOICE=$(gum choose Chromebook\ presets ML4W --header "What installation do you want to proceed with?" --selected.foreground="#fff" --selected.background="#89b4fa" --cursor.foreground="#fff")  

if [ "$CHOICE" = "Chromebook presets" ]; then 
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


elif [ "$CHOICE" = "ML4W" ]; then
    choice=$(gum choose AUR Git --header "What installation method do you want to proceed with?" --selected.foreground="#fff" --selected.background="#89b4fa" --cursor.foreground="#fff")
    if [ "$choice" = "AUR" ]; then
        echo -e "Installing "$BLUE"ML4W"$ENDCOLOR"using"$GREEN"AUR"$ENDCOLOR
        yay -Syyu 
        yay -S ml4w-hyprland-git
        ml4w-hyprland-setup
    elif [ "$choice" = "Git" ]; then
        echo -e "Installing "$BLUE"ML4W "$ENDCOLOR"using "$GREEN"Git"$ENDCOLOR"."
        yay -Syyu
        yay -S gum rsync
        git clone https://github.com/mylinuxforwork/dotfiles.git
        cd dotfiles/bin
        ./ml4w-hyprland-setup
    fi

fi



