#!/bin/bash

# Install 1password and 1password-cli from the official apt repository
# See https://support.1password.com/install-linux/
if [ ! -s /usr/share/keyrings/1password-archive-keyring.gpg ]; then
  curl -sS https://downloads.1password.com/linux/keys/1password.asc |
    sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
fi

# The 1password package replaces this list with its own deb822 file once it is installed
if ! grep -Rqs downloads.1password.com /etc/apt/sources.list.d/; then
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
    sudo tee /etc/apt/sources.list.d/1password.list
fi

# Add the debsig-verify policy
if [ ! -f /etc/debsig/policies/AC2D62742012EA22/1password.pol ]; then
  sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol |
    sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
fi

if [ ! -s /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg ]; then
  sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
  curl -sS https://downloads.1password.com/linux/keys/1password.asc |
    sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
fi

sudo apt update
sudo apt install -y 1password 1password-cli
