{ pkgs, ... }:
{
  home.packages = [ pkgs.cliphist ];

  home.file = {
    ".local/bin/cliphist-rofi.sh" = {
      force = true;
      source = ./cliphist-rofi.sh;
      executable = true;
    };

    ".local/bin/cliphist-daemon.sh" = {
      force = true;
      source = ./cliphist-daemon.sh;
      executable = true;
    };
  };
}
