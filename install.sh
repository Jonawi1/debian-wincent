#!/bin/sh
# See LICENSE file for copyright and license details.

username=$(id -u -n 1000)
builddir=$(pwd)

echo "Sudo privileges are required for some operations."
echo "Authenticate if this is okay."

sudo apt update
sudo apt install nala -y
sudo nala fetch --auto
sudo nala upgrade -y

sudo nala install -y \
    bluez \
    curl \
    dbus-x11 \
    dunst \
    feh \
    firefox-esr \
    fonts-firacode \
    gimp \
    light \
    network-manager \
    npm \
    picom \
    pipewire \
    unclutter-xfixes \
    unzip \
    wget \
    wireplumber \
    xclip \
    zathura

echo "Reboot to complete the installation"

