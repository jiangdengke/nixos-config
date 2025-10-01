{
  config,
  lib,
  pkgs,
  ...
}:

# 定义系统级常用软件包集合，供所有用户共享
{
  environment.systemPackages = with pkgs; [
    # 基础工具
    wget # 命令行下载工具
    git # Git 版本控制工具
    wl-clipboard
    # Niri 由单独模块启用，无需重复安装

    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring

    alsa-utils
    # 桌面环境
    firefox # 流行的网页浏览器
    google-chrome
    vlc
    qbittorrent
    nautilus

    # 网络工具
    networkmanagerapplet # 网络管理小程序，通常与图形界面一起使用，显示网络状态
    iw # 无线网络工具，用于管理无线网络设备
    localsend # 本地文件传输工具，通常用于在设备之间传输文件

    # 格式化工具
    stylua # Lua 代码格式化工具
    nixfmt-rfc-style # Nix 语言的官方格式化器，自动格式化 Nix 配置文件
    nodePackages.prettier # JavaScript、CSS、HTML、JSON、YAML 和 Markdown 格式化工具
    taplo # TOML 文件格式化工具
    alacritty

    # 通讯应用
    qq # 腾讯 QQ，聊天工具
    wechat-uos

    # 开发工具
    vscode # Visual Studio Code，轻量级代码编辑器
  ];

  security.chromiumSuidSandbox.enable = true;
}
