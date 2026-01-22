#!/bin/zsh

# Create config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Copy starship.toml from dotfiles to .config
if [[ -f "$HOME/.dotfiles/runs/starship.toml" ]]; then
    cp "$HOME/.dotfiles/runs/starship.toml" "$HOME/.config/starship.toml"
    echo "Starship config copied successfully."
fi

# Create ghostty config directory
mkdir -p "$HOME/.config/ghostty"
# mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"

# Copy ghostty config
if [[ -f "$HOME/.dotfiles/runs/ghostty-config" ]]; then
    # XDG standard path (recommended for consistency)
    cp "$HOME/.dotfiles/runs/ghostty-config" "$HOME/.config/ghostty/config"
    # cp "$HOME/.dotfiles/runs/ghostty-config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
    echo "Ghostty config copied successfully."


fi
