#!/usr/bin/env bash

# 日志记录
LOG_FILE="$HOME/rofi-launch.log"

# 若 rofi 已运行，则关闭它以实现切换效果。
if pgrep -x rofi >/dev/null || pgrep -x rofi-wayland >/dev/null; then
  echo "$(date '+%Y-%m-%d %H:%M:%S'): Closing existing Rofi instance" >> "$LOG_FILE"
  pkill -x rofi 2>/dev/null
  pkill -x rofi-wayland 2>/dev/null
  exit 0
fi

echo "$(date '+%Y-%m-%d %H:%M:%S'): Launching Rofi" >> "$LOG_FILE"

# 主题路径
THEME_PATH="$HOME/.config/rofi/themes/custom.rasi"


# 启动 Rofi
if [ -f "$THEME_PATH" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S'): Using custom theme" >> "$LOG_FILE"
  rofi -show drun -theme "$THEME_PATH" -kb-cancel 'Super+d'
else
  echo "$(date '+%Y-%m-%d %H:%M:%S'): Theme not found, using default" >> "$LOG_FILE"
  rofi -show drun -kb-cancel 'Super+d'
fi

