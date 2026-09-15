#!/bin/bash

# Use the source file and keyring that Microsoft documents and the code package maintains,
# so apt never sees this repository twice with different Signed-By values
sudo rm -f /etc/apt/sources.list.d/vscode.list
if [ ! -f /etc/apt/sources.list.d/vscode.sources ] || [ ! -f /usr/share/keyrings/microsoft.gpg ]; then
  cd /tmp
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
  sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
  printf '%s\n' "Types: deb" "URIs: https://packages.microsoft.com/repos/code" "Suites: stable" "Components: main" "Architectures: amd64,arm64,armhf" "Signed-By: /usr/share/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/vscode.sources >/dev/null
  rm -f microsoft.gpg
  cd -
fi

sudo apt update
sudo apt install -y code

mkdir -p ~/.config/Code/User
cp ~/.local/share/omakub/configs/vscode.json ~/.config/Code/User/settings.json

# Install default supported themes
code --install-extension enkia.tokyo-night