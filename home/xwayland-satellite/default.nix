{ pkgs, ... }:
{
  # Niri >= 25.08 自动设置 DISPLAY 并按需启动 satellite >= 0.7。
  # 只提供程序，不再启动第二个 systemd 服务争用 X11 socket。
  home.packages = [ pkgs.xwayland-satellite ];
}
