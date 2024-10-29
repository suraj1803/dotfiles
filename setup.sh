#!/bin/bash
# Clone dotfiles repository
git clone https://github.com/suraj1803/dotfiles.git ~/dotfiles

# Create symlinks
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/.wezterm.lua ~/.wezterm.lua
# Add more as needed

echo "Dotfiles setup complete."

