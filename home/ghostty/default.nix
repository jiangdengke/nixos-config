{ pkgs, config, ... }:

{
  # 直接写配置文件而不是用 programs.ghostty
  home.file.".config/ghostty/config".text = ''
    # 字体配置
    font-family = JetBrainsMono Nerd Font
    font-size = 11

    # 窗口配置
    window-padding-x = 5
    window-padding-y = 5
    window-padding-balance = true

    # 透明度设置
    background-opacity = 0.8
    background-blur-radius = 20

    # 滚动历史
    scrollback-limit = 10000

    # 主题配色
    theme = Catppuccin Mocha

    # 光标
    cursor-style = block
    cursor-style-blink = false

    # 窗口装饰
    window-decoration = true

    # 性能优化
    copy-on-select = false

    # Shell 集成
    shell-integration = true
    shell-integration-features = cursor,sudo,title
  '';

  # 确保 ghostty 已安装
  home.packages = with pkgs; [
    ghostty
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}
