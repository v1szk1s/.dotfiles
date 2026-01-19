#!/usr/bin/env bash

for f in $(find $DOTFILES/arch/services/system -mindepth 1); do 
  envsubst < $f | sudo tee /etc/systemd/system/$(basename $f)
done

sudo systemctl daemon-reload

for f in $(find $DOTFILES/arch/services/system -mindepth 1); do 
  sudo systemctl enable $(basename $f)
done
