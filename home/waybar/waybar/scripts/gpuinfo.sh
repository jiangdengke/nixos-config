#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

emit_json(){ jq -Rn --arg text "$1" --arg tooltip "$2" '{text:$text, tooltip:$tooltip}'; }
has(){ command -v "$1" >/dev/null 2>&1; }
emoji(){ local t=${1:-0}; [ "${t%.*}" -lt 60 ] && printf '❄️' || printf '🔥'; }

# ---------- NVIDIA ----------
nv_text=""; nv_tip=""
if has nvidia-smi && nvidia-smi -L >/dev/null 2>&1; then
  IFS=',' read -ra d < <(nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu,power.draw,power.max_limit --format=csv,noheader,nounits)
  nv_name="${d[0]}"
  nv_temp="${d[1]// /}"
  nv_util="${d[2]// /}"
  nv_pwr="${d[3]// /}"
  nv_pwrmax="${d[4]// /}"
  nv_text="NV ${nv_temp}°C"
  nv_tip=$(printf 'NVIDIA: %s\n%s Temp: %s°C\n󰾆 Util: %s%%\n Power: %s/%s W' "$nv_name" "$(emoji "$nv_temp")" "$nv_temp" "$nv_util" "$nv_pwr" "$nv_pwrmax")
fi

# ---------- AMD ----------
amd_text=""; amd_tip=""; amd_temp=""
# 从 sensors 抓 amdgpu 温度（edge/junction）
if has sensors; then
  amd_temp="$(sensors 2>/dev/null | awk '
    tolower($0) ~ /amdgpu/ {blk=1}
    blk && /edge:/     {gsub(/[^0-9.]/,"",$2); print int($2); exit}
    blk && /junction:/ {gsub(/[^0-9.]/,"",$2); print int($2); exit}
  ')"
fi

# 从内核接口抓 AMD 利用率（如果有）
amd_util=""
for d in /sys/class/drm/card*/device; do
  if [ -f "$d/vendor" ] && grep -qi '0x1002' "$d/vendor"; then
    if [ -r "$d/gpu_busy_percent" ]; then
      amd_util="$(cat "$d/gpu_busy_percent" 2>/dev/null || true)"
      break
    fi
  fi
done

if [ -n "${amd_temp:-}" ]; then
  amd_text="AMD ${amd_temp}°C"
  if [ -n "${amd_util:-}" ]; then
    amd_tip=$(printf 'AMD GPU\n%s Temp: %s°C\n󰾆 Util: %s%%' "$(emoji "$amd_temp")" "$amd_temp" "$amd_util")
  else
    amd_tip=$(printf 'AMD GPU\n%s Temp: %s°C' "$(emoji "$amd_temp")" "$amd_temp")
  fi
fi

# ---------- 输出 ----------
if [ -n "$nv_text$amd_text" ]; then
  text="$nv_text"; [ -n "$text" ] && [ -n "$amd_text" ] && text="$text | $amd_text" || text="${text:-$amd_text}"
  tip="$nv_tip";  [ -n "$tip" ]  && [ -n "$amd_tip" ]  && tip="$tip\n\n$amd_tip"     || tip="${tip:-$amd_tip}"
  emit_json "$text" "$tip"
else
  emit_json "N/A" "No GPU metrics"
fi

