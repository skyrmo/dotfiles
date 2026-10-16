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

# ---------- pnpm (global bins only; Vite+ owns Node and pnpm itself) ----------
export PNPM_HOME="$HOME/Library/pnpm"
[ -d "$PNPM_HOME/bin" ] && export PATH="$PNPM_HOME/bin:$PATH"

# ---------- Vite+ (Node + package manager shims) ----------
# Also sourced from ~/.zshenv by `vp env setup`, but re-sourced here so the
# shims end up ahead of the homebrew/path_helper entries above. Guarded because
# the file only exists after `vp env setup` (runs/03_languages.sh).
[ -f "$HOME/.config/vite-plus/env" ] && . "$HOME/.config/vite-plus/env"


# ---------- Oh My Zsh ----------
# Empty theme: starship owns the prompt, so loading an omz theme is wasted work.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ---------- aliases ----------
alias py='uv run --no-project python'
alias weather='curl wttr.in'

# ---------- zsh plugins ----------
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# ---------- prompt ----------
eval "$(starship init zsh)"

# ---------- syntax highlighting ----------
# Must be sourced last so it can wrap every zle widget defined above.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

EOL
