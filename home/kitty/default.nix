{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      # 字体配置
      font_family = "MesloLGL Nerd Font";
      bold_font = "MesloLGL Nerd Font Bold";
      italic_font = "MesloLGL Nerd Font Italic";
      bold_italic_font = "MesloLGL Nerd Font Bold Italic";
      font_size = 10;

      # 光标配置
      cursor_shape = "block";
      cursor_blink_interval = 0;

      # 滚动配置
      scrollback_lines = 10000;

      # 窗口配置
      window_padding_width = 5;
      remember_window_size = true;
      initial_window_width = 640;
      initial_window_height = 400;

      # 背景透明度配置
      background_opacity = "0.8";
      background_blur = 80;

      # 选择复制
      copy_on_select = true;

      # 窗口装饰
      hide_window_decorations = false;

      # 性能优化
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;

      # Tab 配置
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      # 鼠标配置
      mouse_hide_wait = "3.0";
      url_color = "#0087bd";
      url_style = "curly";

      # 响铃配置
      enable_audio_bell = false;
      visual_bell_duration = "0.0";

      # 剪贴板配置
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
    };

    theme = "Catppuccin-Mocha";
  };
}
