# #!/bin/bash

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


# Create .zshrc configuration (overwrite)
cat > ~/.zshrc << 'EOL'
# ---------- PATH (base) ----------
export PATH="/opt/homebrew/bin:$PATH"

# uv installs the `python`/`python3` shims here; without this there is no
# `python` on PATH at all and `python3` falls back to the old system one.
export PATH="$HOME/.local/bin:$PATH"

# ---------- pnpm (also manages the global Node version) ----------
# pnpm is the standalone Homebrew build, so it ships its own Node and can
# install the global `node` binary into $PNPM_HOME/bin itself.
export PNPM_HOME="$HOME/Library/pnpm"
[ -d "$PNPM_HOME/bin" ] && export PATH="$PNPM_HOME/bin:$PATH"

# ---------- Oh My Zsh ----------
# Empty theme: starship owns the prompt, so loading an omz theme is wasted work.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ---------- aliases ----------
alias py='uv run --no-project python'

# ---------- zsh plugins ----------
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# ---------- prompt ----------
eval "$(starship init zsh)"

EOL
