#!/usr/bin/env bash

for f in $(find $DOTFILES/arch/desktop_files -mindepth 1 -name "*.desktop"); do
  ln -sf $f $HOME/.local/share/applications/$(basename $f)
done
