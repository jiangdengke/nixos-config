{ config, pkgs, lib, ... }:

{
  # 必需工具
  home.packages = with pkgs; [
    grim slurp  swappy
    imv           # 悬浮贴图窗口
#    wofi          # 或用 rofi-wayland，自行二选一
    libnotify     # notify-send
  ];

  # 把同级脚本下发到目标路径并赋可执行
  home.file.".config/hypr/shot-menu.sh" = {
    source = ./shot-menu.sh;
    executable = true;
  };

}

