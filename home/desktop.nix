# 图形会话组件；系统服务和驱动由 modules/ 与 hosts/ 管理。
{
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
