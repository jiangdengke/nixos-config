{ config, lib, pkgs, ... }:

{
  # X服务器配置
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
  };
  
  # 显示管理器
  services.displayManager.gdm.enable = true;
  
  # i3lock程序
  programs.i3lock.enable = true;
  
  # 终端提示符
  programs.starship.enable = true;
  
  # zsh配置
  programs.zsh.enable = true;
}
