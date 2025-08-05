{
  config,
  lib,
  pkgs,
  ...
}:

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
    # 格式化工具
    stylua # Lua 格式化器
    nixfmt-rfc-style # 官方 Nix 格式化器
    nodePackages.prettier # JavaScript/CSS/HTML/JSON/YAML/Markdown 格式化器
    taplo # TOML 格式化器

    # 通讯应用
    qq
    wechat-uos
    # dev
    jetbrains.idea-ultimate
    cherry-studio
    vscode
  ];
}
