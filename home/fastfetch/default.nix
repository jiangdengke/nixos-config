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
        height = 14;
        color = {
          "1" = "cyan";
          "2" = "blue";
        };
      };

      display = {
        separator = " : ";
      };

      modules = [
        {
          type = "title";
          key = "  ";
          keyColor = "blue";
          format = "{user-name}@{host-name}";
        }
        {
          type = "custom";
          format = "┌────────────────────────────────────────────┐";
        }
        {
          type = "os";
          key = "  󰣇 OS";
          keyColor = "cyan";
        }
        {
          type = "kernel";
          key = "   Kernel";
          keyColor = "cyan";
        }
        {
          type = "packages";
          key = "  󰏗 Packages";
          keyColor = "green";
        }
        {
          type = "shell";
          key = "   Shell";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "  󱗃 WM";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = "   Terminal";
          keyColor = "yellow";
        }
        {
          type = "display";
          key = "  󰍹 Display";
          keyColor = "green";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌────────────────────────────────────────────┐";
        }
        {
          type = "cpu";
          key = "   CPU";
          keyColor = "blue";
        }
        {
          type = "gpu";
          key = "  󰊴 GPU";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "   Memory";
          keyColor = "magenta";
        }
        {
          type = "disk";
          key = "  󱦟 Disk";
          keyColor = "magenta";
          folders = [ "/" ];
        }
        {
          type = "uptime";
          key = "  󱫐 Uptime";
          keyColor = "red";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
}
