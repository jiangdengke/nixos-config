{ pkgs, ... }:
{
  home.packages = [ pkgs.cliphist ];

  home.file.".local/bin/cliphist-rofi.sh" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      selection="$(cliphist list | rofi -dmenu -i -p '剪贴板历史' || true)"
      [ -z "$selection" ] && exit 0

      if printf '%s' "$selection" | grep -q "^\[img\]"; then
        cliphist decode "$selection" | wl-copy --type image/png
      else
        cliphist decode "$selection" | wl-copy
      fi
    '';
    executable = true;
  };

  systemd.user.services = {
    "cliphist-store-text" = {
      Unit = {
        Description = "Cliphist clipboard history (text)";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = ''${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store'';
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    "cliphist-store-image" = {
      Unit = {
        Description = "Cliphist clipboard history (image)";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = ''${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store'';
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
