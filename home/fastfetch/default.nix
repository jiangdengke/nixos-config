{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;

    # 这就是写入 $XDG_CONFIG_HOME/fastfetch/config.jsonc 的内容
    settings = {
      logo = {
        source = "nixos"; # 指定用哪种logo；"auto" 默认自动识别，"none" 则不显示
        type = "kitty"; # "ascii" | "kitty" | "sixel" | "iterm" | "auto"
        padding = {
          left = 2;
          right = 1;
        }; # 左右留白
        height = 10;
      };
      # 简洁的模块顺序（带 Nerd Font 图标；不想要图标就删掉 key 里的小图标）
      modules = [
        {
          type = "os";
          key = "  OS";
        }
        {
          type = "host";
          key = "󰌢  Host";
        }
        {
          type = "kernel";
          key = "  Kernel";
        }
        {
          type = "uptime";
          key = "󰍛  Uptime";
        }
        {
          type = "packages";
          key = "  Packages";
        }
        {
          type = "shell";
          key = "  Shell";
        }
        {
          type = "wm";
          key = "  WM";
        }
        {
          type = "display";
          key = "󱂬  Display";
        }
        {
          type = "cpu";
          key = "  CPU";
        }
        {
          type = "temperature";
          key = "  Temp";
        }
        {
          type = "gpu";
          key = "󰢮  GPU";
        }
        {
          type = "memory";
          key = "  Memory";
        }
        {
          type = "disk";
          key = "  Disk";
          folders = [ "/" ];
        }
        {
          type = "battery";
          key = "  Battery";
        }
        { type = "colors"; }
      ];
    };
  };
}
