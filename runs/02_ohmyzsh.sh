# #!/bin/bash

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


# Create .zshrc configuration (overwrite)
cat > ~/.zshrc << 'EOL'
# ---------- PATH (base) ----------
export PATH="/opt/homebrew/bin:$PATH"

# ---------- pyenv ----------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# ---------- nvm ----------
export NVM_DIR="$HOME/.nvm"

# Homebrew-installed nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# ---------- Oh My Zsh ----------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ---------- aliases ----------
alias py='python'

# ---------- zsh plugins ----------
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# ---------- prompt ----------
eval "$(starship init zsh)"

# ---------- pyenv (interactive shell) ----------
eval "$(pyenv init -)"

EOL
