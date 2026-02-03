#!/bin/bash

echo "Checking for Xcode Command Line Tools..."

# Check if Xcode Command Line Tools are already installed
if xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools are already installed."
    exit 0
fi

echo "Xcode Command Line Tools not found. Installing..."
xcode-select --install

echo ""
echo "A dialog window has opened. Please click 'Install' to proceed."
echo ""
read -p "Press Enter once the installation has completed..."

# Verify installation succeeded
if ! xcode-select -p &>/dev/null; then
    echo "Error: Xcode Command Line Tools installation failed or was cancelled."
    echo "Please run 'xcode-select --install' manually and try again."
    exit 1
fi

# Verify tools are working
if ! git --version &>/dev/null; then
    echo "Error: Installation completed but tools are not working."
    echo "Please restart your terminal and try again."
    exit 1
fi

echo "Xcode Command Line Tools installed successfully!"
