#!/bin/bash

FILE=$DOTFILES/zsh.config/.variables.sh

USER=$(whoami)

[ -f $FILE ] && source $FILE || echo "$0, could not source $FILE"
sudo mount --mkdir -t cifs //sedstor.inf.u-szeged.hu/aattila /mnt/smb -o username=aattila,password=$SMB_PWD,workgroup=SEDDOM,iocharset=utf8,uid=$USER,gid=$USER
