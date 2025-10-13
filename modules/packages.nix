{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # 基础工具
    wget # 命令行下载工具
    git # Git 版本控制工具
    wl-clipboard
    niri
    waybar

    pamixer
    alsa-utils
    # 桌面环境
    firefox # 流行的网页浏览器
    vlc
    qbittorrent

    kdePackages.dolphin # KDE 的文件管理器 Dolphin
    kdePackages.dolphin-plugins # Dolphin 文件管理器插件（如集成网络共享等）
    nautilus  #GNOME Files 文件管理器
    libva-utils

    # 网络工具
    networkmanager # 网络管理工具，管理有线、无线网络
    networkmanagerapplet # 网络管理小程序，通常与图形界面一起使用，显示网络状态
    iw # 无线网络工具，用于管理无线网络设备
    wpa_supplicant # WPA 无线网络认证工具，用于连接到加密的 Wi-Fi 网络
    localsend # 本地文件传输工具，通常用于在设备之间传输文件

    # 格式化工具
    stylua # Lua 代码格式化工具
    nixfmt-rfc-style # Nix 语言的官方格式化器，自动格式化 Nix 配置文件
    nodePackages.prettier # JavaScript、CSS、HTML、JSON、YAML 和 Markdown 格式化工具
    taplo # TOML 文件格式化工具
    google-chrome

    # 通讯应用
    qq # 腾讯 QQ，聊天工具
    wechat-uos
    wemeet
  ];
}
