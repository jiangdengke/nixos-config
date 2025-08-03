{ config, lib, pkgs, ... }:

{
  # 启用 Fastfetch
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
  };
}
