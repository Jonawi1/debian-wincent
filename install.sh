#!/bin/sh
# See LICENSE file for copyright and license details.

username=$(id -u -n 1000)
builddir=$(pwd)

echo "Sudo privileges are required for some operations."
echo "Authenticate if this is okay."

sudo apt update
sudo apt install nala -y
#sudo nala fetch --auto # skip if exsists
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
    texlive-full \
    unclutter-xfixes \
    unzip \
    wget \
    wireplumber \
    xclip \
    xdotool \
    zathura

# virtual machines
# sudo nala install -y qemu-system libvirt-daemon-system virt-manager ovmf

# Build suckless software
sudo nala install -y \
    build-essential \
    libx11-dev \
    libxft-dev \
    libxinerama-dev \
    xorg

cd dwm && sudo make clean install && cd ..
cd st && sudo make clean install && cd ..
cd dmenu && sudo make clean install && cd ..
cd slstatus && sudo make clean install && cd ..
cd wmname && sudo make clean install && cd ..
cd $builddir

# Config files and .files
mkdir -p ~/.config
cp -Ri dotconfig/* ~/.config
mkdir -p ~/pictures
cp -i bg.jpg ~/pictures/
# crontab background execution of battery alert.
echo "*/1 * * * * export DISPLAY=:0 && /usr/bin/dbus-launch /home/$username/.config/.battery-alert.sh" | crontab -u $username -

# TODO
cp -i dotfiles/.bashrc ~/
cp -i dotfiles/.bash_profile ~/
cp -i dotfiles/.xinitrc ~/
mkdir -p ~/.dwm/
cp -i dotfiles/.dwm/autostart.sh ~/.dwm/
sudo cp -i -r slstatus-scripts/ /

# neovim
sudo nala install -y \
    ninja-build \
    gettext \
    cmake \
    unzip \
    curl \
    python3.11-venv
sudo nala purge -y nano
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
cd neovim 
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd $builddir
git clone https://github.com/jonwin1/nvim-wincent ~/.config/nvim

# kmonad
curl -sSL https://get.haskellstack.org/ | sh
cd kmonad
rm -rf .stack-work
stack build
sudo cp .stack-work/install/*/*/*/bin/kmonad /usr/local/bin/
cd $builddir
cp -i configFiles/miryoku_kmonad.kbd ~/
echo "kmonad /home/$username/miryoku_kmonad.kbd &" >> ~/.dwm/autostart.sh
sudo groupadd -f uinput
sudo usermod -aG input $username
sudo usermod -aG uinput $username
sudo cp -i configFiles/20-uinput.rules /etc/udev/rules.d/ 
sudo modprobe uinput

echo "Reboot to complete the installation"

