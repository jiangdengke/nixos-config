#!/usr/bin/env bash
set -euo pipefail

DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$DIR"
tmp="$(mktemp --suffix=.png)"

# 1) 框选并截到临时文件
geom="$(slurp -d)" || exit 0
grim -g "$geom" "$tmp"

# 2) 出菜单（优先 wofi，其次 rofi，最后 fzf）
choose() {
  if command -v wofi >/dev/null; then
    printf '%s\n' 标注 复制 保存 贴图 | wofi --dmenu -p '截图操作'
  elif command -v rofi >/dev/null; then
    printf '%s\n' 标注 复制 保存 贴图 | rofi -dmenu -p '截图操作'
  else
    printf '%s\n' 标注 复制 保存 贴图 | fzf --prompt='截图操作> '
  fi
}

act="$(choose || true)"
case "$act" in
  标注) swappy -f "$tmp" || true ;;
  复制) wl-copy < "$tmp"; notify-send "截图" "已复制到剪贴板" || true ;;
  保存)
    out="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
    mv "$tmp" "$out"
    notify-send "截图" "已保存到 $out" || true
    tmp=""
    ;;
  贴图)
    # 用 imv 打开；Hyprland 规则会让它浮动并 pin（悬浮贴图）
    imv "$tmp" >/dev/null 2>&1 &
    ;;
  *) wl-copy < "$tmp" ;; # 没选就默认复制
esac

# 清理
[ -n "${tmp:-}" ] && [ -f "$tmp" ] && rm -f -- "$tmp"

