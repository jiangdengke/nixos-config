# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

programs.clash-verge = {
   enable = true;
   tunMode = true;
   autoStart = true;

};
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  environment.variables.EDITOR = "vim";
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
programs.starship.enable = true;

programs.zsh.enable = true;
  users.users.jdk = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # 启用sudo权限
  };
networking = {
 hostName = "nixos";
 networkmanager.enable = true;

};

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.

  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
nixpkgs.overlays = [
    (final: prev: {
      librime = (prev.librime.override {
        plugins = [
#           (pkgs.fetchFromGitHub {
#             owner = "hchunhui";
#             repo = "librime-lua";
#             rev = "e3912a4b3ac2c202d89face3fef3d41eb1d7fcd6";
#             sha256 = "sha256-zx0F41szn5qlc2MNjt1vizLIsIFQ67fp5cb8U8UUgtY=";
#           })
            pkgs.librime-lua
            pkgs.librime-octagram
        ];
      }).overrideAttrs (old: {
        buildInputs = (old.buildInputs or []) ++ [pkgs.luajit]; # 用luajit
#         buildInputs = (old.buildInputs or []) ++ [pkgs.lua5_4]; # 用lua5.4
      });
    })
  ];

#   i18n.inputMethod.enable = false;
  i18n = {
   defaultLocale = "zh_CN.UTF-8";
   inputMethod = {
     
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      rime-data # 如果你不需要内置数据可以注释掉，我就注释掉了
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-rime
      fcitx5-nord # 主题
#       fcitx5-material-color # 主题
    ];
  };
};



  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra
      jetbrains-mono
      wqy_microhei
      wqy_zenhei
      xorg.fontadobe75dpi
      nerd-font-patcher
      noto-fonts-color-emoji
    ];  # fonts 的闭合分号
  };  # fonts 的闭合花括号



  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver = {
enable = true;
windowManager.i3 = {
enable = true;
extraPackages = with pkgs; [
 dmenu
 i3status
 i3lock
  ];
 };
}; 
services.displayManager.gdm.enable = true;
services.dae = {
  enable = true;
  configFile = "/etc/dae/config.dae";
};

  


programs.i3lock.enable = true;
  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
git
firefox
i3status
i3-gaps
rofi
variety
picom
kitty
lxappearance
clash-verge-rev
localsend
neovim
dae
qq
wechat-uos
xclip

networkmanager
networkmanagerapplet
iw
wpa_supplicant
   ];


nix.settings.substituters = [
"https://mirrors.cernet.edu.cn/nix-channels/store"
];
  system.stateVersion = "25.05"; # Did you read the comment?

}

