# ==================== Zim 框架初始化 ====================
# 这个文件在 Zim 框架下使用
# 替代之前的 zshrc.zsh

# ==================== Zim 基础设置 ====================
# Zim 安装目录（使用 ZDOTDIR）
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# 设置 zimrc 配置文件位置
ZIM_CONFIG_FILE=${ZDOTDIR:-${HOME}}/.zimrc

# 使用本地的 zimfw（从 ~/zimfw 仓库）
# 安装缺失的模块并初始化
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE} ]]; then
  source ${HOME}/zimfw/zimfw.zsh init -q
fi

# 初始化 Zim
source ${ZIM_HOME}/init.zsh

# ==================== ZSH 选项设置 ====================
# 自动切换目录（无需输入 cd 命令）
setopt AUTO_CD

# 扩展历史记录格式
setopt EXTENDED_HISTORY

# 历史记录去重（删除旧的重复项）
setopt HIST_EXPIRE_DUPS_FIRST

# 搜索历史时不显示重复项
setopt HIST_FIND_NO_DUPS

# 不记录重复的命令
setopt HIST_IGNORE_DUPS

# 不记录以空格开头的命令
setopt HIST_IGNORE_SPACE

# 多个 ZSH 会话共享历史记录
setopt SHARE_HISTORY

# ==================== magicmace 主题自定义 ====================
# 自定义颜色（可选）
# export COLOR_ROOT=red        # root 用户提示符颜色
# export COLOR_USER=cyan       # 普通用户提示符颜色
# export COLOR_NORMAL=white    # 普通文本颜色
# export COLOR_ERROR=red       # 错误消息颜色

# ==================== 自动补全增强 ====================
# zsh-autosuggestions 插件配置
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5f5f5f"

# ==================== 自定义函数 ====================

# mkcd - 创建目录并立即进入
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# extract - 智能解压各种压缩文件
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' 无法解压，格式不支持" ;;
    esac
  else
    echo "'$1' 不是有效文件"
  fi
}

# fcd - 使用 fzf 模糊查找并进入目录
fcd() {
  local dir
  dir=$(fd --type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fvim - 使用 fzf 模糊查找并编辑文件
fvim() {
  local file
  file=$(fd --type f 2> /dev/null | fzf +m) && nvim "$file"
}

# ==================== 环境变量 ====================
# 确保 Nix 配置文件路径在 PATH 中
export PATH="$HOME/.nix-profile/bin:$PATH"

# Anthropic Claude API 配置
export ANTHROPIC_BASE_URL="https://www.88code.org/api"
export ANTHROPIC_AUTH_TOKEN="88_12d9277bbd33440e432294d1f80b11bced198002f85ddee298baeb89d7d69dff"

# OpenAI API 配置
export OPENAI_BASE_URL="https://www.88code.org/openai/v1"
export OPENAI_API_KEY="88_12d9277bbd33440e432294d1f80b11bced198002f85ddee298baeb89d7d69dff"

# FZF 配置
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --inline-info
  --preview "bat --style=numbers --color=always --line-range :500 {}"
  --preview-window=right:60%:wrap
  --color=fg:#c0caf5,bg:#1a1b26,hl:#7aa2f7
  --color=fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a
'

# 使用 fd 而不是 find 作为 fzf 的默认命令
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ==================== 按键绑定 ====================
# 历史记录搜索（使用上下箭头）
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Vim 模式下的历史搜索
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# ==================== 命令别名 ====================
# 快速查看文件（使用 bat）
alias preview="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# 快速查找文件内容
alias rg="rg --smart-case --hidden --follow"

# 快速网络测试
alias ping="ping -c 5"
alias myip="curl -s https://api.ipify.org && echo"

# Git 增强别名
alias gst="git status"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gaa="git add --all"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gpl="git pull"
alias gps="git push"
alias gpsf="git push --force-with-lease"
