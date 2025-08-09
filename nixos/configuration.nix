{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/boot.nix
    ../modules/fonts.nix
    ../modules/input-method.nix
    ../modules/i18n.nix
    ../modules/networking.nix
    ../modules/packages.nix
    ../modules/dae
    ../modules/users.nix
    ../modules/bluetooth-audio.nix
    ../modules/hyprland
    ../modules/prime-offload-amd-nvidia.nix
  ];

  # 核心系统配置
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
  #services.displayManager.gdm.enable = true;
  #programs.hyprland.enable = true;

hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
services.blueman.enable = true;   # 提供 blueman-mechanism

 services.getty.autologinUser = "jdk";

  #home-manager.backupFileExtension = "";
  # 使用libinput禁用触控板
  services.libinput = {
    enable = true;
    touchpad = {
      sendEventsMode = "disabled";  # 禁用所有触控板事件
    };
  };
  
  nixpkgs.config.allowUnfree = true;
  environment.variables.EDITOR = "nvim";
  
  # 时区设置
  time.timeZone = "Asia/Shanghai";
  
  # 系统版本（保留在主配置文件中）
  system.stateVersion = "25.05"; # 请勿修改！
}
