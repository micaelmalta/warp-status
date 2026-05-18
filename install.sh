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

# Download or copy plugin
if [ -f "$(dirname "$0")/plugins/cf_warp_status.5s.sh" ]; then
    cp "$(dirname "$0")/plugins/cf_warp_status.5s.sh" "$PLUGIN_DIR/"
else
    echo "Downloading plugin..."
    curl -fsSL "$REPO/plugins/cf_warp_status.5s.sh" -o "$PLUGIN_DIR/cf_warp_status.5s.sh"
fi

chmod +x "$PLUGIN_DIR/cf_warp_status.5s.sh"

echo ""
echo "Done! Open SwiftBar and set the plugin directory to: $PLUGIN_DIR"
