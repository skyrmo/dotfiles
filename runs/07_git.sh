#!/bin/zsh

echo "Setting up Git and GitHub SSH..."

# Update git to the latest version
echo "Installing/updating Git..."
brew install git

# Install the GitHub CLI
echo "Installing GitHub CLI..."
brew install gh

# Create .ssh directory if it doesn't exist
mkdir -p ~/.ssh

# Create a new SSH key (will prompt for passphrase)
echo "Creating new SSH key..."
echo "Press Enter when prompted for passphrase if you don't want one"
ssh-keygen -t ed25519 -C "owaingskyrme@gmail.com" -f ~/.ssh/id_ed25519

# Create SSH config file
echo "Creating SSH config file..."
cat > ~/.ssh/config << 'EOL'
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOL

# Set correct permissions for SSH files
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# Start ssh-agent if needed
eval "$(ssh-agent -s)"

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
ssh -T git@github.com

echo ""
echo "Git and GitHub SSH setup complete!"
