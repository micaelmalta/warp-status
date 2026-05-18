#!/bin/bash

WARP_RAW=$(/usr/local/bin/warp-cli status 2>&1)

if [[ "$WARP_RAW" == *"Connected"* ]] && [[ "$WARP_RAW" == *"healthy"* ]]; then
    echo "WARP | color=#FFFFFF,#FFFFFF size=13 font=Menlo-Bold tooltip=Connected · healthy"
    echo "---"
    echo "WARP: Connected"
    echo "Network: Healthy"
elif [[ "$WARP_RAW" == *"Connected"* ]]; then
    echo "⚠ WARP | color=#FFD60A,#FFD60A size=13 font=Menlo-Bold tooltip=Connected · network unstable"
    echo "---"
    echo "WARP: Connected"
    echo "Network: Unstable"
    echo "Raw Output:"
    echo "$WARP_RAW" | sed 's/^/-- /'
else
    echo "✕ WARP | color=#FF3B30,#FF453A size=13 font=Menlo-Bold tooltip=Disconnected"
    echo "---"
    echo "WARP: Disconnected"
    echo "Raw Output:"
    echo "$WARP_RAW" | sed 's/^/-- /'
fi
