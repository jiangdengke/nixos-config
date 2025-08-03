# media - control and enjoy audio/video
{
  # imports = [
  # ];

  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer
    
    # video/audio player
    vlc
    
    # images
    feh
    # imv  # 如果你不再需要imv，可以注释或删除
  ];

  programs = {
    # mpv配置可以保留，也可以删除，取决于你是否还想保留mpv
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };

    obs-studio.enable = true;
    
    # 配置feh（可选）
    feh = {
      enable = true;
      # 可以添加一些feh的配置选项，例如：
      # keybindings = { ... };
    };
  };

  services = {
    playerctld.enable = true;
  };
  
  # 设置默认应用程序（MIME类型关联）
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # 视频文件
      "video/mp4" = ["vlc.desktop"];
      "video/x-matroska" = ["vlc.desktop"];
      "video/mpeg" = ["vlc.desktop"];
      "video/quicktime" = ["vlc.desktop"];
      "video/webm" = ["vlc.desktop"];
      
      # 音频文件
      "audio/mpeg" = ["vlc.desktop"];
      "audio/mp4" = ["vlc.desktop"];
      "audio/flac" = ["vlc.desktop"];
      "audio/ogg" = ["vlc.desktop"];
      "audio/wav" = ["vlc.desktop"];
      
      # 图片文件
      "image/jpeg" = ["feh.desktop"];
      "image/png" = ["feh.desktop"];
      "image/gif" = ["feh.desktop"];
      "image/webp" = ["feh.desktop"];
      "image/svg+xml" = ["feh.desktop"];
      "image/tiff" = ["feh.desktop"];
    };
  };
}
