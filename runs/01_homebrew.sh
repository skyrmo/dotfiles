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
brew install git \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    starship

# Install applications via Homebrew Cask
brew install --cask spotify \
    adguard \
    ogdesign-eagle \
    obsidian \
    google-chrome@canary \
    ghostty \
    nordvpn \
    zed


echo "Finished installing Homebrew & apps."
