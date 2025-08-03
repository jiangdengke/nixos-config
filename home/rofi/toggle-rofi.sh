#!/usr/bin/env bash

# 主题路径
THEME_PATH="$HOME/.config/rofi/themes/custom.rasi"

if pgrep -x "rofi" > /dev/null; then
    # Rofi 正在运行，关闭它
    pkill -x rofi
else
    # Rofi 未运行，启动它并使用指定主题
    if [ -f "$THEME_PATH" ]; then
        rofi -show drun -theme "$THEME_PATH" -kb-cancel 'Super+d'
    else
        # 主题文件不存在，使用默认设置
        echo "警告：主题文件不存在，使用默认设置" >&2
        rofi -show drun -kb-cancel 'Super+d'
    fi
fi
