{ config, pkgs, lib, ... }:

{

  # 启用Home Manager的CopyQ服务
  services.copyq = {
    enable = true;                          # 启用CopyQ服务
    # forceXWayland = false;                # 如果你使用Wayland并希望强制使用XWayland，可以取消注释此行
    package = pkgs.copyq;                   # 使用默认的CopyQ包
    systemdTarget = "graphical-session.target"; # CopyQ自动启动的systemd目标
  };
}
