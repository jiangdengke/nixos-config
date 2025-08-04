{ config, pkgs, ... }:

{
  # 导入 i3status 配置
  imports = [
    ./i3status.nix
    ./picom.nix
  ];
  
# 创建一个漂亮的锁屏脚本
home.file.".local/bin/lock-screen.sh" = {
  executable = true;
  text = ''
    #!/bin/sh
    
    # 截取屏幕并应用模糊效果
    TMPBG="/tmp/screen.png"
    scrot "$TMPBG"
    convert "$TMPBG" -scale 10% -scale 1000% "$TMPBG"
    
    # 锁屏
    i3lock-color \
      --image="$TMPBG" \
      --ring-width=20 \
      --inside-color=00000000 \
      --ring-color=ffffffcc \
      --insidever-color=00000000 \
      --ringver-color=6272a4ff \
      --insidewrong-color=00000000 \
      --ringwrong-color=ff5555ff \
      --line-color=00000000 \
      --separator-color=00000000 \
      --keyhl-color=50fa7bff \
      --bshl-color=ff5555ff \
      --verif-color=6272a4ff \
      --wrong-color=ff5555ff \
      --layout-color=ffffffff \
      --time-color=ffffffff \
      --date-color=ffffffff \
      --greeter-color=ffffffff \
      --verif-text="验证中..." \
      --wrong-text="验证失败!" \
      --noinput-text="没有输入" \
      --lock-text="锁定中..." \
      --lockfailed-text="锁定失败！" \
      --time-str="%H:%M:%S" \
      --date-str="%Y-%m-%d 星期%a" \
      --greeter-text="欢迎回来，jdk" \
      -f
    
    # 删除临时文件
    rm "$TMPBG"
  '';
};
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
      terminal = "alacritty";
      
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
      bars = [  
      {
          position = "top";  # 将状态栏位置设置为顶部
          statusCommand = "${pkgs.i3status}/bin/i3status";  # 添加这一行
        }
      ];
       
      # 自动启动应用
      startup = [
  # 禁用屏幕保护和屏幕熄灭
  {
    command = "${pkgs.xorg.xset}/bin/xset s off -dpms";
    always = true;
    notification = false;
  }
    # 自动启动fcitx5
     {
    command = "$HOME/.local/bin/fcitx5-toggle.sh";
    always = false;
    notification = false;
  }
       # 自动启动flameshot
        {
          command = "${pkgs.flameshot}/bin/flameshot";
          notification = false;
          always = false;
        }
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
        
        {
          command = "${pkgs.variety}/bin/variety";
          notification = false;
          always = false;  # 只在 i3 首次启动时运行，而非每次重载配置
        }
      ];
      
      # 快捷键设置
      keybindings = {
        # 基本操作
        "${config.xsession.windowManager.i3.config.modifier}+Return" = "exec ${config.xsession.windowManager.i3.config.terminal}";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+q" = "kill";
        # 使用 vim 风格的 hjkl 键在窗口之间导航
        "${config.xsession.windowManager.i3.config.modifier}+h" = "focus left";
        "${config.xsession.windowManager.i3.config.modifier}+j" = "focus down";
        "${config.xsession.windowManager.i3.config.modifier}+k" = "focus up";
        "${config.xsession.windowManager.i3.config.modifier}+l" = "focus right";
        
        
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
        
        # 添加锁屏快捷键 (Mod+l)

        "${config.xsession.windowManager.i3.config.modifier}+Shift+l" = "exec --no-startup-id $HOME/.local/bin/lock-screen.sh";

        # 重新加载/重启 i3
        "${config.xsession.windowManager.i3.config.modifier}+Shift+c" = "reload";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+r" = "restart";
        # rofi
        "${config.xsession.windowManager.i3.config.modifier}+d" = "exec ${pkgs.bash}/bin/bash $HOME/.local/bin/toggle-rofi";

        # 亮度控制
        "XF86MonBrightnessUp" = "exec brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
        # Flameshot 截图快捷键
        "Ctrl+1" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui";
        
        # 直接调用贴图功能的快捷键（将最近的截图固定到屏幕）
        "Ctrl+Shift+1" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui --pin";
        
      };
      
 # 浮动窗口规则 - 让 Flameshot 的贴图窗口自动浮动
      floating = {
        criteria = [
          # 其他浮动窗口规则...
          { class = "flameshot"; }  # 让 Flameshot 的所有窗口浮动
        ];
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
    };
  };
  
  # 设置 DPI 和光标大小
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 140;
  };

  # 确保需要的软件包已安装
  home.packages = with pkgs; [
      i3lock-color
  xautolock
  scrot  # 用于截图
  imagemagick  # 用于处理图片
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
