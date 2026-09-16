#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Give people a chance to retry running the installation
omakub_install_failed() {
  echo "Omakub installation failed!"
  [[ -n $OMAKUB_INSTALL_LOG ]] && echo "The full output is saved in $OMAKUB_INSTALL_LOG"

  if command -v gum &>/dev/null && gum confirm "Retry the installation?"; then
    exec bash ~/.local/share/omakub/install.sh
  fi

  echo "You can retry later by running: source ~/.local/share/omakub/install.sh"
}
trap omakub_install_failed ERR

# Check the distribution name and version and abort if incompatible
source ~/.local/share/omakub/install/check-version.sh

# Ask for app choices
echo "Get ready to make a few choices..."
source ~/.local/share/omakub/install/terminal/required/app-gum.sh >/dev/null
source ~/.local/share/omakub/install/first-run-choices.sh
source ~/.local/share/omakub/install/identification.sh

# Desktop software and tweaks will only be installed if we're running Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  # Ensure computer doesn't go to sleep or lock while installing
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  gsettings set org.gnome.desktop.session idle-delay 0

  # Revert to normal idle and lock settings if the installation fails
  trap 'gsettings set org.gnome.desktop.screensaver lock-enabled true; gsettings set org.gnome.desktop.session idle-delay 300; omakub_install_failed' ERR

  echo "Installing terminal and desktop tools..."

  # Install terminal tools
  source ~/.local/share/omakub/install/terminal.sh

  # Install desktop tools and tweaks
  source ~/.local/share/omakub/install/desktop.sh

  # Revert to normal idle and lock settings
  gsettings set org.gnome.desktop.screensaver lock-enabled true
  gsettings set org.gnome.desktop.session idle-delay 300
else
  echo "Only installing terminal tools..."
  source ~/.local/share/omakub/install/terminal.sh
fi
