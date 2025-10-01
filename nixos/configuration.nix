{ config, lib, pkgs, ... }:

# NixOS 主机的顶层配置入口，汇总系统和 Home Manager 模块
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
    ../modules/niri
    ../modules/nix-ld.nix
    ../modules/noctalia
  ];

  # 核心系统配置
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # 启用 PipeWire 提供音频服务
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.getty.autologinUser = "jdk";

  # 保持 Home Manager 默认覆盖策略，如需备份可在此设置后缀
  # home-manager.backupFileExtension = "backup";
  # 使用libinput禁用触控板
  services.libinput = {
    enable = true;
    touchpad = {
      sendEventsMode = "disabled";  # 禁用所有触控板事件
    };
  };
  
  nixpkgs.config.allowUnfree = true;
  
  # 时区配置统一在 modules/i18n.nix 中维护
  
  # 系统版本（保留在主配置文件中）
  system.stateVersion = "25.05"; # 请勿修改！
}
