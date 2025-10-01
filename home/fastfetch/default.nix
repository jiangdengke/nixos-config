{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;

    # 这就是写入 $XDG_CONFIG_HOME/fastfetch/config.jsonc 的内容
    settings = {
      # 简洁的模块顺序（带 Nerd Font 图标；不想要图标就删掉 key 里的小图标）
      modules = [
        { type = "os";       key = "  OS"; }
        { type = "kernel";   key = "  Kernel"; }
        { type = "uptime";   key = "󰍛  Uptime"; }
        { type = "packages"; key = "  Packages"; }
        { type = "shell";    key = "  Shell"; }
        { type = "wm";       key = "  WM"; }
        { type = "display";  key = "󱂬  Display"; }
        { type = "cpu";      key = "  CPU"; }
        { type = "gpu";      key = "󰢮  GPU"; }
        { type = "memory";   key = "  Memory"; }
        { type = "disk";     key = "  Disk"; folders = [ "/" ]; }
        { type = "battery";  key = "  Battery"; }
        { type = "colors"; }
      ];

      # 可选：小号 NixOS logo（安全起见默认先不设；如需可解开下面注释）
      # logo = { source = "nixos_small"; };
    };
  };
}

