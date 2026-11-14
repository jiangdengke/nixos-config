# 本机的硬件、账户、用户环境与可选服务。
{ pkgs, ... }:

let
  username = "jdk";
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
    # Intel 核显的机器可改为 intel-gpu.nix。
    ../../modules/nvidia-gpu.nix
    # DAE 读取 /etc/dae/config.dae；不需要代理时移除此导入。
    ../../modules/dae
  ];

  networking.hostName = "nixos";

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    # 密码由安装时的 passwd 设置，不写入仓库。
  };
  home-manager.users.${username} = ../../home;

  # 只自动登录 TTY1；桌面由用户手动执行 niri-session 启动。
  services.getty.autologinUser = username;

  services.libinput.touchpad.sendEventsMode = "disabled";

  system.stateVersion = "25.05";
}
