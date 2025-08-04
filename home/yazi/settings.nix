{ config, pkgs, ... }:

{
  programs.yazi.settings = {
    # 管理器设置
    manager = {
      ratio = [ 1 4 3 ];  # 目录树、文件列表和预览区域的比例
      sort_by = "natural";  # 排序方式：natural, mtime, size, ext
      sort_sensitive = false;  # 排序是否区分大小写
      sort_reverse = false;  # 是否反向排序
      sort_dir_first = true;  # 目录是否排在前面
      show_hidden = false;  # 是否显示隐藏文件
      show_symlink = true;  # 是否显示符号链接指向
    };
    
    # 预览设置
    preview = {
      tab_size = 2;  # Tab 宽度
      max_width = 1000;  # 最大宽度限制，0 表示无限制
      max_height = 1000;  # 最大高度限制，0 表示无限制
      cache_dir = "";  # 缓存目录，置空则使用系统临时目录
    };
    
    # 打开器设置
    opener = {
      # 编辑器选项
      edit = [
        { exec = "nvim"; block = true; }
        { exec = "vim"; block = true; }
        { exec = "nano"; block = true; }
      ];
      
      # 不同类型文件的处理方式
      text = { exec = "nvim"; block = true; };
      image = { exec = "feh"; orphan = true; };
      video = { exec = "mpv"; orphan = true; };
      audio = { exec = "mpv"; orphan = true; };
      pdf = { exec = "zathura"; orphan = true; };
      archive = { exec = "unar"; block = true; };
    };
    
    # 打开行为设置
    open = {
      rules = [
        # 使用默认应用打开
        { name = "*.jpg"; use = "image"; }
        { name = "*.jpeg"; use = "image"; }
        { name = "*.png"; use = "image"; }
        { name = "*.svg"; use = "image"; }
        
        { name = "*.mp4"; use = "video"; }
        { name = "*.mkv"; use = "video"; }
        { name = "*.avi"; use = "video"; }
        
        { name = "*.pdf"; use = "pdf"; }
        
        { name = "*.zip"; use = "archive"; }
        { name = "*.tar"; use = "archive"; }
        { name = "*.gz"; use = "archive"; }
        { name = "*.rar"; use = "archive"; }
        { name = "*.7z"; use = "archive"; }
      ];
    };
  };
}
