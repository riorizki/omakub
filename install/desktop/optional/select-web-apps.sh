#!/bin/bash

source $OMAKUB_PATH/defaults/bash/functions

AVAILABLE_WEB_APPS=("Basecamp" "Chat GPT" "Google Photos" "Google Contacts" "HEY" "Tailscale")
apps=$(gum choose "${AVAILABLE_WEB_APPS[@]}" --no-limit --height 8 --header "Select web apps")

if [[ -n "$apps" ]]; then
  IFS=$'\n'
  for app in $apps; do
    case $app in
    "Basecamp")
      web2app 'Basecamp' https://launchpad.37signals.com "file://$OMAKUB_PATH/applications/icons/Basecamp.png"
      app2folder 'Basecamp.desktop' WebApps
      ;;
    "Chat GPT")
      web2app 'Chat GPT' https://chatgpt.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/chatgpt.png
      app2folder 'Chat GPT.desktop' WebApps
      ;;
    "Google Photos")
      web2app 'Google Photos' https://photos.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-photos.png
      app2folder 'Google Photos.desktop' WebApps
      ;;
    "Google Contacts")
      web2app 'Google Contacts' https://contacts.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-contacts.png
      app2folder 'Google Contacts.desktop' WebApps
      ;;
    "HEY")
      web2app 'HEY' https://app.hey.com/ "file://$OMAKUB_PATH/applications/icons/HEY.png"
      app2folder 'HEY.desktop' WebApps
      ;;
    "Tailscale")
      web2app 'Tailscale' https://login.tailscale.com/admin/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/tailscale-light.png
      app2folder 'Tailscale.desktop' WebApps
      ;;
    esac
  done
fi
