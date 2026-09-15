#!/bin/bash

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'

# Yaru has no green or grey variants, orange is plain Yaru, and Ubuntu 26.04 renamed bark to wartybrown
case "$OMAKUB_THEME_COLOR" in
green) YARU_COLOR="sage" ;;
grey | orange) YARU_COLOR="" ;;
bark) [ -d /usr/share/themes/Yaru-bark-dark ] && YARU_COLOR="bark" || YARU_COLOR="wartybrown" ;;
*) YARU_COLOR="$OMAKUB_THEME_COLOR" ;;
esac
YARU_THEME="Yaru${YARU_COLOR:+-$YARU_COLOR}"

# GNOME only accepts blue, teal, green, yellow, orange, red, pink, purple and slate as accent colors
case "$OMAKUB_THEME_COLOR" in
sage) ACCENT_COLOR="green" ;;
bark) ACCENT_COLOR="orange" ;;
magenta) ACCENT_COLOR="pink" ;;
grey) ACCENT_COLOR="slate" ;;
*) ACCENT_COLOR="$OMAKUB_THEME_COLOR" ;;
esac

gsettings set org.gnome.desktop.interface gtk-theme "$YARU_THEME-dark"
gsettings set org.gnome.desktop.interface icon-theme "$YARU_THEME"
gsettings set org.gnome.desktop.interface accent-color "$ACCENT_COLOR" 2>/dev/null || true

BACKGROUND_ORG_PATH="$HOME/.local/share/omakub/themes/$OMAKUB_THEME_BACKGROUND"
BACKGROUND_DEST_DIR="$HOME/.local/share/backgrounds"
BACKGROUND_DEST_PATH="$BACKGROUND_DEST_DIR/$(echo $OMAKUB_THEME_BACKGROUND | tr '/' '-')"

if [ ! -d "$BACKGROUND_DEST_DIR" ]; then mkdir -p "$BACKGROUND_DEST_DIR"; fi

[ ! -f $BACKGROUND_DEST_PATH ] && cp $BACKGROUND_ORG_PATH $BACKGROUND_DEST_PATH
gsettings set org.gnome.desktop.background picture-uri $BACKGROUND_DEST_PATH
gsettings set org.gnome.desktop.background picture-uri-dark $BACKGROUND_DEST_PATH
gsettings set org.gnome.desktop.background picture-options 'zoom'
