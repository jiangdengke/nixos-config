{config, pkgs, ...}:
{

  home.packages = [
  pkgs.brightnessctl 
  pkgs.pavucontrol
  pkgs.swayosd
  ];
# 让 swayosd 的 server 常驻（否则 client 只能改音量，不会有 OSD）
  systemd.user.services.swayosd = {
    Unit = {
      Description = "swayosd server";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service.ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
    Install.WantedBy = [ "graphical-session.target" ];
  };
    home.file.".config/waybar" = {
  # 指向当前 default.nix 同级的 waybar 目录
  source = ./waybar;

  # 递归地映射目录结构，目录下的每个文件都会被 symlink
  recursive = true;
};

}
