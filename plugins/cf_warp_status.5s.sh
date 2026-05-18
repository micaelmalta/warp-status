#!/bin/bash

# Fetch the raw status from warp-cli
WARP_RAW=$(/usr/local/bin/warp-cli status 2>&1)
# WARP_RAW="Disconnected"

# Check if the status contains BOTH "Connected" and "healthy"
if [[ "$WARP_RAW" == *"Connected"* ]] && [[ "$WARP_RAW" == *"healthy"* ]]; then
    echo "WARP | color=#FFFFFF,#FFFFFF size=13 font=Menlo-Bold tooltip=Connected · healthy"
    echo "---"
    echo "WARP: Connected"
    echo "Network: Healthy"
else
    echo "⚠ WARP | color=#FFD60A,#FFD60A size=13 font=Menlo-Bold tooltip=Disconnected or unhealthy"
    echo "---"
    echo "WARP: Disconnected or Unhealthy"
    echo "Raw Output:"
    echo "$WARP_RAW" | sed 's/^/-- /'
fi
