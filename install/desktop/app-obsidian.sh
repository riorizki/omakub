#!/bin/bash

# Obsidian is a multi-platform note taking application. See https://obsidian.md
cd /tmp
# Some releases only publish mobile builds, so take the newest release that has a .deb
OBSIDIAN_DEB_URL=$(curl -s "https://api.github.com/repos/obsidianmd/obsidian-releases/releases?per_page=10" | grep -Po '"browser_download_url": "\K[^"]*_amd64\.deb' | head -1)
wget -O obsidian.deb "$OBSIDIAN_DEB_URL"
sudo apt install -y ./obsidian.deb
rm obsidian.deb
cd -
