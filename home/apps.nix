{ pkgs, ... }:

{
  # 图形应用
  home.packages = with pkgs; [
    # 浏览器与媒体
    firefox # 流行的网页浏览器
    google-chrome
    vlc
    qbittorrent

    # 文件管理
    kdePackages.dolphin # KDE 的文件管理器 Dolphin
    kdePackages.dolphin-plugins # Dolphin 文件管理器插件（如集成网络共享等）
    nautilus # GNOME Files 文件管理器
    localsend # 本地文件传输工具，通常用于在设备之间传输文件

    # 通讯应用
    feishu
    qq # 腾讯 QQ，聊天工具
    wechat # 官方 Linux 版；UOS 旧包下载地址已失效
    wemeet

    # 开发工具
    vscode
  ];
}
