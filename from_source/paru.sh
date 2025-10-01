#!/usr/bin/env bash

USERNAME=mumu

odus() {
  sudo -u "$USERNAME" bash -lc "$1"
}

if [[ $EUID -ne 0 ]]; then
  echo "Please run with sudo:  sudo $0" >&2
  exit 1
fi

sudo mkdir -p /opt/paru
sudo chown $USERNAME:$USERNAME /opt/paru


if [[ ! -d /opt/paru/.git ]]; then
  odus "git clone https://aur.archlinux.org/paru.git /opt/paru"
fi

cd /opt/paru
odus "makepkg -si"
