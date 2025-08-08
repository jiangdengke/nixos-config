{ config, pkgs, ... }:
let
  wpDir = "${config.home.homeDirectory}/Pictures/Wallpapers";
  swwwRandom = pkgs.writeShellApplication {
    name = "swww-random";
    runtimeInputs = [ pkgs.swww pkgs.findutils pkgs.gawk pkgs.coreutils ];
    text = builtins.readFile ./swww-random.sh;  # ← 同级脚本
  };
in {
  services.swww.enable = true;

  home.packages = [ swwwRandom ];

  systemd.user.services."swww-random" = {
    Unit.Description = "Randomize wallpaper with swww";
    Service = {
      Type = "oneshot";
      Environment = [
        "SWWW_DURATION=1"
        "SWWW_FPS=60"
        "SWWW_TRANSITION=any"
        "SWWW_PER_OUTPUT=0"   # 1 = 多屏各自随机
      ];
      ExecStart = "${swwwRandom}/bin/swww-random ${wpDir}";
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.timers."swww-random" = {
    Unit.Description = "Timer for swww-random";
    Timer = {
      OnBootSec = "2m";
      OnUnitActiveSec = "30m";
      Unit = "swww-random.service";
    };
    Install.WantedBy = [ "timers.target" ];
  };

  # 进桌面先换一次（可选）
  wayland.windowManager.hyprland.settings.exec-once = [
    "${swwwRandom}/bin/swww-random ${wpDir}"
  ];
}

