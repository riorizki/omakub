#!/bin/bash

# Display system information in the terminal
# Use the Ubuntu archive package when it exists (26.04) and fall back to the PPA (24.04)
if ! apt-cache show fastfetch &>/dev/null; then
  sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
  sudo apt update -y
fi
sudo apt install -y fastfetch

# Only attempt to set configuration if fastfetch is not already set
if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  # Use Omakub fastfetch config
  mkdir -p ~/.config/fastfetch
  cp ~/.local/share/omakub/configs/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
fi
