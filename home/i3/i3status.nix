{ config, pkgs, ... }:

{
  # i3status 配置
  programs.i3status = {
    enable = true;
    
    # 常规设置
    general = {
      output_format = "i3bar";
      colors = true;
      interval = 5;
    };
    
    # 直接使用模块位置而不是 order 列表
    modules = {
      "cpu_usage" = {
        position = 1;  # 第一个位置
        settings = {
          format = "CPU: %usage";
        };
      };
      
      "memory" = {
        position = 2;  # 第二个位置
        settings = {
          format = "RAM: %used | %available";
        };
      };
      
      "disk /" = {
        position = 3;  # 第三个位置
        settings = {
          format = "Disk: %avail";
        };
      };
      
      "wireless _first_" = {
        position = 4;  # 第四个位置
        settings = {
          format_up = "WiFi: %essid %quality";
          format_down = "WiFi: down";
        };
      };
      
      "battery 0" = {
        position = 5;  # 第五个位置
        settings = {
          format = "Bat: %status %percentage";
          last_full_capacity = true;
        };
      };
      
      "tztime local" = {
        position = 6;  # 第六个位置
        settings = {
          format = "%Y-%m-%d %H:%M:%S";
        };
      };
    };
  };
}
