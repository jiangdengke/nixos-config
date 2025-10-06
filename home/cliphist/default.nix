{ pkgs, ... }:
{
  home.packages = [ pkgs.cliphist ];

  home.file.".local/bin/cliphist-rofi.sh" = {
    force = true;
    source = pkgs.replaceVars {
      src = ./cliphist-rofi.sh;
      replacements = {
        cliphist = "${pkgs.cliphist}/bin/cliphist";
        wl_copy = "${pkgs.wl-clipboard}/bin/wl-copy";
      };
    };
  };

  home.file.".local/bin/cliphist-daemon.sh" = {
    force = true;
    source = pkgs.replaceVars {
      src = ./cliphist-daemon.sh;
      replacements = {
        cliphist = "${pkgs.cliphist}/bin/cliphist";
        wl_paste = "${pkgs.wl-clipboard}/bin/wl-paste";
      };
    };
  };
}
