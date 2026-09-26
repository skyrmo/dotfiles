#!/bin/zsh

echo "Setting up programming language environments..."

# Source the shell configuration to ensure uv and fnm are available
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

# Older setups had pnpm shim `node` into $PNPM_HOME/bin to manage the runtime
# itself; fnm owns Node now, so clear out any leftover shim before it can
# shadow fnm's node on PATH. No-op on a fresh machine, where this file never
# existed in the first place.
PNPM_HOME="$HOME/Library/pnpm"
if [[ -L "$PNPM_HOME/bin/node" ]]; then
    rm -f "$PNPM_HOME/bin/node" "$PNPM_HOME/bin/.pnpm-shim-v1-node-target"
fi

# Install Node via fnm. `fnm env` (sourced via ~/.zshrc above) must run first
# so the fnm multishell dir is on PATH before `node`/`fnm` resolve.
if command -v fnm &> /dev/null; then
    echo "Installing Node.js (LTS) via fnm..."
    if fnm install --lts; then
        fnm default lts-latest
        eval "$(fnm env --use-on-cd --shell zsh)"
        echo "Node.js installed via fnm: $(node --version)"
    else
        echo "fnm failed to install Node. Skipping Node installation."
    fi
else
    echo "fnm not found. Skipping Node installation."
fi

# Install Rust via rustup
echo "Installing Rust via rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
echo "Rust installed successfully."

echo "Language environments setup complete!"
