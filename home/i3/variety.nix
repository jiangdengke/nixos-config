{ config, pkgs, ... }:

{
  # 安装 Variety 壁纸管理器
  home.packages = with pkgs; [
    variety # 壁纸管理器

    # Variety 的一些依赖和增强工具
    imagemagick # 图片处理
    libnotify # 桌面通知
    python3Packages.pillow # Python 图像处理库
  ];

  # 自动启动 Variety
  xdg.configFile."autostart/variety.desktop".text = ''
    [Desktop Entry]
    Name=Variety
    Comment=Variety Wallpaper Changer
    Categories=GNOME;GTK;Utility;
    Exec=variety
    Icon=variety
    Terminal=false
    Type=Application
    StartupNotify=false
    Hidden=false
  '';

  # Variety 基本配置
  xdg.configFile."variety/variety.conf".text = ''
    # 更改壁纸间隔（单位：秒，300=5分钟）
    change_interval = 300

    # 壁纸切换顺序（0=顺序，1=随机）
    change_on_start = True
    random_mode = 1

    # 下载位置
    download_folder = ${config.home.homeDirectory}/Pictures/Variety

    # 使用 feh 设置壁纸（适用于 i3）
    set_wallpaper_script = ${pkgs.feh}/bin/feh --bg-fill %f

    # 启用的壁纸来源
    # 0=禁用，1=启用
    src1 = 1  # 本地文件夹
    src2 = 0  # Flickr
    src3 = 1  # Wallhaven.cc
    src4 = 0  # Unsplash
    src5 = 0  # Apod
    src6 = 0  # Reddit
    src7 = 0  # 媒体RSS
    src8 = 1  # Bing

    # 本地文件夹路径（请确保这个目录存在并包含图片）
    src1_folder = ${config.home.homeDirectory}/Pictures/Wallpapers

    # 禁用引用文字
    quotes_enabled = False

    # 禁用下载通知
    notify_on_download = False

    # 禁用桌面图标
    icon_on_desktop = False

    # 使用安全模式（禁用可能不适合工作场所的内容）
    safe_mode = True
  '';
}
