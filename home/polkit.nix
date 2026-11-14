{ pkgs, ... }:

{
  # 图形 polkit 认证代理：蓝牙配对、挂载等授权弹窗需要
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
