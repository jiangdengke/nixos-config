{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/boot.nix
    ../modules/fonts.nix
    ../modules/i18n.nix
    ../modules/networking.nix
    ../modules/packages.nix
    ../modules/intel-gpu.nix
    ../modules/dae
    ../modules/users.nix
    ../modules/niri
    ../modules/nix-ld.nix
  ];

  # 核心系统配置
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16Zpm4U4naySO3W4="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.overlays = [
    (final: prev: {
      libsForQt5 = (prev.libsForQt5 or { }) // {
        fcitx5-with-addons = prev.fcitx5-with-addons;
      };
    })
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [
        "wlr"
        "gtk"
      ];
      filechooser.default = [ "gtk" ];
    };
  };
  #services.displayManager.gdm.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.getty.autologinUser = "jdk";

  home-manager.backupFileExtension = "backup";
  # 使用libinput禁用触控板
  services.libinput = {
    enable = true;
    touchpad = {
      sendEventsMode = "disabled"; # 禁用所有触控板事件
    };
  };

  nixpkgs.config.allowUnfree = true;
  environment.variables = {
    EDITOR = "nvim";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  # 时区设置
  time.timeZone = "Asia/Shanghai";

  # 系统版本（保留在主配置文件中）
  system.stateVersion = "25.05"; # 请勿修改！
}
