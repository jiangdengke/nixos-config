#!/bin/bash

# 检查 fcitx5 是否已经运行
if pgrep -x "fcitx5" > /dev/null; then
    # fcitx5 正在运行，重启它
    pkill -x fcitx5
    sleep 1
    fcitx5 -d
    notify-send "fcitx5" "输入法已重启"sh
else
    # fcitx5 未运行，启动它
    fcitx5 -d
    notify-send "fcitx5" "输入法已启动"
fi
