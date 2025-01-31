#!/bin/zsh

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew
brew update
brew upgrade

# Install essential command line tools
brew install git

# Install applications via Homebrew Cask
brew install --cask spotify ogdesign-eagle obsidian firefox@developer-edition zed

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


# Create developer directory
mkdir -p ~/Developer

# Configure git
git config --global user.name "Skyrmo"
git config --global user.email "owaingskyrme@gmail.com"

brew install zsh-syntax-highlighting zsh-autosuggestions

# Create .zshrc configuration
cat >> ~/.zshrc << 'EOL'
# Path exports
export PATH="/usr/local/bin:$PATH"

# Aliases
alias py='python3'

# Enable syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Enable auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
EOL

# Install Starship
brew install starship

# Add Starship to .zshrc
if ! grep -q 'starship init zsh' ~/.zshrc; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

# Create config directory if it doesn't exist
mkdir -p ~/.config

# Symlink starship.toml from dotfiles to .config
if [[ -f "$PWD/starship.toml" ]]; then
    ln -sf "$PWD/starship.toml" ~/.config/starship.toml
fi

ZED_CONFIG_DIR="$HOME/.config/zed"
mkdir -p "$ZED_CONFIG_DIR"

# Copy your settings JSON into the Zed config folder
if [[ -f "./zed-settings.json" ]]; then
    cp ./zed-settings.json "$ZED_CONFIG_DIR/settings.json"
    echo "Zed settings copied successfully."
else
    echo "Zed settings file not found. Skipping copy."
fi

# Copy your keymaps JSON into the Zed config folder
if [[ -f "./zed-keymap.json" ]]; then
    cp ./zed-keymap.json "$ZED_CONFIG_DIR/keymap.json"
    echo "Zed key bindings copied successfully."
else
    echo "Zed key bindings file not found. Skipping copy."
fi


# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc

source ~/.zshrc

# download and install Node.js (you may need to restart the terminal)
nvm install 22



echo "Setup complete! Please restart your computer for all changes to take effect."
