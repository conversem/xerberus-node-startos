#!/bin/sh

# Find the xerberus binary
XERBERUS_BIN=$(find / -name "xerberus*" -type f -executable 2>/dev/null | head -n 1)

if [ -z "$XERBERUS_BIN" ]; then
    echo "Error: Could not find xerberus binary"
    exit 1
fi

# Use tini as init system
exec tini -- $XERBERUS_BIN \
    --name "StartOS Node" \
    --chain xerberus \
    --base-path /root/data \
    --port 30333 \
    --rpc-port 9933 \
    --ws-port 9944 \
    --prometheus-port 9615 \
    --rpc-cors all \
    --ws-external \
    --rpc-external \
    --rpc-methods Safe \
    --pruning archive
