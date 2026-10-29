#!/bin/zsh

echo "Setting up programming language environments..."

# Source the shell configuration to ensure uv and vp are available
source ~/.zprofile 2>/dev/null
source ~/.zshrc 2>/dev/null

# Install the latest stable Python via uv. Unlike pyenv, uv puts no `python` on
# PATH unless --default is passed, which adds the `python`/`python3` shims to
# ~/.local/bin (see the PATH line in the generated .zshrc). --force keeps this
# re-runnable; without it a second run fails but still exits 0.
if command -v uv &> /dev/null; then
    echo "Installing the latest Python via uv..."
    if uv python install --default --force --preview-features python-install-default; then
        export PATH="$HOME/.local/bin:$PATH"
        echo "Python installed via uv: $(python --version 2>&1)"
    else
        echo "uv failed to install Python. Skipping Python installation."
    fi
else
    echo "uv not found. Skipping Python installation."
fi

# Install Node via Vite+. `vp env setup` creates the shims and the env file
# that ~/.zshrc sources; re-source it so `node` resolves in this script.
if command -v vp &> /dev/null; then
    echo "Installing Node.js (LTS) via Vite+..."
    vp env setup
    . "$HOME/.config/vite-plus/env"
    vp env default lts
    if vp env install; then
        echo "Node.js installed via Vite+: $(node --version)"
    else
        echo "Vite+ failed to install Node. Skipping Node installation."
    fi
else
    echo "vp not found. Skipping Node installation."
fi

# Install Rust via rustup
echo "Installing Rust via rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
echo "Rust installed successfully."

echo "Language environments setup complete!"
