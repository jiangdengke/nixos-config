{ config, pkgs, ... }:

{
  # 安装 Rofi 及其依赖
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    
    # Rofi 基础配置
    extraConfig = {
      modi = "drun,run,window,ssh";
      show-icons = true;         # 显示应用图标
      icon-theme = "Papirus";    # 使用 Papirus 图标主题
      display-drun = "应用";     # 应用启动器的标签文本
      drun-display-format = "{name}";
      sidebar-mode = true;
    };
    
    # 主题配置 - 使用本地路径
    theme = "~/.config/rofi/themes/custom.rasi";
  };
  
  # 将所有文件定义合并到一个 home.file 属性中
  home.file = {
    # 创建主题目录并确保存在
    ".config/rofi/themes/.keep".text = "";
    
    # 复制主题文件到正确的位置
    ".config/rofi/themes/custom.rasi".source = ./rofi-theme.rasi;
    
    # 复制切换脚本到 ~/.local/bin 并设为可执行
    ".local/bin/toggle-rofi.sh" = {
      source = ./toggle-rofi.sh;
      executable = true;
    };
  };
  
  # 确保 ~/.local/bin 在 PATH 中
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  
  # 确保安装图标主题
  home.packages = with pkgs; [
    papirus-icon-theme
  ];
}
