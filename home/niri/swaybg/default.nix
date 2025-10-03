{ config, pkgs, lib, ... }:
let
  wpDir = "${config.home.homeDirectory}/Pictures/Wallpapers";
  swaybgRandom = pkgs.writeShellApplication {
    name = "swaybg-random";
    runtimeInputs = [ pkgs.coreutils pkgs.findutils pkgs.swaybg pkgs.bash ];
    text = builtins.readFile ./swaybg-random.sh;
  };
in {
  home.packages = [ pkgs.swaybg swaybgRandom ];

  systemd.user.services."swaybg-random" = {
    Unit = {
      Description = "Randomize wallpaper with swaybg";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      KillMode = "none";
      ExecStart = ''${swaybgRandom}/bin/swaybg-random ${lib.strings.escapeShellArg wpDir}'';
    };
  };

  systemd.user.timers."swaybg-random" = {
    Unit.Description = "Timer for swaybg-random";
    Timer = {
      OnBootSec = "10s";
      OnUnitActiveSec = "30m";
      Unit = "swaybg-random.service";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
