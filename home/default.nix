{ config, ... }:

{
  imports = [
    ./desktop.nix
    ./dev
    ./programs
    ./zsh
    ./fastfetch
    ./yazi
    ./nvim
  ];

  # 用户名与 homeDirectory 由 NixOS 的 Home Manager 集成从系统账户继承。
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "zh_CN.UTF-8";
    LC_CTYPE = "zh_CN.UTF-8";
  };

  # 通用路径集中在此处；Go 与 Composer 的专用路径由各开发模块维护。
  home.sessionPath = [
    "${config.home.homeDirectory}/bin"
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.stateVersion = "25.05";
}
