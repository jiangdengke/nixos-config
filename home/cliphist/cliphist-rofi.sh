#!/usr/bin/env bash
set -euo pipefail

# 若剪贴板历史已打开，再按一次快捷键将其关闭
if pgrep -f "rofi -dmenu -i -p 剪贴板历史" >/dev/null; then
  pkill -f "rofi -dmenu -i -p 剪贴板历史"
  exit 0
fi

selection="$(@cliphist@ list | rofi -dmenu -i -p '剪贴板历史' || true)"
[ -z "$selection" ] && exit 0

if printf '%s' "$selection" | grep -q '^\[img\]'; then
  @cliphist@ decode "$selection" | @wl_copy@ --type image/png
else
  @cliphist@ decode "$selection" | @wl_copy@
fi
