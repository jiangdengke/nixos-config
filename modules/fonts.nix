{
  config,
  lib,
  pkgs,
  ...
}:

{
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "JetBrains Mono"
          "JetBrainsMono Nerd Font"
        ];
        sansSerif = [
          "JetBrains Mono"
          "JetBrainsMono Nerd Font"
          "Noto Sans CJK SC"
        ];
        serif = [
          "JetBrains Mono"
          "JetBrainsMono Nerd Font"
          "Noto Serif CJK SC"
        ];
      };
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
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
