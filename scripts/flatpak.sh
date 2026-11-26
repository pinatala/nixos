#!/usr/bin/env bash

set -e

echo "===================================="
echo "     Flatpak Application Installer"
echo "===================================="

APPS=(
    "ai.storyteller.wordcraft|flatpark"
    "com.bitwarden.desktop|flathub"
    "org.mozilla.firefox|flathub"
    "com.github.tchx84.Flatseal|flathub"
    "com.vysp3r.ProtonPlus|flathub"
    "net.audiorelay.AudioRelay|flathub"
    "net.lutris.Lutris|flathub"
    "org.freedownloadmanager.Manager|flathub"
    "org.localsend.localsend_app|flathub"
    "org.rncbc.qpwgraph|flathub"
    "org.videolan.VLC|flathub"
)

for APP in "${APPS[@]}"; do
    IFS='|' read -r APP_ID REMOTE <<< "$APP"

    echo ""
    echo "[+] Installing $APP_ID from $REMOTE..."

    if flatpak install --system -y --noninteractive "$REMOTE" "$APP_ID"; then
        echo "[✓] Successfully installed $APP_ID"
    else
        echo "[!] Failed to install $APP_ID"
    fi
done

echo ""
echo "===================================="
echo "       Installation Completed"
echo "===================================="

flatpak list --system --app
