#!/bin/bash

set -e
trap 'echo "Error: install.sh failed on line $LINENO" >&2' ERR
TMP=""
trap '[[ -n "$TMP" ]] && rm -f "$TMP"' EXIT

REPO="https://raw.githubusercontent.com/micaelmalta/warp-status/main"

# Install SwiftBar
if ! [ -d "/Applications/SwiftBar.app" ] && ! [ -d "$HOME/Applications/SwiftBar.app" ]; then
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
LOCAL="$(cd "$(dirname "$0")" && pwd)/plugins/cf_warp_status.30s.sh"
DEST="$PLUGIN_DIR/cf_warp_status.30s.sh"
if [ -f "$LOCAL" ]; then
    SRC_SHA=$(shasum -a 256 "$LOCAL" | awk '{print $1}')
    DEST_SHA=$([ -f "$DEST" ] && shasum -a 256 "$DEST" | awk '{print $1}' || echo "")
    if [ "$SRC_SHA" != "$DEST_SHA" ]; then
        cp "$LOCAL" "$DEST"
    fi
else
    echo "Downloading plugin..."
    TMP=$(mktemp)
    curl -fsSL "$REPO/plugins/cf_warp_status.30s.sh" -o "$TMP"
    cp "$TMP" "$DEST"
fi

chmod +x "$PLUGIN_DIR/cf_warp_status.30s.sh"

# Restart SwiftBar
killall SwiftBar 2>/dev/null || true
sleep 1

# Open SwiftBar
open -a SwiftBar

echo ""
echo "Done! SwiftBar should be running now."
