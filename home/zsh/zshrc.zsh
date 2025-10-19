# === Options ===
setopt AUTO_CD
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# === Plugins & Theme ===
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8a8a8a"

source @p10kTheme@
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# === Functions ===
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# === Environment ===
export PATH="$HOME/.nix-profile/bin:$PATH"
export ANTHROPIC_BASE_URL="https://www.88code.org/api"
export ANTHROPIC_AUTH_TOKEN="88_12d9277bbd33440e432294d1f80b11bced198002f85ddee298baeb89d7d69dff"
export OPENAI_BASE_URL="https://www.88code.org/openai/v1"
export OPENAI_API_KEY="88_12d9277bbd33440e432294d1f80b11bced198002f85ddee298baeb89d7d69dff"
