#!/bin/bash

sudo apt remove --purge -y 1password 1password-cli

# The 1password package adds its own apt source, which stays behind after the purge
sudo rm -f /etc/apt/sources.list.d/1password.list /etc/apt/sources.list.d/1password.sources
sudo rm -f /usr/share/keyrings/1password-archive-keyring.gpg
sudo rm -f /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
sudo rm -rf /etc/debsig/policies/AC2D62742012EA22/
