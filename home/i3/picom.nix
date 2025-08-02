{ config, pkgs, ... }:

{
  # Picom 配置 (窗口透明度)
  services.picom = {
    enable = true;
    
    # 基本设置
    backend = "glx";  # 使用 GLX 后端，性能更好
    vSync = true;     # 启用垂直同步，减少画面撕裂
    
    # 透明度设置
    activeOpacity = 0.9;          # 活动窗口透明度 (1.0 = 完全不透明)
    inactiveOpacity = 0.9;        # 非活动窗口透明度
    menuOpacity = 0.95;           # 菜单透明度
    
    # 启用透明度规则
    opacityRules = [
      # 特定应用的透明度设置
      "60:class_g = 'kitty'"    # 终端透明度为 90%
      "85:class_g = 'URxvt'"        # URxvt 终端透明度为 85%
      "95:class_g = 'code-oss'"     # VSCode 透明度为 95%
      "90:class_g = 'Rofi'"         # Rofi 程序启动器透明度为 90%
      "100:class_g = 'Firefox'"     # Firefox 完全不透明
    ];
    
    # 淡入淡出效果
    fade = true;
    fadeDelta = 5;
    fadeSteps = [ 0.03 0.03 ];
    
    # 阴影设置
    shadow = true;
    shadowOpacity = 0.75;
    shadowOffsets = [ (-7) (-7) ];
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "_GTK_FRAME_EXTENTS@:c"
    ];
    
    # 高级设置 - 使用 settings 字段
    settings = {
      # 模糊效果
      blur = {
        method = "dual_kawase";
        strength = 5;
      };
      
      # 窗口圆角
      corner-radius = 10;
      
      # 高级透明度设置
      frame-opacity = 0.9;         # 窗口边框透明度
      inactive-opacity-override = false;
      detect-client-opacity = true;
      
      # 排除特定窗口类型的模糊效果
      blur-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
    };
  };
}
