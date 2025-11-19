#!/bin/zsh

# -------------------------------
#   ARCH LINUX POST-INSTALL SETUP
# -------------------------------

set -e

echo "Updating system..."
sudo pacman -Syu --noconfirm

timedatectl set-local-rtc 1

# Base essentials
sudo pacman -S --noconfirm --needed \
    network-manager-applet \
    tmux \
    git \
    vim \
    nvim \
    nodejs \
    npm \
    ripgrep \
    zsh \
    stow \
    ghostty \
    kitty \
    hyprland \
    waybar \
    hyprpaper \
    hyprlock \
    hyprshot


# Audio
sudo pacman -S --noconfirm --needed \
  pipewire \
  pipewire-pulse \
  wlroots \
  xdg-desktop-portal \
  xdg-desktop-portal-hyprland

# Fonts
sudo pacman -S --noconfirm --needed \
    ttf-dejavu \
    ttf-liberation \
    noto-fonts \
    noto-fonts-emoji \
    ttf-jetbrains-mono \
    ttf-cascadia-mono-nerd

# Utils
sudo pacman -S --noconfirm --needed \
    htop \
    btop \
    neofetch \
    unzip \
    ntfs-3g

# GPU DRIVERS — Uncomment based on your hardware
# NVIDIA:
sudo pacman -S --noconfirm --needed nvidia nvidia-utils nvidia-settings

# INTEL:
# sudo pacman -S --noconfirm --needed mesa xf86-video-intel

# AMD:
# sudo pacman -S --noconfirm --needed mesa xf86-video-amdgpu

# --------------------------------------------------------------------
# AUR HELPER: YAY
# --------------------------------------------------------------------
if ! command -v yay &>/dev/null; then
    cd "$HOME"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$HOME"
fi

yay -S --noconfirm --needed vicinae-bin 

# --------------------------------------------------------------------
# OH MY ZSH + POWERLEVEL10K
# --------------------------------------------------------------------

export RUNZSH=no   # prevent auto switching shell
export CHSH=no     # prevent installer from running chsh itself

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Install Powerlevel10k Theme
echo "Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

# --------------------------------------------------------------------
# DOTFILES
# --------------------------------------------------------------------

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

cd "$HOME"
rm .zshrc
rm .p10k.zsh
git clone https://github.com/suraj1803/dotfiles.git
cd dotfiles
stow hypr waybar hyprlock ghostty kitty nvim tmux zsh
cd "$HOME"

# TMUX TPM
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

echo "--------------------------------------"
echo "Arch Linux Post-Install Completed 🎉"
echo "Reboot recommended!"
echo "--------------------------------------"
