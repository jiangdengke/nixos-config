{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    # 基础设置
    settings = {
      # 窗口设置
      hide_window_decorations = "yes";
      window_padding_width = "10";
      placement_strategy = "center";
      resize_in_steps = "yes";
      
      # 终端滚动和历史
      scrollback_lines = 10000;
      scrollback_pager = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
      wheel_scroll_multiplier = "5.0";
      
      # 字体设置 - 选择支持中文的字体
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 12;
      
      # 为中文选择额外的字体
      symbol_map = "U+4E00-U+9FFF Noto Sans CJK SC";  # 中文字符范围
      
      # URL 处理
      url_style = "curly";
      open_url_modifiers = "kitty_mod";
      
      # 终端铃声
      enable_audio_bell = "no";
      visual_bell_duration = "0.1";
      window_alert_on_bell = "yes";
      
      # 光标设置
      cursor_shape = "beam";
      cursor_blink_interval = "0.5";
      
      # 鼠标设置
      mouse_hide_wait = "3.0";
      copy_on_select = "clipboard";
      
      # 性能设置
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";
      
      # 终端标签设置
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      active_tab_font_style = "bold";
      
      # 配色方案 - 使用流行的 Tokyo Night
      foreground = "#c0caf5";
      background = "#1a1b26";
      selection_foreground = "#1a1b26";
      selection_background = "#c0caf5";
      
      # 黑
      color0 = "#15161e";
      color8 = "#414868";
      
      # 红
      color1 = "#f7768e";
      color9 = "#f7768e";
      
      # 绿
      color2 = "#9ece6a";
      color10 = "#9ece6a";
      
      # 黄
      color3 = "#e0af68";
      color11 = "#e0af68";
      
      # 蓝
      color4 = "#7aa2f7";
      color12 = "#7aa2f7";
      
      # 紫
      color5 = "#bb9af7";
      color13 = "#bb9af7";
      
      # 青
      color6 = "#7dcfff";
      color14 = "#7dcfff";
      
      # 白
      color7 = "#a9b1d6";
      color15 = "#c0caf5";
    };
    
    # 自定义快捷键
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+l" = "next_tab";
      "ctrl+shift+h" = "previous_tab";
      
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      
      "ctrl+shift+equal" = "increase_font_size";
      "ctrl+shift+minus" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      
      "ctrl+shift+f" = "show_scrollback";
    };
    
    # 额外配置
    extraConfig = ''
      # 允许符号链接支持 (对某些输入法可能有帮助)
      allow_remote_control yes
      listen_on unix:/tmp/kitty
      
      # Shell 集成
      shell_integration enabled
      
      # 改善中文显示和输入
      term xterm-256color
    '';
  };
  
  # 确保中文输入法在终端中工作
  home.sessionVariables = {
    GLFW_IM_MODULE = "ibus"; # 对某些系统可能有帮助
    GTK_IM_MODULE = "fcitx5"; # 如果使用 fcitx5
    QT_IM_MODULE = "fcitx5";  # 如果使用 fcitx5
    XMODIFIERS = "@im=fcitx5"; # 如果使用 fcitx5
    # 如果使用 ibus，请相应修改
  };
  
  # 安装需要的字体
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
}
