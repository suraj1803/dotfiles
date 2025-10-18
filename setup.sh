#!/bin/bash
sudo pacman -S nvim git curl nodejs npm ripgrep unzip fzf hyprland hyprshot hyprpaper hyprlock
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
paru -S google-chrome


