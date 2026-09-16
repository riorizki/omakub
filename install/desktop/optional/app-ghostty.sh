#!/bin/bash

# Ghostty is a GPU-accelerated terminal with native tabs and splits. See https://ghostty.org
# The Ubuntu archive only ships it from Ubuntu 26.04
if ! apt-cache show ghostty &>/dev/null; then
  echo "Ghostty is not available in the Ubuntu archive for this release. It is packaged from Ubuntu 26.04."
  return 1
fi

sudo apt install -y ghostty

# Only attempt to set configuration if Ghostty has never been configured
if [ ! -f "$HOME/.config/ghostty/config" ]; then
  mkdir -p ~/.config/ghostty
  cp ~/.local/share/omakub/configs/ghostty ~/.config/ghostty/config
fi
