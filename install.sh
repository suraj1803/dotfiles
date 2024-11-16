#!/bin/sh
cd ~
echo "\nStarted installation...\n"
pm="hi"
ubuntu="ubuntu"
arch="arch"
fedora="fedor"

echo "Downloading dependencies"
if [ "$1" = "$ubuntu" ]; then
	sudo apt update > /dev/null 2>&1
	pm="sudo apt install"
	sudo apt install ripgrep cmake g++ pkg-config ninja-build gettext cmake unzip curl build-essential libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
	(
	curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh
	sudo -E bash nodesource_setup.sh
	sudo apt-get install -y nodejs
	)
elif [ "$1" = "$arch" ]; then
	sudo pacman -Syy
	pm="sudo pacman -S"
	sudo pacman -S cmake nodejs luajit freetype2 base-devel cmake unzip ninja curl fontconfig pkg-config make libxcb libxkbcommon python
elif [ "$1" = "$fedora" ]; then
	pm="sudo dnf install"
	sudo dnf install cmake freetype-devel ninja-build cmake gcc make unzip gettext curl glibc-gconv-extra fontconfig-devel libxcb-devel libxkbcommon-devel g++
fi

echo "\nInstalling i3, dmenu, picom, lxappearance, nitrogen...\n"
$pm i3 dmenu nitrogen lxappearance picom > /dev/null 2>&1
echo "\nInstallation successfull...\n"

echo "\nInstalling alacritty...\n"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
(
git clone https://github.com/alacritty/alacritty.git ~ && cd ~/alacritty 
cargo build --release 
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo rm -r ~/alacritty
) > /dev/null 2>&1

echo "\n Installing Fonts...\n"
(
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip 
mkdir ~/.fonts
unzip Meslo.zip -d ~/.fonts/
sudo rm -r Meslo.zip
) > /dev/null 2>&1


echo "\n Installing Neovim...\n"
(
git clone https://github.com/neovim/neovim.git ~/neovim
cd ~/neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
) > /dev/null 2>&1

