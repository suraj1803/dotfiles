#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $SCRIPT_DIR

install_packages() {
    local name="$1"

    echo "==> Installing ${name} packages..."
    sudo pacman -S --needed $(<"$SCRIPT_DIR/packages/${name}.txt")
}

setup_tmux() {
  mkdir -p ~/.tmux/plugins

  if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

install_packages system
install_packages core
install_packages fonts

xdg-user-dirs-update
xdg-user-dirs-gtk-update
setup_tmux


if [[ "$1" == "i3" ]]; then
    echo "Installing i3 packages..."
    install_packages i3
fi

if [[ "$1" == "hyprland" ]]; then
    echo "Installing i3 packages..."
    install_packages hyprland
fi

