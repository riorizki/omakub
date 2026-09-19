#!/bin/bash

sudo rm -rf /opt/android-studio
sudo rm -f /usr/share/applications/android-studio.desktop

echo "Removed Android Studio. The SDK in ~/Android/Sdk and the IDE settings were left"
echo "in place, since the SDK Manager owns them and they can be several gigabytes."
