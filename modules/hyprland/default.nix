{ config, pkgs, ... }:

{
programs.xwayland.enable = true;
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.target = "graphical-session.target";
  };
}
