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
      icon-theme = "Papirus";    # 使用 Papirus 图标主题（您可以换成您喜欢的主题）
      display-drun = "应用";     # 应用启动器的标签文本
      drun-display-format = "{name}";
      sidebar-mode = true;
    };
    
    # 主题配置
    theme = ./rofi-theme.rasi;  # 指定主题文件路径
  };
home.file = {
  ".config/rofi/rofi-theme.rasi".source = ./rofi-theme.rasi;
};
  # 将脚本复制到用户的 bin 目录
  home.file = {
    ".local/bin/toggle-rofi" = {
      source = ./toggle-rofi.sh;  # 脚本位于同一目录下
      executable = true;          # 确保脚本是可执行的
    };
  };
  
  # 确保 ~/.local/bin 在 PATH 中
  home.sessionPath = [
    "$HOME/.local/bin"
  ];  
  # 确保安装图标主题
  environment.systemPackages = with pkgs; [
    papirus-icon-theme  # 图标主题
  ];
}
