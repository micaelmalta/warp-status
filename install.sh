#!/bin/bash

set -e

PLUGIN_DIR="$HOME/.config/swiftbar/plugins"
REPO="https://raw.githubusercontent.com/micaelmalta/warp-status/main"

# Install SwiftBar
if ! command -v swiftbar &>/dev/null && ! [ -d "/Applications/SwiftBar.app" ]; then
    echo "Installing SwiftBar..."
    brew install swiftbar
fi

# Create plugin directory
mkdir -p "$PLUGIN_DIR"

# Set the plugin directory in the environment
defaults write com.ameba.SwiftBar PluginDirectory -string "$PLUGIN_DIR"

# Download or copy plugin
LOCAL="$(cd "$(dirname "$0")" && pwd)/plugins/cf_warp_status.5s.sh"
if [ -f "$LOCAL" ] && [ "$LOCAL" != "$PLUGIN_DIR/cf_warp_status.5s.sh" ]; then
    cp "$LOCAL" "$PLUGIN_DIR/"
elif [ ! -f "$LOCAL" ]; then
    echo "Downloading plugin..."
    curl -fsSL "$REPO/plugins/cf_warp_status.5s.sh" -o "$PLUGIN_DIR/cf_warp_status.5s.sh"
fi

chmod +x "$PLUGIN_DIR/cf_warp_status.5s.sh"

# Restart SwiftBar
killall SwiftBar || true

# Open SwiftBar
open -a SwiftBar

echo ""
echo "Done! SwiftBar should be running now."
