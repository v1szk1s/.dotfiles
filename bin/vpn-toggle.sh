#!/bin/bash


# The process name for OpenVPN
VPN_PROCESS_NAME="openvpn"

# Function to check if VPN is connected
is_vpn_connected() {
    # Check if OpenVPN process is running
    pgrep -f "$VPN_PROCESS_NAME" > /dev/null 2>&1
}

# Function to start VPN connection
start_vpn() {
    echo "Connecting to VPN..."
    sudo openvpn /home/hulu/work/tanszek/vpn/Ambrus_Attila-infint.ovpn > /dev/null &
    echo "VPN connected."
}

# Function to stop VPN connection
stop_vpn() {
    echo "Disconnecting VPN..."
    pkill -f "$VPN_PROCESS_NAME" > /dev/null &
    echo "VPN disconnected."
}

# Toggle VPN connection based on current status
if is_vpn_connected; then
    stop_vpn
else
    start_vpn
fi

sleep 1
pkill -RTMIN+11 dwmblocks

