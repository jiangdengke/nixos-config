{ config, lib, pkgs, ... }:

{
  
  # DAE代理配置
  services.dae = {
    enable = true;
    configFile = builtins.toString ./config.dae; # 这会引用与 default.nix 同级的 config.dae
  };
}
