#!/bin/zsh

# Create config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Copy starship.toml from dotfiles to .config
if [[ -f "$HOME/.dotfiles/runs/starship.toml" ]]; then
    cp "$HOME/.dotfiles/runs/starship.toml" "$HOME/.config/starship.toml"
fi
