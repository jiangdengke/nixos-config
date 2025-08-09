#!/usr/bin/env bash
set -euo pipefail

# ---- 简单的 UI 选择器：优先 rofi，其次 wofi，最后 fzf ----
pick() {
  if command -v rofi >/dev/null 2>&1; then
    rofi -dmenu -i -p "${2:-Bluetooth}"
  elif command -v wofi >/dev/null 2>&1; then
    wofi --dmenu -p "${2:-Bluetooth}"
  else
    fzf --prompt="${2:-Bluetooth}> "
  fi
}

# ---- 小工具函数 ----
notify() { command -v notify-send >/dev/null 2>&1 && notify-send "$@"; }
powered() { bluetoothctl show | awk '/Powered:/ {print $2; exit}'; }
connected_p() { bluetoothctl info "$1" 2>/dev/null | awk '/Connected:/ {print $2; exit}'; }

# 读取配对设备（MAC \t 名称 \t [connected]）
list_paired() {
  bluetoothctl devices | while read -r _ mac; do
    [ -z "${mac:-}" ] && continue
    name="$(bluetoothctl info "$mac" 2>/dev/null | awk -F': ' '/Name:/{print $2; exit}')"
    [ -z "$name" ] && name="$mac"
    if [ "$(connected_p "$mac")" = "yes" ]; then
      printf "%s\t%s\t[connected]\n" "$mac" "$name"
    else
      printf "%s\t%s\n" "$mac" "$name"
    fi
  done
}

# 扫描 N 秒，返回“MAC\tName”列表
scan_devices() {
  timeout="${1:-12}"
  # bluetoothctl 的输出会包含很多行，这里仅抓 Device 行
  mapfile -t found < <(bluetoothctl --timeout "$timeout" scan on | awk '/^Device /{mac=$2; $1=$2=""; name=substr($0,3); print mac "\t" name}' | sort -u)
  printf "%s\n" "${found[@]}" | sed '/^[[:space:]]*$/d'
}

# ---- 主逻辑：菜单 ----
main_menu() {
  if [ "$(powered)" != "yes" ]; then
    choice="$(printf '%s\n' 'Enable Bluetooth' | pick - 'Bluetooth')"
    [ -z "${choice:-}" ] && exit 0
    if [ "$choice" = "Enable Bluetooth" ]; then
      bluetoothctl power on >/dev/null 2>&1 || true
      notify "Bluetooth" "Enabled"
    fi
    exit 0
  fi

  # 已配对设备列表（加上两个操作项）
  paired="$(list_paired)"
  menu="$(printf '%s\n%s\n%s\n' \
      'Scan & Pair…' \
      'Disable Bluetooth' \
      "$paired" \
    )"

  # 展示（对齐可用 column，有则更美观）
  if command -v column >/dev/null 2>&1; then
    shown="$(echo -e "$menu" | column -t -s $'\t')"
  else
    shown="$menu"
  fi

  choice="$(echo -e "$shown" | pick - 'Bluetooth')"
  [ -z "${choice:-}" ] && exit 0

  case "$choice" in
    "Disable Bluetooth")
      bluetoothctl power off >/dev/null 2>&1 || true
      notify "Bluetooth" "Disabled"
      exit 0
      ;;
    "Scan & Pair…")
      do_scan_pair
      exit 0
      ;;
    *)
      # 从选择行中还原 MAC（如果用了 column 对齐，也能取到第一个“字段”）
      mac="$(echo "$choice" | awk '{print $1}')"
      # 简单校验 MAC 格式
      if [[ ! "$mac" =~ ^([0-9A-F]{2}:){5}[0-9A-F]{2}$ ]]; then
        # 如果 column 把 MAC 推后了（极少见），再从未对齐的列表里匹配一遍名称取回 MAC
        name="$(echo "$choice" | sed 's/.*\t//; s/ \[connected\]$//')"
        mac="$(printf '%s\n' "$paired" | awk -v n="$name" -F'\t' '$2==n{print $1; exit}')"
      fi
      [ -z "$mac" ] && exit 0

      if [ "$(connected_p "$mac")" = "yes" ]; then
        bluetoothctl disconnect "$mac" >/dev/null 2>&1 || true
        notify "Bluetooth" "Disconnected: $mac"
      else
        # 确保 agent 在（处理 PIN/确认）
        bluetoothctl agent on >/dev/null 2>&1 || true
        bluetoothctl default-agent >/dev/null 2>&1 || true
        bluetoothctl trust "$mac"  >/dev/null 2>&1 || true
        bluetoothctl pair  "$mac"  >/dev/null 2>&1 || true
        bluetoothctl connect "$mac" >/dev/null 2>&1 || true
        # 简短等待再提示
        sleep 2
        if [ "$(connected_p "$mac")" = "yes" ]; then
          name="$(bluetoothctl info "$mac" | awk -F': ' '/Name:/{print $2; exit}')"
          notify "Bluetooth" "Connected: ${name:-$mac}"
        else
          notify "Bluetooth" "Failed to connect: $mac"
        fi
      fi
      ;;
  esac
}

do_scan_pair() {
  notify "Bluetooth" "Scanning…"
  mapfile -t devs < <(scan_devices 12)
  # 过滤掉已经配对过的
  mapfile -t paired_macs < <(printf '%s\n' "$paired" | awk -F'\t' '{print $1}')
  show_list=()
  for line in "${devs[@]}"; do
    mac="${line%%$'\t'*}"
    skip=0
    for pm in "${paired_macs[@]}"; do
      [ "$mac" = "$pm" ] && skip=1 && break
    done
    [ $skip -eq 0 ] && show_list+=("$line")
  done

  if [ "${#show_list[@]}" -eq 0 ]; then
    notify "Bluetooth" "No new devices"
    return
  fi

  # 展示可配对设备列表
  if command -v column >/dev/null 2>&1; then
    shown="$(printf '%s\n' "${show_list[@]}" | column -t -s $'\t')"
  else
    shown="$(printf '%s\n' "${show_list[@]}")"
  fi
  pickline="$(echo -e "$shown" | pick - 'Scan & Pair')"
  [ -z "${pickline:-}" ] && return

  mac="$(echo "$pickline" | awk '{print $1}')"
  bluetoothctl agent on >/dev/null 2>&1 || true
  bluetoothctl default-agent >/dev/null 2>&1 || true
  bluetoothctl trust "$mac"  >/dev/null 2>&1 || true
  bluetoothctl pair  "$mac"  >/dev/null 2>&1 || true
  bluetoothctl connect "$mac" >/dev/null 2>&1 || true
  sleep 2
  if [ "$(connected_p "$mac")" = "yes" ]; then
    name="$(bluetoothctl info "$mac" | awk -F': ' '/Name:/{print $2; exit}')"
    notify "Bluetooth" "Paired & connected: ${name:-$mac}"
  else
    notify "Bluetooth" "Pair/connect failed: $mac"
  fi
}

main_menu

