#!/usr/bin/env bash
set -euo pipefail
IFACE="${1:-wg0}"

if ip link show dev "$IFACE" >/dev/null 2>&1; then
  # Interface exists
  jq -cn --arg t " 󰖂 " --arg tt "WireGuard: $IFACE exists" \
    '{text:$t, tooltip:$tt, class:"wg-on"}'
else
  # Interface does not exist
  jq -cn --arg t " 󰒗 " --arg tt "WireGuard: $IFACE not present" \
    '{text:$t, tooltip:$tt, class:"wg-off"}'
fi
