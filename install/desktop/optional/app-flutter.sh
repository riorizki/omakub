#!/bin/bash

# Flutter publishes a release manifest, so install whatever stable is today rather than
# pinning a version. Its tarball is a git checkout, which is what "flutter upgrade" needs.
sudo apt install -y jq cmake ninja-build pkg-config libgtk-3-dev libglu1-mesa xz-utils zip

FLUTTER_DIR="${FLUTTER_HOME:-$HOME/.local/share/flutter}"

if [ -x "$FLUTTER_DIR/bin/flutter" ]; then
  "$FLUTTER_DIR/bin/flutter" upgrade
else
  cd /tmp
  curl -sL https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json -o flutter-releases.json

  FLUTTER_HASH=$(jq -r '.current_release.stable' flutter-releases.json)
  FLUTTER_BASE=$(jq -r '.base_url' flutter-releases.json)
  FLUTTER_ARCHIVE=$(jq -r --arg hash "$FLUTTER_HASH" '.releases[] | select(.hash == $hash and .channel == "stable") | .archive' flutter-releases.json | head -1)
  FLUTTER_VERSION=$(jq -r --arg hash "$FLUTTER_HASH" '.releases[] | select(.hash == $hash and .channel == "stable") | .version' flutter-releases.json | head -1)

  wget -O flutter.tar.xz "$FLUTTER_BASE/$FLUTTER_ARCHIVE"

  # The archive unpacks into a flutter directory, so extract it next to the target
  mkdir -p "$(dirname "$FLUTTER_DIR")"
  rm -rf "$FLUTTER_DIR"
  tar -xf flutter.tar.xz -C "$(dirname "$FLUTTER_DIR")"

  rm flutter.tar.xz flutter-releases.json
  cd -

  echo "Flutter $FLUTTER_VERSION is installed in $FLUTTER_DIR."
fi

echo "Open a new terminal so flutter and dart are on PATH."
echo "Once the Android SDK and its command-line tools are set up, check the toolchain with:"
echo "  flutter doctor -v"
