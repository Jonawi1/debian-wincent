#!/bin/sh
# See LICENSE file for copyright and license details.

username=$(id -u -n 1000)
builddir=$(pwd)

echo "Sudo privileges are required for some operations."
echo "Authenticate if this is okay."

sudo apt update
sudo apt install nala -y
sudo nala fetch --auto # skip if exsists
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

# Build suckless software
sudo nala install -y \
    build-essential \
    libx11-dev \
    libxft-dev \
    libxinerama-dev \
    xorg

cd $builddir
cd dwm && sudo make clean install && cd ..
cd st && sudo make clean install && cd ..
cd dmenu && sudo make clean install && cd ..
cd slstatus && sudo make clean install && cd ..
cd wmname && sudo make clean install && cd ..

# Config files and .files
cd $builddir
mkdir -p /home/$username/.config
cp -Ri dotconfig/* /home/$username/.config
# crontab background execution of battery alert.
echo "*/1 * * * * export DISPLAY=:0 && /usr/bin/dbus-launch $(user_home)/.config/.battery-alert.sh" | crontab -u $(user) -

# TODO
cp -i dotfiles/.bashrc /home/$username/
cp -i dotfiles/.bash_profile /home/$username/
cp -i dotfiles/.xinitrc /home/$username/
mkdir -p /home/$username/.dwm/
cp -i dotfiles/.dwm/autostart.sh /home/$username/.dwm/
cp -i -r slstatus-scripts/ /

echo "Reboot to complete the installation"

