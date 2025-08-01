{ config, lib, pkgs, ... }:

{
  # 用户配置
  users.users.jdk = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # 启用sudo权限
  };
}
