{ config, pkgs, ... }:

# 启用 Niri Wayland 合成器，并设置系统提供的默认包
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.xwayland.enable = true; # 为 XWayland 应用保留兼容性

  security.pam.services.swaylock = {};
}
