#!/bin/bash


[ -f "/home/hulu/.dotfiles/zsh.config/.variables.sh" ] && source "/home/hulu/.dotfiles/zsh.config/.variables.sh"
sudo mount --mkdir -t cifs //sedstor.inf.u-szeged.hu/aattila /mnt/smb -o username=aattila,password=$SMB_PWD,workgroup=SEDDOM,iocharset=utf8,uid=hulu,gid=hulu
