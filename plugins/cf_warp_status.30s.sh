#!/bin/bash

# <xbar.title>WARP Status</xbar.title>
# <xbar.version>v0.0.1</xbar.version>
# <xbar.author>Micael Malta</xbar.author>
# <xbar.author.github>micaelmalta</xbar.author.github>
# <xbar.desc>Shows Cloudflare WARP connection status in the macOS menu bar</xbar.desc>
# <xbar.dependencies>warp-cli</xbar.dependencies>
# <xbar.abouturl>https://github.com/micaelmalta/warp-status</xbar.abouturl>

WARP_CLI=/usr/local/bin/warp-cli
WARP_RAW=$($WARP_CLI status 2>&1)

if [[ "$WARP_RAW" == *"Connected"* ]] && [[ "$WARP_RAW" == *"healthy"* ]]; then
    echo "WARP | color=#FFFFFF,#FFFFFF size=13 font=Menlo-Bold tooltip=Connected · healthy"
    echo "---"
    echo "WARP: Connected"
    echo "Network: Healthy"
    echo "---"
    echo "Disconnect | bash=$WARP_CLI param1=disconnect terminal=false refresh=true"

elif [[ "$WARP_RAW" == *"Connected"* ]]; then
    echo "⚠ WARP | color=#FFD60A,#FFD60A size=13 font=Menlo-Bold tooltip=Connected · network unstable"
    echo "---"
    echo "WARP: Connected"
    echo "Network: Unstable"
    echo "---"
    echo "Reconnect | bash=$WARP_CLI param1=disconnect terminal=false refresh=true"
    echo "Raw Output:"
    echo "$WARP_RAW" | sed 's/^/-- /'

else
    echo "✕ WARP | color=#FF3B30,#FF453A size=13 font=Menlo-Bold tooltip=Disconnected"
    echo "---"
    echo "WARP: Disconnected"
    echo "---"
    echo "Connect | bash=$WARP_CLI param1=connect terminal=false refresh=true color=#34C759"
    echo "Raw Output:"
    echo "$WARP_RAW" | sed 's/^/-- /'
fi
