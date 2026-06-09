#!/usr/bin/env bash

set -euo pipefail

# ==================================================
# Variables
# ==================================================

# USERNAME="suraj"
# HOSTNAME="archlinux"

PACKAGES=(
    git
    nwg-look
    github-cli
    nvim
    nodejs
    npm
    stow
    ripgrep
    fzf
    tree-sitter-cli
    htop
    btop
    curl
    wget
    wl-clipboard

    #Terminal
    kitty
    tmux
    zsh

    # files & media
    imv 
    mpv
    nautilus
    thunar
    yazi

    # hyprland stuff
    hyprland
    hyprshot 
    hyprshutdown
    hyprpaper
    hyprpolkitagent
    wofi
    waybar
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    dunst  # notification daemon
    qt5-wayland
    qt6-wayland
    qt5ct
    qt6ct
    network-manager-applet
    brightnessctl
    playerctl
    pavucontrol
    pipewire
    wireplumber
    pipewire-pulse
    fastfetch

    # fonts
    ttf-jetbrains-mono-nerd
    ttf-cascadia-mono-nerd
    noto-fonts
    noto-fonts-emoji
    noto-fonts-extra
    noto-fonts-cjk
  )

  AUR_PACKAGES=(
    google-chrome
    bibata-cursor-theme
  )

# ==================================================
# Helper Functions
# ==================================================

info() {
  echo "[INFO] $*"
}

warn() {
  echo "[WARN] $*"
}

error() {
  echo "[ERROR] $*" >&2
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

install_yay() {
  if ! command -v yay >/dev/null 2>&1; then
    info "Installing yay..."

    sudo pacman -S --needed git base-devel

    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
  fi
}
install_packages() {
  info "Installing official packages..."

  sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
}

install_aur_packages() {
  info "Installing AUR packages..."

  yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"
}

# ==================================================
# Services
# ==================================================

enable_services() {
  info "Enabling services..."

  sudo systemctl enable NetworkManager
  sudo systemctl enable bluetooth
}

# ==================================================
# Dotfiles
# ==================================================
#

setup_git() {
  git config --global user.name "Suraj Biswas"
  git config --global user.email "surajbiswas182003@gmail.com"
  git config --global core.editor nvim
}

setup_dotfiles() {
  info "Setting up dotfiles..."
  cd ~
  cd dotfiles
  stow hypr
  stow nvim
  stow waybar 
  stow kitty
  # Example
  # cp -r dotfiles/nvim ~/.config/
}

setup_tmux() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# ==================================================
# Hyprland
# ==================================================

setup_hyprland() {
  info "Configuring Hyprland..."

  # Copy configs
  # Configure monitors
  # Configure Waybar
}

# ==================================================
# NVIDIA
# ==================================================

setup_nvidia() {
  info "Installing NVIDIA packages..."

  sudo pacman -S --needed --noconfirm \
    nvidia-open \
    nvidia-utils \
    lib32-nvidia-utils
}

# ==================================================
# Main
# ==================================================

main() {
 cd ~
  update_system
  install_yay
  install_packages
  install_aur_packages
  enable_services
  setup_git
  setup_dotfiles
  setup_tmux
  setup_hyprland

  info "Setup complete."
}

main "$@"
