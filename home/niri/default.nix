# 管理 Niri 用户级配置，基于官方默认 config.kdl 新增必要定制
{ pkgs, config, lib, ... }:

let
  configPath = ./config.kdl;
  imagesSource = ./img;
  imageDir = "${config.home.homeDirectory}/.config/niri/img";
  swaylockImage = "${imageDir}/swaylock.png";
in {
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
  ];

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

}