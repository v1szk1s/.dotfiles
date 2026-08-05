#!/usr/bin/env bash

set -euo pipefail

for f in $(find $DOTFILES/arch/services/etc -mindepth 1 -maxdepth 1); do 
  sudo cp -rf $f /etc/
done

for f in $(find $DOTFILES/arch/services/system -mindepth 1); do 
  sudo cp -f $f /etc/systemd/system/$(basename $f)
done

sudo systemctl daemon-reload

for f in $(find $DOTFILES/arch/services/system -mindepth 1); do 
  sudo systemctl enable --now $(basename $f)
done
