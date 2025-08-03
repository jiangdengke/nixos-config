{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    
    # 字体设置
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
      # 无需指定包，我们将在 home.packages 中安装
    };
    
    # 主题设置 - Tokyo Night
    # 可以使用 themeFile 来使用预设主题，这里我们使用自定义设置
    settings = {
      # 窗口设置
      hide_window_decorations = "yes";
      window_padding_width = 10;
      placement_strategy = "center";
      resize_in_steps = "yes";
      
      # 终端滚动和历史
      scrollback_lines = 10000;
      scrollback_pager = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
      wheel_scroll_multiplier = 5.0;
      
      # 为中文选择额外的字体
      symbol_map = "U+4E00-U+9FFF Noto Sans CJK SC";  # 中文字符范围
      
      # URL 处理
      url_style = "curly";
      open_url_modifiers = "kitty_mod";
      
      # 终端铃声
      enable_audio_bell = "no";
      visual_bell_duration = 0.1;
      window_alert_on_bell = "yes";
      
      # 光标设置
      cursor_shape = "beam";
      cursor_blink_interval = 0.5;
      
      # 鼠标设置
      mouse_hide_wait = 3.0;
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
      
      # Tokyo Night 主题配色方案
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
      
      # 中文输入相关
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      term = "xterm-256color";
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
    
    # 环境变量 - 设置中文输入相关环境变量
    environment = {
      "GLFW_IM_MODULE" = "ibus";
      "GTK_IM_MODULE" = "fcitx5";
      "QT_IM_MODULE" = "fcitx5";
      "XMODIFIERS" = "@im=fcitx5";
    };
    
    # Shell 集成
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      mode = "enabled"; # 启用全功能模式
    };
    
    # Git 集成
    enableGitIntegration = true;
    
    # 附加配置 - 任何其他未被上述选项覆盖的配置
    extraConfig = ''
      # 改善中文显示和输入
      adjust_line_height 0
      adjust_column_width 0
      box_drawing_scale 0.001, 1, 1.5, 2
    '';
  };
  
  # 安装必要的字体
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
  
  # 创建优化的启动脚本
  home.file.".local/bin/kitty-fcitx5.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      export GLFW_IM_MODULE=ibus
      export GTK_IM_MODULE=fcitx5
      export QT_IM_MODULE=fcitx5
      export XMODIFIERS=@im=fcitx5
      exec kitty "$@"
    '';
  };
  
  # 创建桌面快捷方式
  xdg.desktopEntries.kitty-fcitx5 = {
    name = "Kitty Terminal (中文优化)";
    genericName = "Terminal Emulator";
    comment = "A fast, feature-rich, GPU based terminal with Chinese input support";
    exec = "${config.home.homeDirectory}/.local/bin/kitty-fcitx5.sh";
    icon = "kitty";
    categories = [ "System" "TerminalEmulator" ];
    terminal = false;
  };
  
  # 配置 i3 快捷键以使用优化的启动脚本
  xsession.windowManager.i3.config.keybindings = lib.mkOptionDefault {
    "${config.xsession.windowManager.i3.config.modifier}+Return" = "exec --no-startup-id ${config.home.homeDirectory}/.local/bin/kitty-fcitx5.sh";
  };
}
