# 此文件包含 powerlevel10k 的配置
# 可以通过运行 p10k configure 命令生成
# 这里是一个基本配置，您可以根据自己的偏好进行修改

# 主提示符元素
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  # OS 图标
  os_icon
  # 当前目录
  dir
  # vcs 信息 (git 等)
  vcs
  # 命令执行状态
  status
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # 命令执行时间
  command_execution_time
  # 后台任务
  background_jobs
  # 时间
  time
)

# 基本设置
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{blue}❯%f '

# 目录显示设置
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"

# 你可以通过运行 'p10k configure' 生成更详细的配置
