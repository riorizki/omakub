#!/bin/bash

# Ghostty is a GPU-accelerated terminal with native tabs and splits. See https://ghostty.org
sudo apt install -y ghostty

# Only attempt to set configuration if Ghostty has never been configured
if [ ! -f "$HOME/.config/ghostty/config" ]; then
  mkdir -p ~/.config/ghostty
  cp ~/.local/share/omakub/configs/ghostty ~/.config/ghostty/config
fi
