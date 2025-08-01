{ config, pkgs, ... }:

{
  # 导入所有子模块
  imports = [
    ./i3           # i3wm 窗口管理器配置
    ./fcitx5       # 中文输入法配置
    ./programs
  ];

  # 用户基本信息
  home.username = "jdk";
  home.homeDirectory = "/home/jdk";
  
  # 启用 home-manager
  programs.home-manager.enable = true;


  # 基础环境变量
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    LANG = "zh_CN.UTF-8";
    LC_CTYPE = "zh_CN.UTF-8";
    PATH = "$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin";
  };


  # 不要修改此项，除非您知道自己在做什么
  home.stateVersion = "25.05";
}
