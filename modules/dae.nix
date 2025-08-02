{ config, lib, pkgs, ... }:

{
  
  # DAE代理配置
  services.dae = {
    enable = true;
    configFile = "/etc/dae/config.dae";
  };
}
