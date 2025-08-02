{ config, pkgs, ... }:

{
  # i3status 配置
  programs.i3status = {
    enable = true;
    
    # 常规设置
    general = {
      colors = true;
      color_good = "#50FA7B";
      color_degraded = "#F1FA8C";
      color_bad = "#FF5555";
      interval = 5;
    };
    
    # 模块设置
    modules = {
      "disk /" = {
        position = 1;
        settings = {
          format = "💾 %avail";
        };
      };
      
      "cpu_usage" = {
        position = 2;
        settings = {
          format = "CPU: %usage";
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
}
