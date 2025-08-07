#!/usr/bin/env bash

# 日志记录
LOG_FILE="$HOME/rofi-launch.log"
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

