#!/usr/bin/env bash

if [[ $(ps aux | grep openvpn | wc -l) -eq 1 ]]; then
    conn-vpn.sh
fi
