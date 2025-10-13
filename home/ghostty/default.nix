{ pkgs, ... }:

{
  programs.ghostty = {
    # 启用 Ghostty
    enable = true;
    package = pkgs.ghostty;

    # 启用 Zsh 集成（自动配置 shell integration）
    enableZshIntegration = true;

    # 为 bat 安装语法高亮（默认启用）
    installBatSyntax = true;

    # Ghostty 配置
    settings = {
      # 字体配置
      font-family = "JetBrainsMono Nerd Font";
      font-size = 11;

      # 窗口配置
      window-padding-x = 5;
      window-padding-y = 5;
      window-padding-balance = true;

      # 透明度设置
      background-opacity = 0.6;
      background-blur-radius = 20;

      # 滚动历史
      scrollback-limit = 10000;

      # 主题配色
      theme = "Catppuccin Mocha";

      # 光标
      cursor-style = "block";
      cursor-style-blink = false;

      # 窗口装饰
      window-decoration = true;

      # 性能优化
      copy-on-select = false;
    };
  };

  # 确保字体包已安装
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}
