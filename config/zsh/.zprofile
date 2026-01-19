# only on the login TTY, and only if Wayland not running yet
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec start-hyprland
fi
