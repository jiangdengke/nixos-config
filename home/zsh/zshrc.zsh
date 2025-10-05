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
