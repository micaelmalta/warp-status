#!/bin/bash

set -e

REPO="https://raw.githubusercontent.com/micaelmalta/warp-status/main"

# Install SwiftBar
if ! command -v swiftbar &>/dev/null && ! [ -d "/Applications/SwiftBar.app" ]; then
    echo "Installing SwiftBar..."
    brew install swiftbar
fi

# Use existing SwiftBar plugin directory if already configured, otherwise use default
EXISTING_DIR=$(defaults read com.ameba.SwiftBar PluginDirectory 2>/dev/null || echo "")
if [ -n "$EXISTING_DIR" ] && [ -d "$EXISTING_DIR" ]; then
    PLUGIN_DIR="$EXISTING_DIR"
    echo "Using existing SwiftBar plugin directory: $PLUGIN_DIR"
else
    PLUGIN_DIR="$HOME/.config/swiftbar/plugins"
    mkdir -p "$PLUGIN_DIR"
    defaults write com.ameba.SwiftBar PluginDirectory -string "$PLUGIN_DIR"
fi

# Download or copy plugin
LOCAL="$(cd "$(dirname "$0")" && pwd)/plugins/cf_warp_status.5s.sh"
DEST="$PLUGIN_DIR/cf_warp_status.5s.sh"
if [ -f "$LOCAL" ]; then
    SRC_MD5=$(md5 -q "$LOCAL")
    DEST_MD5=$([ -f "$DEST" ] && md5 -q "$DEST" || echo "")
    if [ "$SRC_MD5" != "$DEST_MD5" ]; then
        cp "$LOCAL" "$DEST"
    fi
else
    echo "Downloading plugin..."
    curl -fsSL "$REPO/plugins/cf_warp_status.5s.sh" -o "$DEST"
fi

chmod +x "$PLUGIN_DIR/cf_warp_status.5s.sh"

# Restart SwiftBar
killall SwiftBar || true

# Open SwiftBar
open -a SwiftBar

echo ""
echo "Done! SwiftBar should be running now."
