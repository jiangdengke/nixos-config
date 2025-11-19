{
  config,
  lib,
  pkgs,
  ...
}:

{
  # 启用系统级 ZSH
  programs.zsh = {
    enable = true; # 这一行很重要！
    enableCompletion = false; # 交给 Zim 的 completion 模块处理 compinit
  };
  # 用户配置
  users.users.jdk = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # 启用sudo权限
  };
}
