{ pkgs, ... }:
{
  # Kitty 终端模拟器配置
  # Kitty 是一个功能强大、GPU 加速的终端模拟器
  programs.kitty = {
    # 启用 Kitty 终端
    enable = true;

    # 禁用 shell 集成（避免与 Zim 的 completion 模块冲突）
    shellIntegration.enableZshIntegration = false;

    # Kitty 详细配置选项
    settings = {
      # ==================== 字体配置 ====================
      # 普通文本使用的字体（MesloLGL 更粗更清晰）
      font_family = "MesloLGL Nerd Font";

      # 粗体文本使用的字体
      bold_font = "MesloLGL Nerd Font Bold";

      # 斜体文本使用的字体
      italic_font = "MesloLGL Nerd Font Italic";

      # 粗斜体文本使用的字体
      bold_italic_font = "MesloLGL Nerd Font Bold Italic";

      # 字体大小（调整为 10 更舒适）
      font_size = 12;

      # ==================== 光标配置 ====================
      # 光标形状：block（方块）、beam（竖线）、underline（下划线）
      cursor_shape = "block";

      # 光标闪烁间隔（0 表示不闪烁，单位：秒）
      cursor_blink_interval = 0;

      # 光标轨迹效果（HyDE 风格：移动时有拖尾）
      cursor_trail = 1;

      # ==================== 滚动配置 ====================
      # 回滚缓冲区行数（保存的历史记录行数）
      scrollback_lines = 10000;

      # ==================== 窗口配置 ====================
      # 窗口内边距宽度（调整为更紧凑的 5px）
      window_padding_width = 5;

      # 记住窗口大小（关闭后重新打开时恢复窗口大小）
      remember_window_size = true;

      # 初始窗口宽度（单位：像素）
      initial_window_width = 640;

      # 初始窗口高度（单位：像素）
      initial_window_height = 400;

      # ==================== 背景透明度配置 ====================
      # 背景不透明度（0.0 完全透明，1.0 完全不透明）
      background_opacity = "0.8";

      # 背景模糊程度（仅在支持的合成器下生效，单位：像素）
      background_blur = 80;

      # ==================== 选择与复制配置 ====================
      # 选中文本时自动复制到剪贴板
      copy_on_select = true;

      # ==================== 窗口装饰配置 ====================
      # 是否隐藏窗口装饰（标题栏等）
      # false = 显示装饰，true = 隐藏装饰
      hide_window_decorations = false;

      # ==================== 性能优化配置 ====================
      # 重绘延迟（单位：毫秒，值越小越流畅但 CPU 占用越高）
      repaint_delay = 10;

      # 输入延迟（单位：毫秒，用于批处理输入以提高性能）
      input_delay = 3;

      # 同步到显示器刷新率（减少画面撕裂）
      sync_to_monitor = true;

      # ==================== 标签页配置 ====================
      # 标签栏位置：top（顶部）、bottom（底部）
      tab_bar_edge = "bottom";

      # 标签栏样式：fade（淡入淡出）、slant（倾斜）、separator（分隔符）、powerline（电力线）
      tab_bar_style = "powerline";

      # Powerline 标签栏的样式：angled（有角度）、slanted（倾斜）、round（圆形）
      tab_powerline_style = "slanted";

      # ==================== 鼠标配置 ====================
      # 鼠标不活动多久后隐藏（单位：秒，0 表示不隐藏）
      mouse_hide_wait = "3.0";

      # URL 链接的颜色
      url_color = "#0087bd";

      # URL 下划线样式：none（无）、straight（直线）、double（双线）、curly（波浪线）、dotted（点线）、dashed（虚线）
      url_style = "curly";

      # ==================== 响铃配置 ====================
      # 是否启用音频响铃（终端响铃时发出声音）
      enable_audio_bell = false;

      # 视觉响铃持续时间（单位：秒，0 表示禁用视觉响铃）
      visual_bell_duration = "0.0";

      # ==================== 剪贴板配置 ====================
      # 剪贴板控制权限
      # write-clipboard：允许写入系统剪贴板
      # write-primary：允许写入主选择区（Linux X11）
      # read-clipboard：允许读取系统剪贴板
      # read-primary：允许读取主选择区
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";

      # ==================== 窗口关闭确认 ====================
      # 关闭窗口时是否需要确认（0 = 不确认，直接关闭）
      confirm_os_window_close = 0;
    };

    # ==================== 主题配置 ====================
    # 使用的配色主题（Catppuccin Mocha 是柔和的深色主题）
    themeFile = "Catppuccin-Mocha";
  };
}
