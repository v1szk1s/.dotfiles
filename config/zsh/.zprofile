# only on the login TTY, and only if Wayland not running yet
# if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  # exec systemctl --user start hyprland.service
# fi
