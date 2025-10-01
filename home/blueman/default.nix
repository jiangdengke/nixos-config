{ pkgs, ... }:

{
  # 托盘程序本体
  home.packages = [ pkgs.blueman ];

  # HM 自带的 blueman-applet 服务（如果你的 HM 支持这个模块）
  services.blueman-applet.enable = true;

  # （可选）Polkit 认证代理，配对/授权弹窗需要；用 GNOME 的轻量 agent
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

