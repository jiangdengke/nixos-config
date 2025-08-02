{ config, pkgs, ... }:

{
  # 导入 i3status 配置
  imports = [
    ./i3status.nix
    ./picom.nix
  ];
  
  # i3 窗口管理器配置
  xsession.windowManager.i3 = {
    enable = true;
    
    # i3 包配置
    package = pkgs.i3;
    
    # i3 配置
    config = {
      # 修饰键 (Mod4 = Super 键/Windows 键)
      modifier = "Mod4";
      
      # 终端
      terminal = "kitty";
      
      # 窗口样式
      gaps = {
        inner = 5;
        outer = 5;
        smartGaps = true;
      };
      
      # 窗口边框
      window = {
        border = 1;
        titlebar = false;
      };
      
      # 自动启动应用
      startup = [
        # 自动启动 Picom
        {
          command = "picom -b";
          always = false;
          notification = false;
        }
        # 屏幕亮度调整
        {
          command = "brightnessctl set 70%";
          always = false;
          notification = false;
        }
      ];
      
      # 快捷键设置
      keybindings = {
        # 基本操作
        "${config.xsession.windowManager.i3.config.modifier}+Return" = "exec ${config.xsession.windowManager.i3.config.terminal}";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+q" = "kill";
        "${config.xsession.windowManager.i3.config.modifier}+d" = "exec rofi -show drun";
        
        # 窗口操作
        "${config.xsession.windowManager.i3.config.modifier}+Left" = "focus left";
        "${config.xsession.windowManager.i3.config.modifier}+Down" = "focus down";
        "${config.xsession.windowManager.i3.config.modifier}+Up" = "focus up";
        "${config.xsession.windowManager.i3.config.modifier}+Right" = "focus right";
        
        "${config.xsession.windowManager.i3.config.modifier}+Shift+Left" = "move left";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+Down" = "move down";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+Up" = "move up";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+Right" = "move right";
        
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
        
        # 重新加载/重启 i3
        "${config.xsession.windowManager.i3.config.modifier}+Shift+c" = "reload";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+r" = "restart";
        
        # 亮度控制
        "XF86MonBrightnessUp" = "exec brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
        
        # 截图
        "Print" = "exec flameshot gui";
        "${config.xsession.windowManager.i3.config.modifier}+Print" = "exec flameshot full -p ~/Pictures/Screenshots";
      };
      
      # 窗口规则
      assigns = {
        "1" = [{ class = "^Firefox$"; }];
        "2" = [{ class = "^code-oss$"; }];
      };
      
      window.commands = [
        { command = "border pixel 1"; criteria = { class = "^.*"; }; }
        { command = "floating enable"; criteria = { class = "^Pavucontrol$"; }; }
      ];
      
      # 栏配置
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = [ "DejaVu Sans Mono" "FontAwesome 10" ];
            size = 10.0;
          };
          colors = {
            background = "#282A36";
            statusline = "#F8F8F2";
            separator = "#44475A";
            focusedWorkspace = { background = "#44475A"; border = "#44475A"; text = "#F8F8F2"; };
            activeWorkspace = { background = "#282A36"; border = "#44475A"; text = "#F8F8F2"; };
            inactiveWorkspace = { background = "#282A36"; border = "#282A36"; text = "#BFBFBF"; };
            urgentWorkspace = { background = "#FF5555"; border = "#FF5555"; text = "#F8F8F2"; };
            bindingMode = { background = "#FF5555"; border = "#FF5555"; text = "#F8F8F2"; };
          };
        }
      ];
      
      # 颜色主题
      colors = {
        focused = { background = "#6272A4"; border = "#6272A4"; childBorder = "#6272A4"; indicator = "#6272A4"; text = "#F8F8F2"; };
        focusedInactive = { background = "#44475A"; border = "#44475A"; childBorder = "#44475A"; indicator = "#44475A"; text = "#F8F8F2"; };
        unfocused = { background = "#282A36"; border = "#282A36"; childBorder = "#282A36"; indicator = "#282A36"; text = "#BFBFBF"; };
        urgent = { background = "#FF5555"; border = "#FF5555"; childBorder = "#FF5555"; indicator = "#FF5555"; text = "#F8F8F2"; };
        placeholder = { background = "#282A36"; border = "#282A36"; childBorder = "#282A36"; indicator = "#282A36"; text = "#F8F8F2"; };
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
    picom       # 窗口合成器 (透明效果)
  ];
  
}
