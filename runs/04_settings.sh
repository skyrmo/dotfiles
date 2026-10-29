#!/bin/zsh

# Create developer directory
mkdir -p ~/Developer

# Configure git
git config --global user.name "Skyrmo"
git config --global user.email "owaingskyrme@gmail.com"

# Move the dock to the right hand side
defaults write com.apple.dock orientation -string "right" && killall Dock

# Turn on auto hiding the dock
defaults write com.apple.dock autohide -bool true && killall Dock

# Turn off show recent apps in the dock
defaults write com.apple.dock show-recents -bool false && killall Dock

# Turn on the firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on


# Appearance
defaults write -g AppleAccentColor -int -1
defaults write -g AppleAquaColorVariant -int 6
defaults write -g AppleIconAppearanceTheme -string "ClearAutomatic"
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true
defaults write -g NSGlassBuddyTintAmount -float 0.7

# Keyboard
defaults write -g AppleKeyboardUIMode -int 0
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# Trackpad
defaults write -g com.apple.trackpad.forceClick -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0

# Apply Dock changes
killall Dock
