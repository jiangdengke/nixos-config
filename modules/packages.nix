{ config, lib, pkgs, ... }:

{
  # 系统软件包
  environment.systemPackages = with pkgs; [
    # 基础工具
    wget
    git
    xclip
    
    # 桌面环境
    firefox
    i3-gaps
    rofi
    variety
    picom
    lxappearance
    
    vlc
kdePackages.dolphin
kdePackages.dolphin-plugins
    # 网络工具
    networkmanager
    networkmanagerapplet
    iw
    wpa_supplicant
    localsend
    
    # 通讯应用
    qq
    wechat-uos
    # dev
jetbrains.idea-ultimate
    vscode
  ];
}
