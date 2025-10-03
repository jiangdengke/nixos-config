{ config, pkgs, ... }:

{
  programs.xwayland.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
