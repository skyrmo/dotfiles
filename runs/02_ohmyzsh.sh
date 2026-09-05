# #!/bin/bash

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


# Create .zshrc configuration (overwrite)
cat > ~/.zshrc << 'EOL'
# ---------- PATH (base) ----------
export PATH="/opt/homebrew/bin:$PATH"

# ---------- nvm (lazy-loaded) ----------
export NVM_DIR="$HOME/.nvm"

() {
  setopt localoptions nullglob numericglobsort
  local ver="" dir="" dirs
  [ -r "$NVM_DIR/alias/default" ] && ver="$(<"$NVM_DIR/alias/default")"
  case "$ver" in
    v[0-9]*) dir="$NVM_DIR/versions/node/$ver" ;;
    [0-9]*)  dir="$NVM_DIR/versions/node/v$ver" ;;
    # `node`/`stable`/`default`/unset all mean "newest installed".
    *)       dirs=("$NVM_DIR"/versions/node/v*(/)); dir="${dirs[-1]}" ;;
  esac
  [ -x "$dir/bin/node" ] && export PATH="$dir/bin:$PATH"
}

# Only `nvm` itself needs the full script; node/npm/npx/pnpm are on PATH above.
nvm() {
  unfunction nvm
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"

  # Loading this after Oh My Zsh means it skips its own redundant compinit.
  #
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  nvm "$@"
}

# ---------- Oh My Zsh ----------
# Empty theme: starship owns the prompt, so loading an omz theme is wasted work.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ---------- aliases ----------
alias py='uv run python'

# ---------- zsh plugins ----------
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# ---------- prompt ----------
eval "$(starship init zsh)"

EOL
