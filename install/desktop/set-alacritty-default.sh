#!/usr/bin/env sh

# Make alacritty default terminal emulator
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# Ubuntu 26.04 picks the default terminal through xdg-terminal-exec, which defaults to Ptyxis
mkdir -p ~/.config
echo "Alacritty.desktop" >~/.config/xdg-terminals.list
