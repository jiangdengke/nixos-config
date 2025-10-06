#!/usr/bin/env bash
set -euo pipefail

state_dir="${XDG_RUNTIME_DIR:-/tmp}/cliphist"
mkdir -p "$state_dir"
lock_file="$state_dir/daemon.lock"

exec 9>"$lock_file"
if ! flock -n 9; then
  exit 0
fi

wl-paste --type text --watch cliphist store &
text_pid=$!
wl-paste --type image --watch cliphist store &
image_pid=$!

cleanup() {
  kill "$text_pid" "$image_pid" 2>/dev/null || true
}
trap cleanup EXIT

wait
#!/usr/bin/env bash
set -euo pipefail

state_dir="${XDG_RUNTIME_DIR:-/tmp}/cliphist"
mkdir -p "$state_dir"
lock_file="$state_dir/daemon.lock"

exec 9>"$lock_file"
if ! flock -n 9; then
  exit 0
fi

"@wl_paste@" --type text --watch "@cliphist@" store &
text_pid=$!
"@wl_paste@" --type image --watch "@cliphist@" store &
image_pid=$!

cleanup() {
  kill "$text_pid" "$image_pid" 2>/dev/null || true
}
trap cleanup EXIT

wait
