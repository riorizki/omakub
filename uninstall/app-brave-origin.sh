#!/bin/bash

sudo apt remove --purge -y brave-origin

# Brave Origin shares its repository with Brave, so only drop it when Brave is gone too
if ! dpkg-query -W -f='${Status}' brave-browser 2>/dev/null | grep -q "^install ok installed$"; then
  sudo rm -f /etc/apt/sources.list.d/brave-browser-release.list
  sudo rm -f /usr/share/keyrings/brave-browser-*.gpg
fi
