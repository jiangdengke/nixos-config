{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/boot.nix
    ../modules/i3.nix
    ../modules/fonts.nix
    ../modules/input-method.nix
    ../modules/i18n.nix
    ../modules/networking.nix
    ../modules/packages.nix
    ../modules/dae
    ../modules/users.nix
  ];

  # 核心系统配置
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://mirrors.cernet.edu.cn/nix-channels/store"];
  };
  
  nixpkgs.config.allowUnfree = true;
  environment.variables.EDITOR = "nvim";
  
  # 时区设置
  time.timeZone = "Asia/Shanghai";
  
  # 系统版本（保留在主配置文件中）
  system.stateVersion = "25.05"; # 请勿修改！
}
