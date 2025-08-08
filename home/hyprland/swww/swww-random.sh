#!/usr/bin/env bash
set -euo pipefail

WPDIR="${1:-$HOME/Pictures/Wallpapers}"
DURATION="${SWWW_DURATION:-1}"
FPS="${SWWW_FPS:-60}"
TRANSITION="${SWWW_TRANSITION:-any}"
PER_OUTPUT="${SWWW_PER_OUTPUT:-0}"

if ! command -v swww >/dev/null 2>&1; then
  echo "swww not found in PATH" >&2
  exit 1
fi

# 确保 daemon 在跑
if ! swww query >/dev/null 2>&1; then
  if command -v swww-daemon >/dev/null 2>&1; then
    nohup swww-daemon >/dev/null 2>&1 &
  else
    nohup swww init >/dev/null 2>&1 &
  fi
  sleep 0.3
fi

# 收集图片
mapfile -t FILES < <(find "$WPDIR" -type f \
  \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \))

if [ "${#FILES[@]}" -eq 0 ]; then
  echo "No images found in $WPDIR" >&2
  exit 1
fi

STATE="${XDG_CACHE_HOME:-$HOME/.cache}/swww-random.last"
mkdir -p "$(dirname "$STATE")"
prev=""
[ -f "$STATE" ] && prev="$(<"$STATE")"

pick_one() {
  local img
  for _ in {1..10}; do
    img="${FILES[RANDOM % ${#FILES[@]}]}"
    [[ "$img" != "$prev" ]] && { echo "$img"; return; }
  done
  echo "${FILES[RANDOM % ${#FILES[@]}]}"
}

if [[ "$PER_OUTPUT" = "1" ]]; then
  # 每个输出各自随机
  while read -r out; do
    img="$(pick_one)"
    swww img -o "$out" "$img" \
      --transition-type "$TRANSITION" --transition-duration "$DURATION" --transition-fps "$FPS"
  done < <(swww query | awk -F': ' '/Output/ {print $2}')
else
  # 所有屏同一张
  img="$(pick_one)"
  swww img "$img" \
    --transition-type "$TRANSITION" --transition-duration "$DURATION" --transition-fps "$FPS"
  printf "%s" "$img" > "$STATE"
fi

