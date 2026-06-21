#!/usr/bin/env bash

set -euo pipefail

# ==================================================

# Safety Checks

# ==================================================

if [[ $EUID -eq 0 ]]; then
  echo "[ERROR] Do not run this script as root."
  exit 1
fi


# Packages

# ==================================================

PACKAGES=(

#graphics
mesa
vulkan-intel
intel-media-driver

# System

base-devel
networkmanager
openssh
sudo
power-profiles-daemon
man-db
man-pages
texinfo

# Development

git
github-cli
nodejs
npm

# CLI Tools

curl
wget
ripgrep
fzf
tree
tree-sitter-cli
stow
unzip
zip 
less
which

# Terminal

zsh
kitty
tmux
eza

# Editors

neovim

# Monitoring

htop
btop
fastfetch

# Files

yazi
thunar

# Media

mpv
imv

# Wayland

wl-clipboard

# Audio

pipewire
pipewire-pulse
pipewire-alsa
wireplumber
pavucontrol

# Bluetooth

bluez
bluez-utils

# Utilities

brightnessctl
playerctl

# Fonts

ttf-jetbrains-mono-nerd
ttf-cascadia-mono-nerd
ttf-hack-nerd
noto-fonts
noto-fonts-emoji
noto-fonts-extra
noto-fonts-cjk
ttf-dejavu
ttf-liberation
ttf-roboto
gnu-free-fonts
adobe-source-sans-fonts 
adobe-source-serif-fonts 
)

AUR_PACKAGES=(
  google-chrome
)

# ==================================================

# Logging

# ==================================================

info() {
  echo "[INFO] $*"
}

warn() {
  echo "[WARN] $*"
}

# ==================================================

# System Update

# ==================================================

update_system() {
  info "Updating system..."
  sudo pacman -Syu --noconfirm
}

# ==================================================

# Package Installation

# ==================================================

install_packages() {
  info "Installing packages..."

  sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
}

install_paru() {
  if command -v paru >/dev/null 2>&1; then
    return
  fi

  info "Installing paru..."

  rm -rf /tmp/paru

  git clone https://aur.archlinux.org/paru.git /tmp/paru

  pushd /tmp/paru >/dev/null
  makepkg -si --noconfirm
  popd >/dev/null
}

install_aur_packages() {
  info "Installing AUR packages..."

  paru -S --needed --noconfirm "${AUR_PACKAGES[@]}"
}

# ==================================================

# Services

# ==================================================

enable_services() {
  info "Enabling services..."

  sudo systemctl enable --now NetworkManager
  sudo systemctl enable --now bluetooth
  sudo systemctl enable --now sshd
  sudo systemctl enable power-profiles-daemon
}

# ==================================================

# Git

# ==================================================

setup_git() {
  git config --global user.name "Suraj Biswas"
  git config --global user.email "surajbiswas182003@gmail.com"
  git config --global core.editor nvim
}

# ==================================================

# ZSH

# ==================================================

setup_zsh() {
  info "Configuring zsh..."

  if [[ "$SHELL" != "$(command -v zsh)" ]]; then
    chsh -s "$(command -v zsh)"
  fi

  if [[ ! -d ~/.oh-my-zsh ]]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  local plugin_dir
  plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

  if [[ ! -d "$plugin_dir" ]]; then
    git clone 
    https://github.com/zsh-users/zsh-autosuggestions 
    "$plugin_dir"
  fi
}

# ==================================================

# Dotfiles

# ==================================================

setup_dotfiles() {
  if [[ ! -d ~/dotfiles ]]; then
    warn "~/dotfiles not found"
    return
  fi

  info "Applying dotfiles..."

  pushd ~/dotfiles >/dev/null

  stow nvim
  stow kitty
  stow tmux

  popd >/dev/null
}

# ==================================================

# Tmux

# ==================================================

setup_tmux() {
  mkdir -p ~/.tmux/plugins

  if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

# ==================================================

# NVIDIA

# ==================================================

setup_nvidia() {
  if ! lspci | grep -qi nvidia; then
    return
  fi

  info "Installing NVIDIA packages..."

  sudo pacman -S --needed --noconfirm nvidia-open  nvidia-utils  nvidia-settings 

  info "Remember to:"
  echo "1. Add:"
  echo "   nvidia nvidia_modeset nvidia_uvm nvidia_drm"
  echo "   to MODULES in /etc/mkinitcpio.conf"
  echo
  echo "2. Run:"
  echo "   sudo mkinitcpio -P"
}

# ==================================================

# Main

# ==================================================

main() {
  update_system
  install_packages
 # install_paru
  install_aur_packages

 # enable_services

  setup_git
 # setup_zsh
  setup_dotfiles
  setup_tmux

 # setup_nvidia

  info "Setup complete."
}

main "$@"
