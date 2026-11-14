#!@python3@
import json
import subprocess
import sys

TRUE_WORDS = {"true", "1", "yes", "on", "enabled"}
FALSE_WORDS = {"false", "0", "no", "off", "disabled"}

def normalise_bool(value):
    if isinstance(value, bool):
        return value
    if isinstance(value, str):
        lowered = value.strip().lower()
        if lowered in TRUE_WORDS:
            return True
        if lowered in FALSE_WORDS or lowered == "":
            return False
        return False
    if isinstance(value, (int, float)):
        return value != 0
    if value is None:
        return False
    return bool(value)

def ensure_state(payload):
    state = payload.get("state")
    if isinstance(state, str) and state:
        return state

    classes = payload.get("class")
    if isinstance(classes, list) and classes:
        payload["state"] = classes[0]
    elif isinstance(classes, str) and classes:
        payload["state"] = classes
    else:
        payload["state"] = "none"
    return payload["state"]

def ensure_icon(payload):
    if payload.get("icon"):
        return
    state = ensure_state(payload)
    icon_map = {
        "notification": "",
        "dnd-notification": "󰒳",
        "dnd-none": "󰒳",
        "none": "󰂚",
    }
    payload["icon"] = icon_map.get(state, "󰂚")

def emit(payload):
    print(json.dumps(payload), flush=True)

def main():
    try:
        proc = subprocess.Popen([
            "swaync-client",
            "-swb",
        ], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    except FileNotFoundError:
        payload = {
            "text": "",
            "tooltip": "",
            "class": ["none"],
        }
        ensure_state(payload)
        ensure_icon(payload)
        payload["swap-icon-label"] = False
        emit(payload)
        return

    # 初始空状态
    initial = {
        "text": "",
        "tooltip": "",
        "class": ["none"],
    }
    ensure_state(initial)
    ensure_icon(initial)
    initial["swap-icon-label"] = False
    emit(initial)

    for raw_line in proc.stdout:
        line = raw_line.strip()
        if not line:
            continue
        try:
            payload = json.loads(line)
        except json.JSONDecodeError:
            print(line, file=sys.stderr, flush=True)
            continue

        payload["swap-icon-label"] = normalise_bool(payload.get("swap-icon-label"))
        ensure_state(payload)
        ensure_icon(payload)

        emit(payload)

    proc.stdout.close()
    proc.wait()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(0)
