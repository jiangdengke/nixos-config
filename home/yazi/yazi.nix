{
  # 主界面行为：面板比例/滚动与排序策略
  mgr = {
    linemode = "none";
    mouse_events = [
      "click"
      "scroll"
    ];
    ratio = [
      2
      3
      5
    ]; # 面板宽度 2:3:5，对应 README 中的描述
    scrolloff = 5;
    show_hidden = false;
    show_symlink = true;
    sort_by = "alphabetical";
    sort_dir_first = true;
    sort_reverse = false;
    sort_sensitive = false;
    sort_translit = false;
    title_format = "Yazi: {cwd}";
  };

  # 针对不同类型的文件，选择预设 opener
  open = {
    rules = [
      {
        name = "*/";
        use = [
          "edit"
          "open"
          "reveal"
        ];
      }
      {
        mime = "text/*";
        use = [
          "edit"
          "reveal"
        ];
      }
      {
        mime = "image/*";
        use = [
          "open"
          "reveal"
        ];
      }
      {
        mime = "{audio,video}/*";
        use = [
          "play"
          "reveal"
        ];
      }
      {
        mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
        use = [
          "extract"
          "reveal"
        ];
      }
      {
        mime = "application/{json,ndjson}";
        use = [
          "edit"
          "reveal"
        ];
      }
      {
        mime = "*/javascript";
        use = [
          "edit"
          "reveal"
        ];
      }
      {
        mime = "inode/empty";
        use = [
          "edit"
          "reveal"
        ];
      }
      {
        name = "*";
        use = [
          "open"
          "reveal"
        ];
      }
    ];
  };

  # 定义可复用的 opener：编辑/播放/提取/显示元信息
  opener = {
    edit = [
      {
        block = true;
        desc = "$EDITOR";
        for = "unix";
        run = "\${EDITOR:-nvim} \"$@\"";
      }
    ];
    extract = [
      {
        desc = "Extract here";
        for = "unix";
        run = "ya pub extract --list \"$@\"";
      }
    ];
    open = [
      {
        desc = "Open";
        for = "linux";
        run = "xdg-open \"$1\"";
      }
      {
        desc = "Open";
        for = "macos";
        run = "open \"$@\"";
      }
    ];
    play = [
      {
        for = "unix";
        orphan = true;
        run = "mpv --force-window \"$@\"";
      }
      {
        block = true;
        desc = "Show media info";
        for = "unix";
        run = "mediainfo \"$1\"; echo \"Press enter to exit\"; read _";
      }
    ];
    reveal = [
      {
        desc = "Reveal";
        for = "linux";
        run = "xdg-open \"$(dirname \"$1\")\"";
      }
      {
        desc = "Reveal";
        for = "macos";
        run = "open -R \"$1\"";
      }
      {
        block = true;
        desc = "Show EXIF";
        for = "unix";
        run = "exiftool \"$1\"; echo \"Press enter to exit\"; read _";
      }
    ];
  };

  # 预览行为：配合 ueberzugpp 的尺寸/质量设定
  preview = {
    cache_dir = "";
    image_delay = 30;
    image_filter = "triangle";
    image_quality = 75;
    max_height = 900;
    max_width = 600;
    sixel_fraction = 15;
    tab_size = 2;
    ueberzug_offset = [
      0
      0
      0
      0
    ];
    ueberzug_scale = 1;
    wrap = "no";
  };

  # which 面板：保持原生排序（与 README 快捷键对应）
  which = {
    sort_by = "none";
    sort_reverse = false;
    sort_sensitive = false;
    sort_translit = false;
  };
}
