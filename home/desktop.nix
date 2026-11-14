# 图形会话组件；系统服务和驱动由 modules/ 与 hosts/ 管理。
{ pkgs, ... }:

{
  # 与 Niri 中的锁屏、媒体键和辅助功能快捷键对应。
  programs.swaylock.enable = true;
  home.packages = with pkgs; [ playerctl orca ];

  imports = [
    ./apps.nix
    ./gtk
    ./niri
    ./polkit.nix
    ./waybar
    ./fcitx5
    ./swaync
    ./xwayland-satellite
    ./kitty
    ./rofi
  ];
}
