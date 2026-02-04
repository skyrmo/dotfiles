#!/bin/zsh

echo "Setting up programming language environments..."

# Source the shell configuration to ensure pyenv and nvm are available
source ~/.zprofile 2>/dev/null
source ~/.zshrc 2>/dev/null

# Install Python 3.12.0 via pyenv
if command -v pyenv &> /dev/null; then
    echo "Installing Python 3.12.0 via pyenv..."
    pyenv install 3.12.0 --skip-existing
    pyenv global 3.12.0
    echo "Python 3.12.0 installed and set as global version."
else
    echo "pyenv not found. Skipping Python installation."
fi

# Install Node via nvm
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    echo "Installing Node.js via nvm..."
    source "/opt/homebrew/opt/nvm/nvm.sh"
    nvm install node
    nvm use node
    echo "Node.js installed via nvm."
else
    echo "nvm not found. Skipping Node installation."
fi

# Install Rust via rustup
echo "Installing Rust via rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
echo "Rust installed successfully."

echo "Language environments setup complete!"
