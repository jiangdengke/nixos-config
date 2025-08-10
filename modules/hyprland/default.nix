{ config, pkgs, ... }:

{
programs.xwayland.enable = true;
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };
  programs.waybar = {
    enable = false;
    package = pkgs.waybar;
  };
}
