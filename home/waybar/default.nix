{ pkgs, ... }:
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
    source = pkgs.replaceVars ./waybar/scripts/swaync-waybar.py {
      python3 = "${pkgs.python3}/bin/python3";
    };
    executable = true;
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
