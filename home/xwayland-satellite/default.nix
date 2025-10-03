{ pkgs, ... }:
{
  home.packages = [ pkgs.xwayland-satellite ];

  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "XWayland Satellite";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
