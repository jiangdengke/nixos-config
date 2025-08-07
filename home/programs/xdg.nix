{config, ...}: let
  browser = ["firefox.desktop"];
  fileManager = ["org.kde.dolphin.desktop"];  # Dolphin 的正确桌面文件名称

  # XDG MIME types
  associations = {
    # 浏览器相关的文件类型关联
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;

    # 多媒体文件类型关联 - 已修改为使用VLC和feh
    "audio/*" = ["vlc.desktop"];           # 所有音频文件使用VLC打开
    "video/*" = ["vlc.desktop"];           # 所有视频文件使用VLC打开
    "image/*" = ["feh.desktop"];           # 所有图片文件使用feh打开
       # 文件管理器关联 - Dolphin
    "inode/directory" = fileManager;       # 目录使用Dolphin打开
    "application/x-gnome-saved-search" = fileManager; 
    # 其他文件类型关联
    "application/json" = browser;
    "application/pdf" = ["org.pwmt.zathura.desktop.desktop"];
    "x-scheme-handler/discord" = ["discordcanary.desktop"];
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
  };
in {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
}
