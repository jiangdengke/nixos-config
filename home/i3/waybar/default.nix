{ config, pkgs, ... }:

{
  # 安装waybar包
  home.packages = with pkgs; [
    waybar
  ];

  # 复制waybar配置文件
  home.file.".config/waybar" = {
    source = ./waybar; # 相对于当前nix文件的路径
    recursive = true; # 递归复制整个目录
  };

  # 确保也安装了一些waybar可能依赖的包
  home.packages = with pkgs; [
    # 一些常用于waybar的工具
    font-awesome # 如果你的waybar配置使用了font-awesome图标
    playerctl # 用于媒体控制模块
    pavucontrol # 用于音量控制
    networkmanager_dmenu # 用于网络模块
  ];
}
