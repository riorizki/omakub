#!/bin/bash

rm -rf "${FLUTTER_HOME:-$HOME/.local/share/flutter}"

echo "Removed the Flutter SDK. The pub cache in ~/.pub-cache was left in place."
