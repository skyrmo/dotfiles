#!/bin/zsh

echo "Setting up GitHub SSH..."

# Update git to the latest version
echo "Installing Git..."
brew install git

# Install the GitHub CLI
echo "Installing GitHub CLI..."
brew install gh


echo "Creating new SSH key..."
ssh-keygen -t ed25519 -C "owaingskyrme@gmail.com" -f ~/.ssh/id_ed25519


# Create SSH config file if it doesn't exist
if [[ ! -f ~/.ssh/config ]]; then
    echo "Creating SSH config file..."
    touch ~/.ssh/config
fi

# Check if GitHub host entry already exists in config
if ! grep -q "Host github.com" ~/.ssh/config 2>/dev/null; then
    echo "Adding GitHub configuration to SSH config..."
    cat >> ~/.ssh/config << 'EOL'

Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOL
else
    echo "GitHub SSH config already exists."
fi

# Add private key to the ssh-agent
echo "Adding SSH key to ssh-agent..."
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Copy public key to clipboard
echo "Copying SSH public key to clipboard..."
pbcopy < ~/.ssh/id_ed25519.pub

echo ""
echo "================================================"
echo "SSH key has been copied to your clipboard!"
echo ""
echo "Next steps:"
echo "1. Go to https://github.com/settings/keys"
echo "2. Click 'New SSH key'"
echo "3. Give it a title (e.g., 'MacBook Pro')"
echo "4. Paste the key (it's already in your clipboard)"
echo "5. Click 'Add SSH key'"
echo ""
echo "Press Enter after you've added the key to GitHub..."
read

# Test SSH connection to GitHub
echo "Testing SSH connection to GitHub..."
ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"
if [ $? -eq 0 ]; then
    echo "SSH connection to GitHub successful!"
else
    echo "SSH test failed. You may need to add your SSH key to GitHub."
    echo "Running ssh test again for debugging:"
    ssh -T git@github.com
fi

echo "Git and GitHub SSH setup complete!"
