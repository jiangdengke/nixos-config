{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;

    settings = {
      logo = {
        source = "nixos";
        type = "auto";
        padding = {
          left = 2;
          right = 4;
        };
        height = 12;
        color = {
          "1" = "cyan";
          "2" = "blue";
        };
      };

      display = {
        separator = " ";
        color = {
          keys = "cyan";
          title = "blue";
        };
      };

      modules = [
        {
          type = "title";
          format = "{user-name-colored}@{host-name-colored}";
        }
        { type = "separator"; }
        {
          type = "os";
          key = " OS      ";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = " Kernel  ";
          keyColor = "cyan";
        }
        {
          type = "packages";
          key = " Packages";
          keyColor = "magenta";
        }
        {
          type = "shell";
          key = " Shell   ";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = " WM      ";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = " Terminal";
          keyColor = "green";
        }
        { type = "break"; }
        {
          type = "cpu";
          key = " CPU     ";
          keyColor = "red";
        }
        {
          type = "gpu";
          key = " GPU     ";
          keyColor = "yellow";
        }
        {
          type = "memory";
          key = " Memory  ";
          keyColor = "cyan";
        }
        {
          type = "disk";
          key = " Disk    ";
          keyColor = "magenta";
          folders = [ "/" ];
        }
        { type = "break"; }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
}
