{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "small";
      };

      display = {
        separator = " 󱐋 ";
        key = {
          type = "icon";
          width = 14;
        };
        percent = {
          type = 2;
        };
      };

      modules = [
        {
          type = "title";
          key = "  Profile";
          keyColor = "38;5;183";
          format = "{user-name}@{host-name}";
        }
        "separator"
        {
          type = "os";
          key = "  System";
          keyColor = "38;5;147";
        }
        {
          type = "kernel";
          key = "  Kernel";
          keyColor = "38;5;111";
        }
        {
          type = "packages";
          key = "  Packages";
          keyColor = "38;5;147";
        }
        {
          type = "shell";
          key = "  Shell";
          keyColor = "38;5;183";
        }
        {
          type = "wm";
          key = "  WM";
          keyColor = "38;5;147";
        }
        {
          type = "de";
          key = "󰧨  Session";
          keyColor = "38;5;147";
        }
        {
          type = "uptime";
          key = "󰅐  Uptime";
          keyColor = "38;5;111";
        }
        "break"
        {
          type = "cpu";
          key = "  CPU";
          keyColor = "38;5;110";
        }
        {
          type = "gpu";
          key = "󰢮  GPU";
          keyColor = "38;5;183";
        }
        {
          type = "memory";
          key = "  Memory";
          keyColor = "38;5;147";
        }
        {
          type = "disk";
          key = "  Disk";
          keyColor = "38;5;111";
          folders = [ "/" ];
        }
        {
          type = "battery";
          key = "  Battery";
          keyColor = "38;5;183";
        }
        "break"
        {
          type = "media";
          key = "󰝚  Media";
          keyColor = "38;5;147";
        }
        {
          type = "localip";
          key = "󰣺  LAN";
          keyColor = "38;5;111";
          compact = true;
        }
        {
          type = "wifi";
          key = "  Wi-Fi";
          keyColor = "38;5;147";
          format = "{ssid}";
        }
        {
          type = "locale";
          key = "󰕣  Locale";
          keyColor = "38;5;183";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
}

