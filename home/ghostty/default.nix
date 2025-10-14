{ pkgs, ... }:

{
  programs.ghostty = {
    # ===== 基本配置 =====
    # 启用 Ghostty 终端模拟器
    enable = true;
    # 使用的 Ghostty 包
    package = pkgs.ghostty;

    # ===== Shell 集成 =====
    # 启用 Zsh 集成，提供以下功能：
    # - 自动检测 shell 环境
    # - sudo 命令高亮
    # - 窗口标题自动更新
    enableZshIntegration = true;

    # ===== 语法高亮 =====
    # 为 bat（cat 替代品）安装 Ghostty 配置文件的语法高亮
    installBatSyntax = true;

    # ===== Ghostty 详细配置 =====
    settings = {
      # --- 字体设置 ---
      # 字体家族：JetBrainsMono Nerd Font（包含编程连字和图标）
      font-family = "JetBrainsMono Nerd Font";
      font-family-bold = "JetBrainsMono Nerd Font";
      font-family-italic = "JetBrainsMono Nerd Font";
      font-family-bold-italic = "JetBrainsMono Nerd Font";
      # 字体大小：8pt（可根据屏幕和喜好调整，范围通常 8-14）
      font-size = 10;

      # --- 窗口内边距 ---
      # 左右内边距：5 像素（文字距离窗口左右边缘的距离）
      window-padding-x = 5;
      # 上下内边距：5 像素（文字距离窗口上下边缘的距离）
      window-padding-y = 5;
      # 平衡内边距：确保四周 padding 均匀分布，视觉更对称
      window-padding-balance = true;

      # --- 透明度和模糊 ---
      # 背景透明度：0.8（范围 0.0-1.0，0 完全透明，1 完全不透明）
      # 注意：需要 Niri 窗口管理器配合才能生效
      background-opacity = 0.8;
      # 背景模糊半径：20 像素（毛玻璃效果，需要合成器支持）
      background-blur-radius = 80;

      # --- 滚动缓冲区 ---
      # 滚动历史记录行数：10000 行（可向上滚动查看的历史输出）
      scrollback-limit = 10000;

      # --- 主题配色 ---
      # 使用 Catppuccin Mocha 主题（深色配色方案）
      # 其他可选：Rose Pine、Dracula、Nord 等
      theme = "Catppuccin Mocha";

      # --- 光标样式 ---
      # 光标形状：block（方块），其他选项：bar（竖线）、underline（下划线）
      cursor-style = "block";
      # 光标闪烁：关闭（true 为开启闪烁）
      cursor-style-blink = false;

      # --- 窗口装饰 ---
      # 启用窗口装饰：显示标题栏和边框（false 为无边框窗口）
      window-decoration = true;

      # --- 性能优化 ---
      # 选择时复制：关闭（true 为选中文字自动复制到剪贴板）
      copy-on-select = true;
    };
  };

  # ===== 字体包安装 =====
  # 确保所需字体已安装到系统
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono  # JetBrainsMono Nerd Font（包含编程图标）
  ];
}
