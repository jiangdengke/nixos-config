{ config, pkgs, ... }:
{

  home.packages = [
    pkgs.brightnessctl
    pkgs.pavucontrol # PipeWire/Wayland 原生，小而全
    pkgs.blueman
  ];
  xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."waybar/colors-waybar.css".source = ./waybar/colors-waybar.css;
  xdg.configFile."waybar/theme.css".source = ./waybar/theme.css;

  xdg.configFile."waybar/scripts/bluetooth-menu.sh" = {
    source = ./waybar/scripts/bluetooth-menu.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/brightness.sh" = {
    source = ./waybar/scripts/brightness.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/mako-status.sh" = {
    source = ./waybar/scripts/mako-status.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/volumecontrol.sh" = {
    source = ./waybar/scripts/volumecontrol.sh;
    executable = true;
  };
  xdg.configFile."waybar/scripts/swaync-waybar.py" = {
    text = ''
      #!/usr/bin/env python3
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
    '';
    executable = true;
  };
  # 建议：有个图形 polkit 代理，配对/授权更顺滑
  systemd.user.services.polkit-gnome-agent = {
    Unit = {
      Description = "polkit agent";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service.ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

}
