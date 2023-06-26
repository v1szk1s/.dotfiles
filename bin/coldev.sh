#!/usr/bin/env bash

conn.sh 
rdesktop -K -r clipboard:CLIPBOARD -u aattila -d SEDDOM -p $COLDEV_PASSWD coldev1.inf.u-szeged.hu
