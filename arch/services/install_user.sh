#!/usr/bin/env bash

for f in $(find $DOTFILES/arch/services/user -mindepth 1); do 
  ln -sf $f $HOME/.config/systemd/user/$(basename $f)
done

systemctl --user daemon-reload

for f in $(find $DOTFILES/arch/services/user -mindepth 1); do 
  systemctl --user enable $(basename $f)
done

