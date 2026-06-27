set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "[ERROR] Do not run this script as root."
  exit 1
fi

PACKAGES=(
i3-wm
i3status
i3lock
xss-lock


alacritty


dmenu


networkmanager
network-manager-applet


brightnessctl


xorg
xorg-server
xorg-xinit
xorg-xrandr
xorg-xset
xorg-xinput

# Appearance

picom
feh
papirus-icon-theme

# File Manager

thunar
thunar-volman

# Notifications

dunst
libnotify

# Screenshots

flameshot

# Clipboard

xclip

# Polkit

polkit-kde-agent

# Utilities

fastfetch
unzip
zip
wget
curl
git
neovim
)

AUR_PACKAGES=(
xidlehook
)

update_system() {
  sudo pacman -Syu --noconfirm
}

install_packages() {

  sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
}


install_aur_packages() {

  paru -S --needed --noconfirm "${AUR_PACKAGES[@]}"
}


main() {
  update_system
  install_packages
  # install_aur_packages

}

main "$@"
