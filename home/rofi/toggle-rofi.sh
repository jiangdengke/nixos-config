#!/usr/bin/env bash

# 脚本功能: 切换 Rofi 的显示状态
# 如果 Rofi 正在运行，则关闭它
# 如果 Rofi 没有运行，则打开它

# 检查 Rofi 是否正在运行
if pgrep -x "rofi" > /dev/null; then
    # 如果正在运行，则关闭
    pkill -x rofi
else
    # 如果没有运行，则打开
    # 使用指定的主题和配置
    rofi -show drun -theme ~/.config/rofi/themes/custom.rasi -kb-cancel 'Super+d'
fi
