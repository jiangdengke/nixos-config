#!/usr/bin/env bash
set -euo pipefail

dir="$1"

if [[ ! -d "$dir" ]]; then
  exit 0
fi

ensure_wayland_display() {
  if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
    return 0
  fi

  if [[ -z "${XDG_RUNTIME_DIR:-}" ]]; then
    return 1
  fi

  for socket in "$XDG_RUNTIME_DIR"/wayland-*; do
    if [[ -S "$socket" ]]; then
      export WAYLAND_DISPLAY="${socket##*/}"
      return 0
    fi
  done

  return 1
}

if ! ensure_wayland_display; then
  for _ in {1..30}; do
    sleep 1
    ensure_wayland_display && break
  done
fi

if [[ -z "${WAYLAND_DISPLAY:-}" ]]; then
  exit 0
fi

mapfile -t files < <(find "$dir" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' -o -iname '*.bmp' \) | sort)

if [[ ${#files[@]} -eq 0 ]]; then
  exit 0
fi

img="${files[$((RANDOM % ${#files[@]}))]}"

pkill -x swaybg 2>/dev/null || true

nohup swaybg -m fill -i "$img" >/dev/null 2>&1 &
