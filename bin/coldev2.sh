#!/usr/bin/env bash

[ -f "/home/v1szk1s/.dotfiles/zsh.config/.variables.sh" ] && source "/home/v1szk1s/.dotfiles/zsh.config/.variables.sh"
rdesktop -P -a 8 -g 1920x1080 -K -r clipboard:CLIPBOARD -u aattila -d COLUMBUS -p $COLDEV2_PWD -k en-us coldev2.inf.u-szeged.hu

