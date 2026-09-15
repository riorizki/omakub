#!/bin/bash

sudo apt remove --purge -y brave-browser

# Brave shares its repository with Brave Origin, so only drop it when Brave Origin is gone too
if ! dpkg-query -W -f='${Status}' brave-origin 2>/dev/null | grep -q "^install ok installed$"; then
  sudo rm -f /etc/apt/sources.list.d/brave-browser-release.list
  sudo rm -f /usr/share/keyrings/brave-browser-*.gpg
fi
