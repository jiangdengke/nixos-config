{ config, pkgs, ... }:
let
  wp = "${config.home.homeDirectory}/Pictures/Wallpapers/timg.jpg";
in {
  # 1) 启用 swww 的 HM 模块（仅起 daemon）
  services.swww = {
    enable = true;
    package = pkgs.swww;  # 不写也行，默认就是 pkgs.swww
  };

  # 2) 如果你用 Home Manager 管理 Hyprland，把设壁纸放到 exec-once
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        # 稍等半秒，确保 compositor 就绪，再切壁纸（有些机器不等也行）
        "${pkgs.bash}/bin/bash -lc 'sleep 0.5; ${pkgs.swww}/bin/swww img ${wp} --transition-type any --transition-duration 1 --transition-fps 60'"
      ];
    };
  };
}

