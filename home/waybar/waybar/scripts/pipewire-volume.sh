#!/usr/bin/env bash
set -euo pipefail

sink="@DEFAULT_AUDIO_SINK@"
info=$(wpctl get-volume "$sink" 2>/dev/null || true)

if [[ -z "$info" ]]; then
  echo '{"text":" --","tooltip":"未找到 PipeWire 输出设备","class":"muted"}'
  exit 0
fi

volume=$(awk '{print $2}' <<< "$info")
percent=$(awk -v v="$volume" 'BEGIN { printf "%d", v * 100 + 0.5 }')
muted=false

if grep -q "MUTED" <<< "$info"; then
  muted=true
fi

if $muted; then
  text=" muted"
  class="muted"
else
  if (( percent == 0 )); then
    icon=""
  elif (( percent < 50 )); then
    icon=""
  else
    icon=""
  fi
  text="$icon ${percent}%"
  class="normal"
fi

tooltip="音量：${percent}%"

printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$text" "$tooltip" "$class"
