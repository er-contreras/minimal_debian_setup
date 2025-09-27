#!/bin/bash
set -e  # stop on error

apt update && apt upgrade -y

### --- Base tools ---
echo ">>> Installing base tools..."
apt install -y sudo stow git make build-essential unzip wget curl cmake ninja-build gettext alsa-utils blueman okular \
  libxcomposite-dev libxdamage-dev libxrandr-dev libconfig-dev libdbus-1-dev libglx-dev libgl-dev libdrm-dev libpcre3-dev \
  libxft-dev libxinerama-dev

### --- Dotfiles ---
echo ">>> Setting up dotfiles..."
cd ~
[ -f .bashrc ] && mv .bashrc .bashrc_backup
if [ ! -d dotfiles ]; then
    git clone https://github.com/er-contreras/dotfiles
fi
cd dotfiles && stow .

### --- Build suckless tools ---
build_suckless() {
    local dir=$1
    echo ">>> Building $dir..."
    cd ~/.config/$dir
    rm -f config.h
    make
    sudo make clean install
}

build_suckless dwm
build_suckless st
build_suckless dmenu
build_suckless slstatus

### --- Timezone ---
echo ">>> Setting timezone..."
timedatectl set-timezone America/Cancun

### --- Audio ---
echo ">>> Configuring audio..."
alsamixer # user will unmute manually

### --- Fonts ---
echo ">>> Installing fonts..."
cd /usr/local/share/fonts
wget -nc https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip
unzip -o 0xProto.zip
fc-cache -fv

### --- Neovim ---
echo ">>> Installing Neovim..."
cd
if [ ! -d neovim ]; then
    git clone https://github.com/neovim/neovim
fi
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

### --- Compton ---
echo ">>> Installing compton..."
cd ~/.config
if [ ! -d compton ]; then
    git clone https://github.com/chjj/compton
fi
cd compton
make
sudo make clean install
sudo ln -sf ~/.config/compton/compton /usr/local/bin

echo ">>> Setup complete. Please reboot."

