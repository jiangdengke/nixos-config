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
        separator = " ";
        key = {
          paddingLeft = 2;
          width = 12;
        };
      };


      modules = [
        {
          type = "title";
          key = "";
          keyColor = "blue";
          format = " {user-name}@{host-name}";
        }
        {
          type = "custom";
          format = "┌────────────────────────────────────────────┐";
        }
        {
          type = "os";
          key = "NixOS:";
          keyIcon = "";
          keyColor = "cyan";
          format = "{2}";
        }
        {
          type = "kernel";
          key = "Kernel:";
          keyIcon = "";
          keyColor = "cyan";
          format = "{2}";
        }
        {
          type = "packages";
          key = "Packages:";
          keyIcon = "";
          keyColor = "green";
        }
        {
          type = "shell";
          key = "Shell:";
          keyIcon = "";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "WM:";
          keyIcon = "";
          keyColor = "yellow";
          format = "{2}";
        }
        {
          type = "terminal";
          key = "Terminal:";
          keyIcon = "";
          keyColor = "yellow";
        }
        {
          type = "display";
          key = "Display:";
          keyIcon = "󰍹";
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
          key = "CPU:";
          keyIcon = "";
          keyColor = "blue";
          format = "{1} @ {7}";
        }
        {
          type = "gpu";
          key = "GPU:";
          keyIcon = "󰢮";
          keyColor = "blue";
          format = "{1} {2}";
        }
        {
          type = "memory";
          key = "Memory:";
          keyIcon = "󰍛";
          keyColor = "magenta";
        }
        {
          type = "disk";
          key = "Disk:";
          keyIcon = "󰋊";
          keyColor = "magenta";
          folders = [ "/" ];
        }
        {
          type = "uptime";
          key = "Uptime:";
          keyIcon = "";
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
