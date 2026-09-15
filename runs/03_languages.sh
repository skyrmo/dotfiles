#!/bin/zsh

echo "Setting up programming language environments..."

# Source the shell configuration to ensure uv and pnpm are available
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

# Install Node via pnpm. The global bin dir must exist and be on PATH before
# pnpm will agree to install a runtime into it. `runtime set` is the
# replacement for the now-deprecated `env use`.
if command -v pnpm &> /dev/null; then
    echo "Installing Node.js (LTS) via pnpm..."
    export PNPM_HOME="$HOME/Library/pnpm"
    mkdir -p "$PNPM_HOME/bin"
    export PATH="$PNPM_HOME/bin:$PATH"

    if pnpm runtime set node lts -g; then
        echo "Node.js installed via pnpm: $(node --version)"
    else
        echo "pnpm failed to install Node. Skipping Node installation."
    fi
else
    echo "pnpm not found. Skipping Node installation."
fi

# Install Rust via rustup
echo "Installing Rust via rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
echo "Rust installed successfully."

echo "Language environments setup complete!"
