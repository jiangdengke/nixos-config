#!/usr/bin/env bash

# 添加日志记录
LOG_FILE="$HOME/rofi-toggle.log"
echo "$(date): 脚本开始执行" >> "$LOG_FILE"

# 主题路径
THEME_PATH="$HOME/.config/rofi/themes/custom.rasi"

if pgrep -x "rofi" > /dev/null; then
    # Rofi 正在运行，关闭它
    echo "$(date): 发现 Rofi 进程，尝试关闭" >> "$LOG_FILE"
    pkill -x rofi
else
    # Rofi 未运行，启动它并使用指定主题
    echo "$(date): 未发现 Rofi 进程，尝试启动" >> "$LOG_FILE"
    
    if [ -f "$THEME_PATH" ]; then
        echo "$(date): 主题文件存在，使用自定义主题" >> "$LOG_FILE"
        rofi -show drun -theme "$THEME_PATH" -kb-cancel 'Super+d'
    else
        # 主题文件不存在，使用默认设置
        echo "$(date): 主题文件不存在，使用默认设置" >> "$LOG_FILE"
        rofi -show drun -kb-cancel 'Super+d'
    fi
fi
