# 管理 Niri 用户级配置，基于官方默认 config.kdl 新增必要定制
{ pkgs, config, lib, ... }:

let
  configPath = ./config.kdl;
  imagesSource = ./img;
  imageDir = "${config.home.homeDirectory}/.config/niri/img";
  swaylockImage = "${imageDir}/swaylock.png";
  wallpaperPath = "${imageDir}/wallpaper.png";
  lockCommand = "${pkgs.swaylock}/bin/swaylock --image ${lib.escapeShellArg swaylockImage}";
in
{
  home.file.".config/niri/config.kdl" = {
    text = builtins.readFile configPath;
  };

  home.file.".config/niri/img" = {
    source = imagesSource;
    recursive = true;
  };

  home.file.".config/xdg-desktop-portal/niri-portals.conf" = {
    source = ./niri-portals.conf;
  };

  home.packages = with pkgs; [
    xwayland-satellite
    swaybg
  ];

  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font 11";
      "background-color" = "#1e1e2e";
      "text-color" = "#cdd6f4";
      "border-color" = "#89b4fa";
      "border-radius" = 8;
      width = 360;
      height = 140;
      margin = "12";
      padding = "12";
      "default-timeout" = 4000;
      icons = true;
      "max-visible" = 5;
      "ignore-timeout" = false;
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "1d2021";
      image = swaylockImage;
      scaling = "fill";
      daemonize = true;
      indicator = true;
      "indicator-radius" = 120;
      "indicator-thickness" = 14;
      "inside-wrong-color" = "ff6e6e";
      "ring-color" = "89b4fa";
      "ring-ver-color" = "89b4fa";
      "ring-wrong-color" = "f38ba8";
      "line-color" = "1d2021";
      grace = 2;
      "show-failed-attempts" = true;
    };
  };

  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "xwayland-satellite for Niri";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg background";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${lib.escapeShellArg wallpaperPath}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}