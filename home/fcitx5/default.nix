{ lib, pkgs, ... }:
let
  classicUiConfig = builtins.readFile ./classicui.conf;
in
{
  # 系统层已启用 fcitx5，这里仅下发主题配置
  xdg.configFile."fcitx5/conf/classicui.conf" = {
    force = true;
    text = lib.mkForce classicUiConfig;
  };

  xdg.dataFile."fcitx5/themes/macOS-light" = {
    source = ./macOS-light;
    recursive = true;
  };
}
