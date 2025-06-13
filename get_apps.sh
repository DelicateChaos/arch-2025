#!/bin/bash

echo "Starting instillation for custom apps"
# This assumes a fresh arch installation of hyperland profile. 
# Refrence libraries 
# sudo pacman -S --noconfirm steam lutris wine-staging winetricks gamemode lib32-gamemode giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal \
# v4l-utils lib32-v4l-utils libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama \
#lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader \
# lib32-vulkan-icd-loader obs-studio discord mangohud lib32-mangohud goverlay gamescope solaar bluez bluez-utils lib32-libpulse pipewire pipewire-pulse pipewire-alsa linux-headers xwaylandvideobridge

pacman -Syu

install_yay() {
    if ! command -v yay &> /dev/null; then
        echo "Installing yay..."
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay-bin.git
        cd yay-bin || exit
        makepkg -si --noconfirm
        cd .. && rm -rf yay-bin
        export PATH="$PATH:$HOME/.local/bin"
    else
        echo "yay is already installed."
    fi
}

install_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}


# Install yay
install_yay
# Desktop Enviroment 
echo "Installing DE Components.."
sudo pacman -S --needed --noconfirm waybar
yay -Syu --needed --noconfirm swww      
# TUI
echo "Installing TUI.."
sudo pacman -S --needed --noconfirm ffmpeg zoxide fzf stow neovim htop btop tree bat curl rsync grep bash-completion zsh
yay -S --needed --noconfirm neofetch
# GUI
echo "Installing GUI apps.."
sudo pacman -S --needed --noconfirm discord obs-studio emacs-wayland 
yay -S --needed --noconfirm firefox-developer-edition
#install zsh
install_zsh
hyprctl reload