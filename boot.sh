#!/bin/bash

set -e

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> Omakub is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning Omakub..."
rm -rf ~/.local/share/omakub
git clone "https://github.com/${OMAKUB_REPO:-riorizki/omakub}.git" ~/.local/share/omakub >/dev/null
if [[ -n $OMAKUB_REF && $OMAKUB_REF != "master" ]]; then
	cd ~/.local/share/omakub
	git fetch origin "$OMAKUB_REF"
	git checkout "$OMAKUB_REF"
	cd -
fi

echo "Installation starting..."
mkdir -p ~/.local/state/omakub
export OMAKUB_INSTALL_LOG="$HOME/.local/state/omakub/install-$(date +%Y%m%d-%H%M%S).log"

# Save everything the installer prints while keeping a real terminal for its prompts
script -qefc "bash ~/.local/share/omakub/install.sh" "$OMAKUB_INSTALL_LOG" </dev/tty
