#!/usr/bin/env bash
set -euo pipefail

UNIT_NAME="kmonad.service"
UNIT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
UNIT_PATH="${UNIT_DIR}/${UNIT_NAME}"

mkdir -p "$UNIT_DIR"

cat > "$UNIT_PATH" <<'EOF'
[Unit]
Description=KMonad keyboard remapper

[Service]
ExecStart=kmonad %h/.dotfiles/kmonad/layout_thinkpad.kbd
Restart=always
RestartSec=2
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now "$UNIT_NAME"
