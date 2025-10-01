
# 管理 Waybar 程序及其资源文件的 Home Manager 模块
{ config, pkgs, ... }:
{

  home.packages = [
    pkgs.brightnessctl
    pkgs.pwvucontrol # PipeWire 原生音量控制
    pkgs.blueman
  ];
  home.file.".config/waybar" = {
    # 指向当前 default.nix 同级的 waybar 目录
    source = ./waybar;

    # 递归地映射目录结构，目录下的每个文件都会被 symlink
    recursive = true;

  };
  # 建议：有个图形 polkit 代理，配对/授权更顺滑
  systemd.user.services.polkit-gnome-agent = {
    Unit = {
      Description = "polkit agent";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service.ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "graphical-session.target" ];
  };

}
