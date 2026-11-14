{ pkgs, ... }:

{
  # 系统级工具；图形应用在 home/apps.nix
  environment.systemPackages = with pkgs; [
    # 基础工具
    wget # 命令行下载工具
    git # Git 版本控制工具
    wl-clipboard
    niri
    waybar

    pamixer
    alsa-utils
    libva-utils

    # 网络工具
    networkmanager # 网络管理工具，管理有线、无线网络
    networkmanagerapplet # 网络管理小程序，通常与图形界面一起使用，显示网络状态
    iw # 无线网络工具，用于管理无线网络设备
    wpa_supplicant # WPA 无线网络认证工具，用于连接到加密的 Wi-Fi 网络

    # 格式化工具
    stylua # Lua 代码格式化工具
    nixfmt-rfc-style # Nix 语言的官方格式化器，自动格式化 Nix 配置文件
    prettier # JavaScript、CSS、HTML、JSON、YAML 和 Markdown 格式化工具
    taplo # TOML 文件格式化工具
  ];
}
