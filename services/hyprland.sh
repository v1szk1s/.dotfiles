if [[ ! -f /etc/systemd/system/seamless-login.service ]]; then
  cat <<EOF | sudo tee /etc/systemd/system/seamless-login.service
[Unit]
Description=Seamless Auto-Login
Conflicts=getty@tty1.service
After=systemd-user-sessions.service getty@tty1.service plymouth-quit.service systemd-logind.service
PartOf=graphical.target

[Service]
Type=simple
ExecStart=/usr/bin/uwsm start hyprland
Restart=always
RestartSec=2
StartLimitIntervalSec=30
StartLimitBurst=2
User=$USER
TTYPath=/dev/tty1
TTYReset=yes
TTYVHangup=yes
TTYVTDisallocate=yes
StandardInput=tty
StandardOutput=journal
StandardError=journal+console
PAMName=login

[Install]
WantedBy=graphical.target
EOF
fi

