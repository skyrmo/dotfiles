#!/bin/zsh

# Create developer directory
mkdir -p ~/Developer

# Configure git
git config --global user.name "Skyrmo"
git config --global user.email "owaingskyrme@gmail.com"

# Set macos to dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark" && killall SystemUIServer

# Move the dock to the right hand side
defaults write com.apple.dock orientation -string "right" && killall Dock

# Turn on auto hiding the dock
defaults write com.apple.dock autohide -bool true && killall Dock

# Turn off show recent apps in the dock
defaults write com.apple.dock show-recents -bool false && killall Dock

# Turn on the firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# set keyboard to repeat as fast as possible
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
