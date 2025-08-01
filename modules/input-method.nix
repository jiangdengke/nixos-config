{ config, lib, pkgs, ... }:

{
  # 输入法相关的环境变量
  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
  
  # librime覆盖配置
  nixpkgs.overlays = [
    (final: prev: {
      librime = (prev.librime.override {
        plugins = [
          pkgs.librime-lua
          pkgs.librime-octagram
        ];
      }).overrideAttrs (old: {
        buildInputs = (old.buildInputs or []) ++ [pkgs.luajit];
      });
    })
  ];
  
  # 区域和输入法配置
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.waylandFrontend = true;
      fcitx5.addons = with pkgs; [
        rime-data
        fcitx5-gtk
        kdePackages.fcitx5-qt
        fcitx5-rime
        fcitx5-nord
      ];
    };
  };
}
