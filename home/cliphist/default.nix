{ pkgs, ... }:
{
  home.packages = [ pkgs.cliphist ];

  home.file.".local/bin/cliphist-rofi.sh" = {
    force = true;
    source = pkgs.substituteAll {
      src = ./cliphist-rofi.sh;
      cliphist = "${pkgs.cliphist}/bin/cliphist";
      wl_copy = "${pkgs.wl-clipboard}/bin/wl-copy";
    };
    executable = true;
  };

  home.file.".local/bin/cliphist-daemon.sh" = {
    force = true;
    source = pkgs.substituteAll {
      src = ./cliphist-daemon.sh;
      cliphist = "${pkgs.cliphist}/bin/cliphist";
      wl_paste = "${pkgs.wl-clipboard}/bin/wl-paste";
    };
    executable = true;
  };
}
