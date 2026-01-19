#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
  : # fine, likely running with sudo
else
  echo "Please run with sudo:  sudo $0" >&2
  exit 1
fi

sudo mkdir -p /opt/neovim

if [[ ! -d /opt/neovim/.git ]]; then
	git clone https://github.com/neovim/neovim /opt/neovim
fi

sudo pacman -S --noconfirm base-devel cmake ninja curl git

cd /opt/neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

sudo chmod mumu:mumu /opt/neovim
