{ config, lib, pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      wqy_microhei
      wqy_zenhei
      xorg.fontadobe75dpi
      noto-fonts-color-emoji
    ];
  };
}
