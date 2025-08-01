{ config, lib, pkgs, ... }:

{
  # 引导加载器配置
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
