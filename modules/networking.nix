{
  config,
  lib,
  pkgs,
  ...
}:

{
  # 网络配置
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
}
