{ config, lib, pkgs, ... }:

{
  # Clash代理配置
  programs.clash-verge = {
    enable = true;
    tunMode = true;
    autoStart = true;
  };
  
  # DAE代理配置
  services.dae = {
    enable = true;
    configFile = "/etc/dae/config.dae";
  };
}
