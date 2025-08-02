{ config, lib, pkgs, ... }:

{
  
  # DAE代理配置
  services.dae = {
    enable = true;
    configFile = "./config.dae";
  };
}
