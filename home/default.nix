{ config, pkgs, lib, ... }:

# Home Manager 入口，整合用户态程序与主题配置
{
  # 导入所有子模块
  imports = [
    ./dev
    ./gtk
    ./niri
    ./fcitx5 # 中文输入法配置
    ./programs
    ./zsh
    ./fastfetch
    ./ghostty
    ./noctalia
    ./yazi
    ./nvim
  ];

  # 用户基本信息
  home.username = "jdk";
  home.homeDirectory = "/home/jdk";

  # 启用 home-manager
  programs.home-manager.enable = true;
  xdg.configFile."gtk-4.0/gtk.css" = {
    source = pkgs.writeText "gtk-4.0-gtk.css" "";
    force = true;
  };
  xdg.configFile."gtk-4.0/settings.ini" = {
    source = pkgs.writeText "gtk-4.0-settings.ini" "";
    force = true;
  };

  # 基础环境变量
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "zh_CN.UTF-8";
    LC_CTYPE = "zh_CN.UTF-8";
    PATH = "$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin";
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_WAYLAND = "1";
  };

  # 不要修改此项，除非您知道自己在做什么
  home.stateVersion = "25.05";
}
