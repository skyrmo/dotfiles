#!/bin/bash

echo "Checking for macOS software updates..."

# List available updates
updates=$(softwareupdate -l 2>&1)

if echo "$updates" | grep -q "No new software available"; then
    echo "macOS is up to date. No updates available."
    exit 0
fi

echo ""
echo "Available updates:"
echo "$updates"
echo ""

# Prompt user for confirmation
read -p "Would you like to install all available updates? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing updates... This may take a while."
    sudo softwareupdate -i -a

    echo ""
    echo "Updates installed!"

    # Check if restart is required
    if echo "$updates" | grep -qi "restart"; then
        echo ""
        read -p "Some updates require a restart. Restart now? (y/n) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            sudo shutdown -r now
        else
            echo "Please restart your Mac when convenient to complete the updates."
        fi
    fi
else
    echo "Skipping updates. You can run them later with: softwareupdate -i -a"
fi
