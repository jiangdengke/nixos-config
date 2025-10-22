{
  config,
  lib,
  pkgs,
  ...
}:

{
  fonts = {
    enableDefaultPackages = false;
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Maple Mono" ];
        sansSerif = [ "Maple Mono" ];
        serif = [ "Maple Mono" ];
      };
    };
    packages = with pkgs; [
      maple-mono
    ];
  };
}
