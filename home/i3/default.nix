{
  pkgs,
  config,
  lib,
  ...
}: {
  # 使用 Home Manager 的原生 i3 配置
  xsession.windowManager.i3 = {
    enable = true;
    
    # 这里是您的 i3 配置，之前在 ./config 文件中
    config = {
      # 定义修饰键
      modifier = "Mod4"; # Super键 (Windows键)
      
      # 默认终端
      terminal = "kitty";
      
      # 窗口边框样式
      defaultWorkspace = "workspace number 1";
      
      # 窗口边框设置
      window = {
        border = 1;
        titlebar = false;
        hideEdgeBorders = "none";
      };
      
      # 窗口间距
      gaps = {
        inner = 14;
        outer = 0;
        smartGaps = true;
        smartBorders = "on";
      };
      
      # 焦点设置
      focus = {
        followMouse = true;
        mouseWarping = true;
        newWindow = "smart";
      };
      
      # 启动应用
      startup = [
        # 设置壁纸
        { command = "feh --bg-scale ${../../wallpaper.jpg}"; always = true; notification = false; }
        # 启动通知守护进程
        { command = "dunst"; always = false; notification = false; }
        # 启动输入法
        { command = "fcitx5 -d"; always = false; notification = false; }
        # 启动网络管理
        { command = "nm-applet"; always = false; notification = false; }
        # 其他您需要的启动程序
      ];
      
      # 键位绑定
      keybindings = lib.mkOptionDefault {
        # 基本操作
        "${config.xsession.windowManager.i3.config.modifier}+Return" = "exec ${config.xsession.windowManager.i3.config.terminal}";
        "${config.xsession.windowManager.i3.config.modifier}+q" = "kill";
        "${config.xsession.windowManager.i3.config.modifier}+d" = "exec rofi -show drun";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+c" = "reload";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+r" = "restart";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes, exit i3' 'i3-msg exit'";
        
        # 窗口操作
        "${config.xsession.windowManager.i3.config.modifier}+h" = "focus left";
        "${config.xsession.windowManager.i3.config.modifier}+j" = "focus down";
        "${config.xsession.windowManager.i3.config.modifier}+k" = "focus up";
        "${config.xsession.windowManager.i3.config.modifier}+l" = "focus right";
        
        "${config.xsession.windowManager.i3.config.modifier}+Shift+h" = "move left";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+j" = "move down";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+k" = "move up";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+l" = "move right";
        
        # 工作区切换
        "${config.xsession.windowManager.i3.config.modifier}+1" = "workspace number 1";
        "${config.xsession.windowManager.i3.config.modifier}+2" = "workspace number 2";
        "${config.xsession.windowManager.i3.config.modifier}+3" = "workspace number 3";
        "${config.xsession.windowManager.i3.config.modifier}+4" = "workspace number 4";
        "${config.xsession.windowManager.i3.config.modifier}+5" = "workspace number 5";
        "${config.xsession.windowManager.i3.config.modifier}+6" = "workspace number 6";
        "${config.xsession.windowManager.i3.config.modifier}+7" = "workspace number 7";
        "${config.xsession.windowManager.i3.config.modifier}+8" = "workspace number 8";
        "${config.xsession.windowManager.i3.config.modifier}+9" = "workspace number 9";
        "${config.xsession.windowManager.i3.config.modifier}+0" = "workspace number 10";
        
        # 移动窗口到工作区
        "${config.xsession.windowManager.i3.config.modifier}+Shift+1" = "move container to workspace number 1";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+2" = "move container to workspace number 2";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+3" = "move container to workspace number 3";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+4" = "move container to workspace number 4";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+5" = "move container to workspace number 5";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+6" = "move container to workspace number 6";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+7" = "move container to workspace number 7";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+8" = "move container to workspace number 8";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+9" = "move container to workspace number 9";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+0" = "move container to workspace number 10";
        
        # 布局控制
        "${config.xsession.windowManager.i3.config.modifier}+b" = "split h";
        "${config.xsession.windowManager.i3.config.modifier}+v" = "split v";
        "${config.xsession.windowManager.i3.config.modifier}+f" = "fullscreen toggle";
        "${config.xsession.windowManager.i3.config.modifier}+s" = "layout stacking";
        "${config.xsession.windowManager.i3.config.modifier}+w" = "layout tabbed";
        "${config.xsession.windowManager.i3.config.modifier}+e" = "layout toggle split";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+space" = "floating toggle";
        
        # 音量控制
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        
        # 亮度控制
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%-";
        
        # 截图
        "Print" = "exec --no-startup-id flameshot gui";
        
        # 其他您需要的键位绑定
      };
      
      # 颜色设置
      colors = {
        background = "#222222";
        focused = {
          border = "#4c7899";
          background = "#285577";
          text = "#ffffff";
          indicator = "#2e9ef4";
          childBorder = "#285577";
        };
        unfocused = {
          border = "#333333";
          background = "#222222";
          text = "#888888";
          indicator = "#292d2e";
          childBorder = "#222222";
        };
        urgent = {
          border = "#2f343a";
          background = "#900000";
          text = "#ffffff";
          indicator = "#900000";
          childBorder = "#900000";
        };
      };
      
      # 状态栏设置
      bars = [
        {
          position = "bottom";
          statusCommand = "i3status";
          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";
            
            focusedWorkspace = {
              border = "#4c7899";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }
      ];
    };
    
    # 额外配置
    extraConfig = ''
      # 这里可以添加任何无法用结构化配置表示的内容
      # 例如一些复杂的规则或自定义命令
    '';
  };
  
  # i3status 配置
  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      interval = 5;
    };
    
    modules = {
      "wireless _first_" = {
        position = 1;
        settings = {
          format_up = "W: (%quality at %essid) %ip";
          format_down = "W: down";
        };
      };
      
      "ethernet _first_" = {
        position = 2;
        settings = {
          format_up = "E: %ip (%speed)";
          format_down = "E: down";
        };
      };
      
      "battery all" = {
        position = 3;
        settings = {
          format = "%status %percentage %remaining";
        };
      };
      
      "disk /" = {
        position = 4;
        settings = {
          format = "%avail";
        };
      };
      
      "load" = {
        position = 5;
        settings = {
          format = "%1min";
        };
      };
      
      "memory" = {
        position = 6;
        settings = {
          format = "%used | %available";
          threshold_degraded = "1G";
          format_degraded = "MEMORY < %available";
        };
      };
      
      "tztime local" = {
        position = 7;
        settings = {
          format = "%Y-%m-%d %H:%M:%S";
        };
      };
    };
  };
  
  # 设置 DPI 和光标大小
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 140;
  };

  # 确保需要的软件包已安装
  home.packages = with pkgs; [
    i3status
    feh         # 设置壁纸
    dunst       # 通知守护程序
    rofi        # 应用启动器
    flameshot   # 截图工具
    brightnessctl # 亮度控制
    networkmanager_dmenu # 网络管理
  ];
}
