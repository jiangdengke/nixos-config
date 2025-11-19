# ==================== ZSH 额外配置文件 ====================
# 这个文件包含 ZSH 的额外选项、函数和环境变量
# 文件位置：~/.config/home-manager/home/zsh/zshrc.zsh

# ==================== ZSH 选项设置 ====================
# ZSH 提供了大量选项来自定义 shell 行为

# 自动切换目录（无需输入 cd 命令）
# 例如：直接输入 /etc 就会进入 /etc 目录
setopt AUTO_CD

# 扩展历史记录格式
# 保存命令的时间戳和执行时间
setopt EXTENDED_HISTORY

# 历史记录去重（删除旧的重复项）
# 优先删除最早的重复命令
setopt HIST_EXPIRE_DUPS_FIRST

# 搜索历史时不显示重复项
# 使用 Ctrl+R 搜索时更清晰
setopt HIST_FIND_NO_DUPS

# 不记录重复的命令
# 连续执行相同命令只记录一次
setopt HIST_IGNORE_DUPS

# 不记录以空格开头的命令
# 用于执行不想保存到历史的敏感命令
setopt HIST_IGNORE_SPACE

# 多个 ZSH 会话共享历史记录
# 所有终端窗口的命令历史实时同步
setopt SHARE_HISTORY

# ==================== 自动补全增强 ====================
# zsh-autosuggestions 插件配置

# 补全策略：优先使用历史记录，其次使用命令补全
# 输入命令时会显示灰色的建议
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# 自动建议的颜色（深灰色）
# 可以根据个人喜好调整
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5f5f5f"

# 接受建议的快捷键：
# - 右箭头：接受整个建议
# - Ctrl+F：接受整个建议
# - Alt+F：接受一个单词

# ==================== Powerlevel10k 主题加载 ====================
# 加载 Powerlevel10k 主题
# @p10kTheme@ 会在构建时被替换为实际路径
source @p10kTheme@

# 加载个人的 Powerlevel10k 配置
# 如果存在 ~/.p10k.zsh 文件则加载
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ==================== 自定义函数 ====================
# 这里定义一些有用的 shell 函数

# mkcd - 创建目录并立即进入
# 用法：mkcd myproject
# 功能：等同于 mkdir -p myproject && cd myproject
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# extract - 智能解压各种压缩文件
# 用法：extract file.tar.gz
# 支持格式：tar.gz, tar.bz2, zip, rar, 7z 等
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
# 需要安装 fzf 和 fd
# 用法：fcd（然后输入目录名的部分字符）
fcd() {
  local dir
  dir=$(fd --type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fvim - 使用 fzf 模糊查找并编辑文件
# 需要安装 fzf 和 fd
# 用法：fvim（然后输入文件名的部分字符）
fvim() {
  local file
  file=$(fd --type f 2> /dev/null | fzf +m) && nvim "$file"
}

# ==================== 环境变量 ====================
# 设置各种环境变量

# 确保 Nix 配置文件路径在 PATH 中
export PATH="$HOME/.nix-profile/bin:$PATH"

# Anthropic Claude API 配置
# 用于 Claude 相关工具
export ANTHROPIC_BASE_URL="https://www.88code.org/api"
export ANTHROPIC_AUTH_TOKEN="88_12d9277bbd33440e432294d1f80b11bced198002f85ddee298baeb89d7d69dff"

# OpenAI API 配置
# 用于 GPT 相关工具
export OPENAI_BASE_URL="https://www.88code.org/openai/v1"
export OPENAI_API_KEY="88_12d9277bbd33440e432294d1f80b11bced198002f85ddee298baeb89d7d69dff"

# FZF 配置
# 设置 fzf 的默认选项
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
# fd 更快且默认忽略 .git 等目录
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ==================== 按键绑定 ====================
# 自定义键盘快捷键

# 历史记录搜索
# 使用上下箭头搜索历史（基于当前输入的前缀）
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Vim 模式下的历史搜索
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# ==================== 命令别名 ====================
# 额外的实用别名（补充 default.nix 中的定义）

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

# ==================== 加载完成提示 ====================
# 可选：显示加载成功的消息
# echo "✓ ZSH 配置加载完成"
