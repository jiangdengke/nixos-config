# home/modules/gtk.nix
{ pkgs, lib, ... }:

{
  # 主题包和工具
  home.packages = with pkgs; [
    nwg-look
    catppuccin-gtk
    papirus-icon-theme
    bibata-cursors
    hicolor-icon-theme
  ];

  # GTK 外观配置
  gtk = {
    enable = true;

    # 窗口主题 - Catppuccin Mocha (深色柔和风格)
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        variant = "mocha";
      };
      name = "Catppuccin-Mocha-Standard-Teal-Dark";
    };

    # 图标主题 - Papirus 深色
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    # 光标主题 - Bibata 现代风格
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # 字体
    font = {
      package = pkgs.nerd-fonts.meslo-lg;
      name = "MesloLGL Nerd Font 11";
    };

    # GTK3 额外配置
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = true;
      gtk-menu-images = true;
      gtk-enable-animations = true;
      gtk-primary-button-warps-slider = false;
    };

    # GTK4 额外配置
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-hint-font-metrics = true;
    };
  };

  # Qt 应用的外观
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  # 光标主题环境变量
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # GTK4 自定义样式
  xdg.configFile."gtk-4.0/gtk.css" = {
    force = true;
    text = ''
      /* 圆角窗口 */
      window {
        border-radius: 12px;
      }

      /* 按钮圆角 */
      button {
        border-radius: 8px;
      }

      /* 输入框圆角 */
      entry {
        border-radius: 8px;
      }

      /* 滚动条美化 */
      scrollbar {
        border-radius: 8px;
      }
    '';
  };

  xdg.configFile."gtk-4.0/settings.ini".force = true;
  xdg.configFile."gtk-3.0/settings.ini".force = true;
}
