#!/usr/bin/env bash

# 获取 mako 模式和通知数量
mode=$(makoctl mode)
count=$(makoctl list | jq -r '.data[0] | length')

# 如果没有通知，设为 0
if [ -z "$count" ] || [ "$count" == "null" ]; then
    count=0
fi

# 根据模式和通知数量决定图标状态
if [[ "$mode" == *"dnd"* ]]; then
    if [ "$count" -gt 0 ]; then
        class="dnd-notification"
    else
        class="dnd-none"
    fi
else
    if [ "$count" -gt 0 ]; then
        class="notification"
    else
        class="none"
    fi
fi

# 输出 JSON 格式
if [ "$count" -gt 0 ]; then
    text="$count"
else
    text=""
fi

printf '{"text":"%s","class":"%s"}\n' "$text" "$class"
