{ config, lib, pkgs, ... }:

{
  # 引导加载器配置
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.timeout = 3;

services.logind = {
  lidSwitch = "ignore";  # 笔记本合上盖子不休眠
  extraConfig = ''
    HandleSuspendKey=ignore
    HandleHibernateKey=ignore
    HandleLidSwitch=ignore
    IdleAction=ignore
  '';
};

# 禁用系统级电源管理
powerManagement = {
  enable = true;
  powertop.enable = false;  # 禁用 powertop 的自动调整
};
}
