#!/bin/bash

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

# Create .zshrc configuration
cat > ~/.zshrc << 'EOL'
# Path exports
export PATH="/usr/local/bin:$PATH"

# Aliases
alias py='python3'

# Enable syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Enable auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
EOL

brew install zsh-syntax-highlighting zsh-autosuggestions

# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Add Starship to .zshrc
cat >> ~/.zshrc << 'EOL'

# Initialize Starship prompt
eval "$(starship init zsh)"
EOL

# Create config directory if it doesn't exist
mkdir -p ~/.config

# Symlink starship.toml from dotfiles to .config
ln -sf "$PWD/starship.toml" ~/.config/starship.toml

ZED_CONFIG_DIR="$HOME/.config/zed"
mkdir -p "$ZED_CONFIG_DIR"

# Copy your settings JSON into the Zed config folder
echo "Copying settings into Zed configuration..."
cp ./zed-settings.json "$ZED_CONFIG_DIR/settings.json"


killall Finder
killall Dock

# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# download and install Node.js (you may need to restart the terminal)
nvm install 22




echo "Setup complete! Please restart your computer for all changes to take effect."
