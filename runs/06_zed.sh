#!/bin/zsh

# Create config directory if it doesn't exist
mkdir -p ~/.config

ZED_CONFIG_DIR="$HOME/.config/zed"
mkdir -p "$ZED_CONFIG_DIR"

# Copy your settings JSON into the Zed config folder
if [[ -f "$HOME/.dotfiles/runs/zed-settings.json" ]]; then
    cp "$HOME/.dotfiles/runs/zed-settings.json" "$ZED_CONFIG_DIR/settings.json"
    echo "Zed settings copied successfully."
else
    echo "Zed settings file not found. Skipping copy."
fi

# Copy your keymaps JSON into the Zed config folder
if [[ -f "$HOME/.dotfiles/runs/zed-keymap.json" ]]; then
    cp "$HOME/.dotfiles/runs/zed-keymap.json" "$ZED_CONFIG_DIR/keymap.json"
    echo "Zed key bindings copied successfully."
else
    echo "Zed key bindings file not found. Skipping copy."
fi
