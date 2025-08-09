#!/usr/bin/env bash
set -euo pipefail

# 保存目录 & 贴图缓存目录
DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/shot-pins"
mkdir -p "$DIR" "$CACHE_DIR"

# 临时文件 + 统一清理
tmp="$(mktemp --suffix=.png)"
cleanup() { [[ -n "${tmp:-}" && -f "$tmp" ]] && rm -f -- "$tmp"; }
trap cleanup EXIT

# 1) 框选并截到临时文件
geom="$(slurp -d)" || exit 0
grim -g "$geom" "$tmp"

# 2) 菜单（优先 wofi，其次 rofi，最后 fzf）
choose() {
  if command -v wofi >/dev/null 2>&1; then
    printf '%s\n' 标注 复制 保存 贴图 | wofi --dmenu -p '截图操作'
  elif command -v rofi >/dev/null 2>&1; then
    printf '%s\n' 标注 复制 保存 贴图 | rofi -dmenu -p '截图操作'
  else
    printf '%s\n' 标注 复制 保存 贴图 | fzf --prompt='截图操作> '
  fi
}

act="$(choose || true)"
case "$act" in
  标注)
    swappy -f "$tmp" || true
    ;;
  复制|"")  # 默认：复制
    wl-copy < "$tmp"
    command -v notify-send >/dev/null 2>&1 && notify-send "截图" "已复制到剪贴板"
    ;;
  保存)
    out="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
    mv "$tmp" "$out"
    tmp=""  # 阻止统一清理删掉已保存文件
    command -v notify-send >/dev/null 2>&1 && notify-send "截图" "已保存到 $out"
    ;;
  贴图)
    # 持久化后再打开，避免被清理删掉导致黑框
    f="$CACHE_DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
    mv "$tmp" "$f"
    tmp=""
    imv "$f" >/dev/null 2>&1 &
    ;;
  *)
    wl-copy < "$tmp"
    ;;
esac

