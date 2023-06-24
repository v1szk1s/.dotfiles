#!/usr/bin/env bash

conn.sh 
rdesktop -f -g 90%x90% -K -r clipboard:CLIPBOARD -u aattila -d COLUMBUS -p $COLDEV2_PASSWD coldev2.inf.u-szeged.hu
