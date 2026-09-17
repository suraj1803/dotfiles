#!/usr/bin/env bash
sleep 4
killall -e xdg-desktop-portal-hyprland
killall xdg-desktop-portal
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
/usr/lib/xdg-desktop-portal-hyprland &
sleep 4
/usr/lib/xdg-desktop-portal &
