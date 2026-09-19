#!/bin/bash

# Android Studio ships as a tarball from Google. There is no stable "latest" download
# URL, so read the current one off the download page and fall back to a known build.
ANDROID_STUDIO_DIR="/opt/android-studio"
ANDROID_STUDIO_FALLBACK="https://edgedl.me.gvt1.com/android/studio/ide-zips/2026.1.4.8/android-studio-quail4-patch1-linux.tar.gz"

ANDROID_STUDIO_URL=$(curl -sL https://developer.android.com/studio | grep -oE 'https://[a-zA-Z0-9./_-]*linux[a-zA-Z0-9./_-]*\.tar\.gz' | head -1)
if [ -z "$ANDROID_STUDIO_URL" ]; then
  echo "Could not read the current download URL, using the last known build instead"
  ANDROID_STUDIO_URL="$ANDROID_STUDIO_FALLBACK"
fi

cd /tmp
wget -O android-studio.tar.gz "$ANDROID_STUDIO_URL"
sudo rm -rf "$ANDROID_STUDIO_DIR"
sudo tar -xzf android-studio.tar.gz -C /opt
rm android-studio.tar.gz
cd -

# The updater built into the IDE writes to its own installation directory
sudo chown -R "$USER" "$ANDROID_STUDIO_DIR"

# Recent releases ship a native launcher, older ones only the shell script
STUDIO_BIN="$ANDROID_STUDIO_DIR/bin/studio"
[ -x "$STUDIO_BIN" ] || STUDIO_BIN="$ANDROID_STUDIO_DIR/bin/studio.sh"
STUDIO_ICON="$ANDROID_STUDIO_DIR/bin/studio.png"
[ -f "$STUDIO_ICON" ] || STUDIO_ICON="$ANDROID_STUDIO_DIR/bin/studio.svg"

# StartupWMClass so Gnome on Wayland matches the window to this launcher
sudo tee /usr/share/applications/android-studio.desktop >/dev/null <<EOL
[Desktop Entry]
Version=1.0
Name=Android Studio
Comment=Official IDE for Android development
Exec=$STUDIO_BIN
Icon=$STUDIO_ICON
Terminal=false
Type=Application
Categories=Development;IDE;
StartupNotify=true
StartupWMClass=jetbrains-studio
EOL

# The emulator opens /dev/kvm directly and bundles its own QEMU, so no virtualization
# packages are needed. Ubuntu ships that device as root:kvm with mode 0660.
sudo usermod -aG kvm "$USER"

echo "Android Studio is installed. Open it once to run the SDK wizard, and there:"
echo "  - keep the default SDK location (~/Android/Sdk)"
echo "  - tick \"Android SDK Command-line Tools (latest)\" under SDK Tools"
echo "Open a new terminal afterwards to get adb, sdkmanager, and emulator on PATH."
echo "Log out and back in (or run 'newgrp kvm') for the emulator, then check it with:"
echo "  emulator -accel-check"
