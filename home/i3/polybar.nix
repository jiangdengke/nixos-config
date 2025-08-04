{ config, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
      githubSupport = true;
      mpdSupport = true;
      pulseSupport = true;
    };
    
    script = "polybar main &";
    
    config = {
      "colors" = {
        background = "#282A2E";
        background-alt = "#373B41";
        foreground = "#C5C8C6";
        primary = "#F0C674";
        secondary = "#8ABEB7";
        alert = "#A54242";
        disabled = "#707880";
        nixos = "#5277C3";
      };

      "bar/main" = {
        width = "100%";
        height = "28pt";
        radius = 6;

        background = "\${colors.background}";
        foreground = "\${colors.foreground}";

        line-size = "3pt";

        border-size = "4pt";
        border-color = "#00000000";

        padding-left = 1;
        padding-right = 1;

        module-margin = 1;

        separator = " ";
        separator-foreground = "\${colors.disabled}";

        # 添加 Font Awesome 和其他图标字体
        font-0 = "JetBrains Mono:size=10;3";
        font-1 = "Font Awesome 6 Free:style=Solid:size=10;3";
        font-2 = "Font Awesome 6 Free:style=Regular:size=10;3";
        font-3 = "Font Awesome 6 Brands:size=10;3";

        # 按照你的要求排列模块
        modules-left = "nixos-logo xworkspaces xwindow";
        modules-right = "cpu filesystem network running-apps pulseaudio date";

        cursor-click = "pointer";
        cursor-scroll = "ns-resize";

        enable-ipc = true;

        wm-restack = "i3";
      };

      # NixOS Logo 模块
      "module/nixos-logo" = {
        type = "custom/text";
        content = "%{T4} %{T-}";
        content-foreground = "\${colors.nixos}";
        click-left = "rofi -show drun";
      };

      "module/xworkspaces" = {
        type = "internal/xworkspaces";

        label-active = " %name% ";
        label-active-background = "\${colors.background-alt}";
        label-active-underline = "\${colors.primary}";
        label-active-padding = 1;

        label-occupied = " %name% ";
        label-occupied-padding = 1;

        label-urgent = " %name% ";
        label-urgent-background = "\${colors.alert}";
        label-urgent-padding = 1;

        label-empty = " %name% ";
        label-empty-foreground = "\${colors.disabled}";
        label-empty-padding = 1;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = " %{T2}%{T-} %title:0:50:...%";
        label-empty = " %{T2}%{T-} Desktop";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "%{T2}%{T-} ";
        format-prefix-foreground = "\${colors.primary}";
        label = "%percentage:2%%";
      };

      "module/filesystem" = {
        type = "internal/fs";
        interval = 25;

        mount-0 = "/";

        label-mounted = "%{T2}%{T-} %percentage_used%%";
        label-mounted-foreground = "\${colors.primary}";

        label-unmounted = "%{T2}%{T-} N/A";
        label-unmounted-foreground = "\${colors.disabled}";
      };

      "module/network" = {
        type = "internal/network";
        interface-type = "wireless";
        interval = 3;

        format-connected = "%{T2}%{T-} <label-connected>";
        format-connected-foreground = "\${colors.primary}";
        label-connected = "%essid%";

        format-disconnected = "%{T2}%{T-} <label-disconnected>";
        format-disconnected-foreground = "\${colors.alert}";
        label-disconnected = "Disconnected";

        # 如果没有无线网络，尝试有线网络
        format-packetloss = "%{T2}%{T-} <label-connected>";
      };

      # 以太网网络模块（备用）
      "module/network-eth" = {
        type = "internal/network";
        interface-type = "wired";
        interval = 3;

        format-connected = "%{T2}%{T-} <label-connected>";
        format-connected-foreground = "\${colors.primary}";
        label-connected = "Connected";

        format-disconnected = "";
      };

      # 运行的应用程序模块
      "module/running-apps" = {
        type = "custom/script";
        exec = "echo ' '$(ps aux | grep -E '(firefox|code|discord|telegram|spotify)' | grep -v grep | wc -l)";
        interval = 5;
        format = "<label>";
        label = "%output%";
        label-foreground = "\${colors.secondary}";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        format-volume = "%{T2}<ramp-volume>%{T-} <label-volume>";
        format-volume-foreground = "\${colors.primary}";
        label-volume = "%percentage%%";

        format-muted = "%{T2}%{T-} <label-muted>";
        format-muted-foreground = "\${colors.disabled}";
        label-muted = "Muted";

        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";

        click-right = "pavucontrol";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;

        date = "%H:%M";
        date-alt = "%Y-%m-%d %H:%M:%S";

        format = "%{T2}%{T-} <label>";
        format-foreground = "\${colors.primary}";
        label = "%date%";
      };

      "settings" = {
        screenchange-reload = true;
        pseudo-transparency = true;
      };
    };
  };

  # 确保字体可用
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    font-awesome
    jetbrains-mono
  ];

}
