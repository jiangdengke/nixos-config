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
          "CaskaydiaCove Nerd Font Mono"
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
      jetbrains-mono
      nerd-fonts.caskaydia-cove  # CaskaydiaCove (Cascadia Code) Nerd Font - HyDE 风格
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
      wqy_microhei
      wqy_zenhei
      source-han-serif
      font-adobe-75dpi
      noto-fonts-color-emoji
    ];
  };
}
