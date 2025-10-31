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
          "MesloLGL Nerd Font"
          "MesloLGL Nerd Font Mono"
          "JetBrainsMono Nerd Font"
          "JetBrains Mono"
        ];
        sansSerif = [
          "MesloLGL Nerd Font"
          "Noto Sans CJK SC"
          "WenQuanYi Zen Hei"
        ];
        serif = [
          "MesloLGL Nerd Font"
          "Noto Serif CJK SC"
          "WenQuanYi Zen Hei"
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
      nerd-fonts.meslo-lg
      wqy_microhei
      wqy_zenhei
      source-han-serif
      xorg.fontadobe75dpi
      noto-fonts-color-emoji
    ];
  };
}
