#!/usr/bin/env bash
set -Eeuo pipefail

# ==========================================
# CONFIG — EDIT THESE
# ==========================================
USERNAME="mumu"                           # your new username
USER_FULLNAME="Attila Ambrus"                # optional full name
USER_PASSWORD=""                         # leave empty to be prompted
INSTALL_PARU=true                        # true/false
DOTFILES_DIR="/home/${USERNAME}/.dotfiles"

# Shell preference
DEFAULT_SHELL="/bin/zsh"                 # /bin/zsh or /bin/bash



# Hyprland + Wayland essentials (tweak freely)
WAYLAND_PACKAGES=(
  hyprland hyprpaper hyprlock hypridle hyprpicker
  xdg-desktop-portal xdg-desktop-portal-hyprland xdg-user-dirs
  waybar alacritty nwg-displays
  alsa-firmware sof-firmware pipewire wireplumber pipewire-pulse pipewire-alsa pipewire-jack helvum
  grim slurp wl-clipboard satty qt5-wayland qt6-wayland mako
  brightnessctl playerctl pavucontrol network-manager-applet blueman
  polkit-gnome thunar thunar-archive-plugin file-roller gvfs gvfs-mtp udiskie udisks2
  ttf-nerd-fonts-symbols ttf-dejavu noto-fonts noto-fonts-cjk noto-fonts-emoji
  git curl wget unzip zip tar
)

# Optional quality-of-life
#TRA_PACKAGES=(sudo vim htop jq zsh fzf ripgrep kmonad)

# ==========================================
# SANITY CHECKS
# ==========================================
if [[ $EUID -eq 0 ]]; then
  : # fine, likely running with sudo
else
  echo "Please run with sudo:  sudo $0" >&2
  exit 1
fi

if ! pacman -V >/dev/null 2>&1; then
  echo "This script is for Arch-based systems with pacman." >&2
  exit 1
fi

# Ensure network is up
if ! ping -c1 archlinux.org &>/dev/null; then
  echo "No network connectivity detected. Connect and try again." >&2
  exit 1
fi

echo "==> Updating system (pacman -Syu)…"
pacman -Syu --noconfirm
echo "==> Installing base tooling…"
pacman -S --needed --noconfirm base-devel ${EXTRA_PACKAGES[*]}

# ==========================================
# MICROCODE + GPU DRIVERS (autodetect)
# ==========================================
echo "==> Installing CPU microcode…"
if lscpu | grep -qi AMD; then
  pacman -S --needed --noconfirm amd-ucode
elif lscpu | grep -qi Intel; then
  pacman -S --needed --noconfirm intel-ucode
fi

echo "==> Detecting GPU and installing drivers…"
if lspci | grep -E "VGA|3D" | grep -qi nvidia; then
  pacman -S --needed --noconfirm nvidia nvidia-utils nvidia-settings
else
  pacman -S --needed --noconfirm mesa vulkan-radeon vulkan-intel libva-mesa-driver
fi

# ==========================================
# DESKTOP STACK
# ==========================================
echo "==> Installing Hyprland & Wayland stack…"
pacman -S --needed --noconfirm "${WAYLAND_PACKAGES[@]}"

# Bluetooth (common)
pacman -S --needed --noconfirm bluez bluez-utils

# ==========================================
# SERVICES
# ==========================================
echo "==> Enabling services…"
systemctl enable NetworkManager
systemctl enable bluetooth

# PipeWire is socket-activated; make sure user services are available at login.
loginctl enable-linger "$USERNAME" || true


sudo -u "$USERNAME" bash -lc "cd \"$DOTFILES_DIR\" && ./install"

echo "==> Initializing XDG user directories…"
sudo -u "$USERNAME" xdg-user-dirs-update || true


# ==========================================
# SHELL
# ==========================================
if [[ -n "$DEFAULT_SHELL" ]]; then
  if [[ -x "$DEFAULT_SHELL" ]]; then
    chsh -s "$DEFAULT_SHELL" "$USERNAME" || true
    echo "==> Default shell for $USERNAME set to $DEFAULT_SHELL"
  else
    echo "WARNING: $DEFAULT_SHELL not found, leaving default shell unchanged"
  fi
fi

# ==========================================
# OPTIONAL: PARU (AUR helper)
# ==========================================
if $INSTALL_PARU; then
  echo "==> Installing paru (AUR helper)…"
  sudo -u "$USERNAME" bash -lc '
    if command -v paru >/dev/null 2>&1; then
      echo "paru already installed."
    else
      git clone --depth=1 https://aur.archlinux.org/paru-bin.git /tmp/paru
      cd /tmp/paru && makepkg -si --noconfirm
    fi
  '
fi

# ==========================================
# WAYLAND SESSION QUALITY FIXES
# ==========================================
# Make sure portals are sane (Hyprland portal first)
echo "==> Ensuring xdg-desktop-portal-hyprland is primary…"
mkdir -p /etc/xdg/xdg-hyprland/xdg-desktop-portal
cat >/etc/xdg/xdg-hyprland/xdg-desktop-portal/portals.conf <<'EOF' || true
[preferred]
default=hyprland
org.freedesktop.impl.portal.Settings=hyprland
org.freedesktop.impl.portal.Screencast=hyprland
org.freedesktop.impl.portal.Screenshot=hyprland
EOF

# Create a minimal env file for Wayland apps (optional, safe defaults)
echo "==> Writing /etc/environment Wayland hints (non-destructive append)…"
{
  grep -q '^XDG_CURRENT_DESKTOP=' /etc/environment || echo 'XDG_CURRENT_DESKTOP=Hyprland'
  grep -q '^XDG_SESSION_TYPE=' /etc/environment || echo 'XDG_SESSION_TYPE=wayland'
} || true

# ==========================================
# DONE
# ==========================================
cat <<INFO

========================================
 Setup complete.
 User:        $USERNAME
 Dotfiles:    $DOTFILES_REPO
 Hyprland:    Installed
 AUR helper:  $( $INSTALL_PARU && echo "paru" || echo "skipped" )
========================================

Next steps:
  • Reboot or log out/in to start a clean Wayland session.
  • From a TTY, you can start Hyprland by logging in as $USERNAME and running:  hyprland
  • Or install a display manager (e.g., greetd + tuigreet) — I can add that to the script if you want.

INFO
