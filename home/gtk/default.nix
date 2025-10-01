# 定义 GTK 与 Qt 主题相关的 Home Manager 配置
{ pkgs, lib, ... }:

{
  # 方便临时切换的 GUI 工具 + 常见主题包
  home.packages = with pkgs; [
    nwg-look                 # GTK 外观切换器
    gruvbox-kvantum
    adw-gtk3                 # GTK 主题示例
    papirus-icon-theme       # 图标主题示例
    bibata-cursors           # 光标主题示例
    hicolor-icon-theme       # 你原来就有，保留
  ];

  # GTK 外观（长期生效以 HM 为准；nwg-look 只做临时预览）
  gtk = {
    enable = true;

    # 窗口主题（你现在用 Adwaita 也行）
    theme = {
      package = pkgs.adw-gtk3;
      name    = "adw-gtk3-dark";
    };

    # 图标主题（你原本是 Adwaita；这里示例 Papirus）
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name    = "Papirus-Dark";
    };

    # 光标主题
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name    = "Bibata-Modern-Ice";
      size    = 24;
    };
  };

  # Qt 应用的外观（可用 qt6ct 调整）
  qt = {
    enable = true;
    platformTheme.name = "qtct";   # 让 qt6ct 生效
    style.name = "kvantum";   # 或 "Fusion"
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      # 让 xdg-desktop-portal-gnome 读取暗色偏好
      color-scheme = "prefer-dark";
    };
  };

  # Wayland 会话中让光标主题立即生效的环境变量
  home.sessionVariables = {
    XCURSOR_THEME   = "Bibata-Modern-Ice";
    XCURSOR_SIZE    = "24";
  };

  #（可选）避免 HM 激活时提示“会覆盖现有 GTK 配置文件”
  #home-manager.backupFileExtension = "backup";
}

