# #!/bin/bash

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

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

# add starship terminal
eval "$(starship init zsh)"
EOL
