#!/usr/bin/env bash
set -euo pipefail
STEP_RAW="${STEP:-5}"
STEP_NUM="${STEP_RAW%%%}"
STEP_PERCENT="${STEP_NUM}%"

op=""
if [ "${1:-}" = "-o" ]; then op="${2:-}"; else op="${1:-}"; fi
case "$op" in
  i|up)    ACT=inc ;;
  d|down)  ACT=dec ;;
  m|mute)  ACT=toggle ;;
  *) echo "usage: $0 [-o i|d|m] | [up|down|mute]" >&2; exit 1 ;;
esac

if command -v pamixer >/dev/null 2>&1; then
  case "$ACT" in
    inc) pamixer --increase "$STEP_NUM" ;;
    dec) pamixer --decrease "$STEP_NUM" ;;
    toggle) pamixer -t ;;
  esac
elif command -v wpctl >/dev/null 2>&1; then
  SINK="@DEFAULT_AUDIO_SINK@"
  case "$ACT" in
    inc) wpctl set-volume "$SINK" "${STEP_PERCENT}+" ;;
    dec) wpctl set-volume "$SINK" "${STEP_PERCENT}-" ;;
    toggle) wpctl set-mute "$SINK" toggle ;;
  esac
elif command -v pactl >/dev/null 2>&1; then
  SINK="@DEFAULT_SINK@"
  case "$ACT" in
    inc) pactl set-sink-volume "$SINK" +"$STEP_PERCENT" ;;
    dec) pactl set-sink-volume "$SINK" -"$STEP_PERCENT" ;;
    toggle) pactl set-sink-mute "$SINK" toggle ;;
  esac
else
  echo "volumecontrol.sh: missing pamixer, wpctl, or pactl" >&2
  exit 1
fi
